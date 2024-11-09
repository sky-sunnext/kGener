import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:provider/provider.dart";
import "package:nester/nester.dart";
import "package:rhttp/rhttp.dart";
import "package:http/http.dart";
import "package:bloc/bloc.dart";
import "package:flutter_riverpod/flutter_riverpod.dart" show ProviderScope;
import "package:dio/dio.dart";
import "package:dio_compatibility_layer/dio_compatibility_layer.dart";
import "package:responsive_builder/responsive_builder.dart";
import "package:responsive_framework/responsive_framework.dart";
import "package:adaptive_theme/adaptive_theme.dart";
import "package:just_audio_media_kit/just_audio_media_kit.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:i18n_extension/i18n_extension.dart";
import "package:fvp/fvp.dart" as fvp;

import "package:talker/talker.dart";
import "package:talker_riverpod_logger/talker_riverpod_logger.dart";
import "package:talker_dio_logger/talker_dio_logger.dart";
import "package:talker_bloc_logger/talker_bloc_logger.dart";

import "./router.dart" show getRouter;
import "./i18n/strings.g.dart";

Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();

	SystemChrome.setSystemUIOverlayStyle(
		const SystemUiOverlayStyle(
			statusBarColor: Colors.transparent
		)
	);

	await Rhttp.init();
	final List<Provider> providers = [];

	fvp.registerWith();

	JustAudioMediaKit.prefetchPlaylist = true;
	JustAudioMediaKit.ensureInitialized(
		windows: false,
		linux: true,
		iOS: false,
		android: false,
		macOS: false
	);

	/*
	@ Talker
	*/
	final talker = Talker(
		settings: TalkerSettings(
			enabled: true
		),
		logger: TalkerLogger()
	);
	providers.add(Provider<Talker>.value(value: talker));

	final Client compatibleClient = await RhttpCompatibleClient.create();

	/*
	@ Dio
	*/
	final dioAdapter = ConversionLayerAdapter(compatibleClient);
	const talkerDioLoggerSettings = TalkerDioLoggerSettings(
		printRequestHeaders: true,
		printRequestData: true,
		printResponseHeaders: true,
		printResponseData: true,
		printErrorHeaders: true,
		printErrorData: true
	);
	final dio = Dio();
	dio.httpClientAdapter = dioAdapter;
	dio.interceptors.addAll([
		TalkerDioLogger(settings: talkerDioLoggerSettings, talker: talker)
	]);
	providers.add(Provider<Dio>.value(value: dio));

	/*
	@ Bloc
	*/
	const talkerBlocLoggerSettings = TalkerBlocLoggerSettings(
		enabled: true
	);
	Bloc.observer = TalkerBlocObserver(
		settings: talkerBlocLoggerSettings,
		talker: talker
	);

	/*
	@ Riverpod
	*/
	final talkerRiverpodObserver = TalkerRiverpodObserver(
		talker: talker
	);
	providers.add(Provider<TalkerRiverpodObserver>
		.value(value: talkerRiverpodObserver));

	runWithClient(
		mainWithClient(providers),
		() => compatibleClient
	);
}

mainWithClient(List<Provider> providers) {
	LocaleSettings.useDeviceLocale();

	final breakpoints = <String, Breakpoint>{
		MOBILE: const Breakpoint(start: 0, end: 450),
		TABLET: const Breakpoint(start: 451, end: 800),
		DESKTOP: const Breakpoint(start: 801, end: double.infinity)
	};

	ResponsiveSizingConfig.instance.setCustomBreakpoints(
		ScreenBreakpoints(
			watch: breakpoints[MOBILE]!.start,
			tablet: breakpoints[TABLET]!.start,
			desktop: breakpoints[DESKTOP]!.start,
		)
	);

	final List<Widget Function(Widget)> nesters = [
		(next) => MultiProvider(
			providers: providers,
			builder: (context, child) =>
				ProviderScope(
					observers: [
						context.read<TalkerRiverpodObserver>()
					],
					child: child!,
				),
			child: next
		),
		(next) => ResponsiveBreakpoints.builder(
			breakpoints: breakpoints.keys
				.map((platform) => breakpoints[platform]!.copyWith(
					name: platform
				))
				.toList(),
			child: next
		),
		(next) => TranslationProvider(child: next),
		(_) => const KGenerApp()
	];

	return () => runApp(Nester.list(nesters));
}

class KGenerApp extends StatelessWidget {
	const KGenerApp({ super.key });

	@override
	Widget build(BuildContext context) {
		return AdaptiveTheme(
			light: ThemeData.light(useMaterial3: true),
			dark: ThemeData.dark(useMaterial3: true),
			initial: AdaptiveThemeMode.system,
			builder: (lightTheme, darkTheme) =>
				MaterialApp.router(
					theme: lightTheme,
					darkTheme: darkTheme,
					routerConfig: getRouter(),
					locale: TranslationProvider.of(context).flutterLocale,
					supportedLocales: AppLocaleUtils.supportedLocales,
					localizationsDelegates: GlobalMaterialLocalizations.delegates,
					builder: (context, child) => appBuilder(context, child!),
				),
		);
	}

	Widget appBuilder(BuildContext context, Widget child) {
		return Nester.list([
			(next) => I18n(
				child: next
			),
			(_) => child
		]);
	}
}