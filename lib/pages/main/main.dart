import "package:flutter/material.dart";

class MainPage extends StatefulWidget {
	const MainPage({ super.key });

	@override
	createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
	late final PageController pageController;

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

	static const pagesMap = <Widget>[

	];
	static final btmNavItems = <BottomNavigationBarItem>[
		BottomNavigationBarItem()
	];
	int currentIndex = 0;

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
							onPageChanged: (index) {
								currentIndex = index;
							},
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
						curve: Curves.bounceInOut
					);
				}
			),
		);
	}
}