///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsZhCn implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZhCn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.zhCn,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-CN>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsZhCn _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsPagesZhCn pages = _TranslationsPagesZhCn._(_root);
}

// Path: pages
class _TranslationsPagesZhCn implements TranslationsPagesEn {
	_TranslationsPagesZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPagesHomeZhCn home = _TranslationsPagesHomeZhCn._(_root);
	@override late final _TranslationsPagesListZhCn list = _TranslationsPagesListZhCn._(_root);
	@override late final _TranslationsPagesPolyZhCn poly = _TranslationsPagesPolyZhCn._(_root);
}

// Path: pages.home
class _TranslationsPagesHomeZhCn implements TranslationsPagesHomeEn {
	_TranslationsPagesHomeZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '首页';
}

// Path: pages.list
class _TranslationsPagesListZhCn implements TranslationsPagesListEn {
	_TranslationsPagesListZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '合集';
}

// Path: pages.poly
class _TranslationsPagesPolyZhCn implements TranslationsPagesPolyEn {
	_TranslationsPagesPolyZhCn._(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '聚合';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsZhCn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'pages.home.title': return '首页';
			case 'pages.list.title': return '合集';
			case 'pages.poly.title': return '聚合';
			default: return null;
		}
	}
}

