import "package:go_router/go_router.dart";

import "./pages/main/main.dart" show MainPage;

final routes = <GoRoute>[
	GoRoute(path: "/", builder: (c, s) => const MainPage())
];

getRouter() => GoRouter(
	routes: routes
);
