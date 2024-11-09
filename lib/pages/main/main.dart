import "package:flutter/material.dart";
import "package:iconic/iconic.dart";
import "package:kgener/i18n/i18n.dart";
// import "package:i18n_extension/default.i18n.dart";

import "./pages/home/main.dart" show HomePage;
import "./pages/list/main.dart" show ListPage;
import "./pages/poly/main.dart" show PolyPage;

class MainPage extends StatefulWidget {
	const MainPage({ super.key });

	@override
	createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
	late final PageController pageController;

	static const pagesMap = <Widget>[
		HomePage(),
		ListPage(),
		PolyPage()
	];
	late final btmNavItems = <BottomNavigationBarItem>[
		BottomNavigationBarItem(
			icon: const Icon(Iconic.home),
			activeIcon: const Icon(Iconic.home_bold),
			label: t.pages.home.title
		),
		BottomNavigationBarItem(
			icon: const Icon(Iconic.document),
			activeIcon: const Icon(Iconic.document_bold),
			label: t.pages.list.title
		),
		BottomNavigationBarItem(
			icon: const Icon(Iconic.apps),
			activeIcon: const Icon(Iconic.apps_bold),
			label: t.pages.poly.title
		)
	];
	int currentIndex = 0;

	@override
	void initState() {
		super.initState();
		assert(btmNavItems.length == pagesMap.length);

		pageController = PageController();
	}

	@override
	void dispose() {
		pageController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Stack(
				children: [
					Positioned.fill(
						child: PageView.builder(
							controller: pageController,
							physics: const NeverScrollableScrollPhysics(),
							itemCount: pagesMap.length,
							itemBuilder: (context, index) {
								return pagesMap.elementAt(index);
							},
							onPageChanged: (index) => setState(() {
								currentIndex = index;
							}),
						)
					)
				],
			),
			bottomNavigationBar: BottomNavigationBar(
				items: btmNavItems,
				currentIndex: currentIndex,
				onTap: (index) {
					pageController.animateToPage(
						index,
						duration: const Duration(milliseconds: 350),
						curve: Curves.easeInOutQuart
					);
				}
			),
		);
	}
}