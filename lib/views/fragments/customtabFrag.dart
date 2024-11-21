import 'package:flutter/material.dart';

class CustomTabFragment extends StatelessWidget {
  final List<String> tabTitles;
  final List<Widget> tabContent;
  final double? tabBodyHeight;

  const CustomTabFragment({
    Key? key,
    required this.tabTitles,
    required this.tabContent,
    this.tabBodyHeight, // Initialize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(tabTitles.length == tabContent.length,
        "The number of tab titles must match the number of tab content widgets.");

    return DefaultTabController(
      length: tabTitles.length,
      child: Column(
        children: [
          // Tab Bar
          Container(
            color: Colors.blue, // Customize background color of the TabBar
            child: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[300],
              indicatorColor: Colors.white,
              tabs: tabTitles.map((title) => Tab(text: title)).toList(),
            ),
          ),
          // Tab Bar Views
          // Tab Bar Views
          tabBodyHeight != null
              ? SizedBox(
                  height: tabBodyHeight, // Use custom height if provided
                  child: TabBarView(
                    children: tabContent,
                  ),
                )
              : Expanded(
                  child: TabBarView(
                    children: tabContent,
                  ),
                ),
        ],
      ),
    );
  }
}
