import "package:flutter/material.dart";

class HomePage extends StatelessWidget {
	const HomePage({ super.key });

	@override
	Widget build(BuildContext context) {
		return const CustomScrollView(
			slivers: [
				SliverAppBar(
					title: Text("kGener"),
				)
			],
		);
	}
}