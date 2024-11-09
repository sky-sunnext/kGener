import "package:flutter/material.dart";

class PolyPage extends StatelessWidget {
	const PolyPage({ super.key });

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