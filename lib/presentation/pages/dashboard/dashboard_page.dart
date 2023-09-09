import 'package:flutter/material.dart';
import 'package:flutter_store_fic7/utils/images.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final pageController = PageController();
  var currentIndex = 0;
  var pages = const <Widget>[
    Center(child: Text('Home')),
    Center(child: Text('Order')),
    Center(child: Text('More')),
  ];

  BottomNavigationBarItem barItem(String icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        icon,
        color: index == currentIndex
            ? Theme.of(context).primaryColor
            : Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
        height: 25.0,
        width: 25.0,
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).textTheme.bodyLarge!.color,
        showUnselectedLabels: true,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          barItem(Images.homeImage, 'Home', 0),
          barItem(Images.shoppingImage, 'Orders', 1),
          barItem(Images.moreImage, 'More', 2),
        ],
        onTap: (index) {
          setState(() {
            pageController.jumpToPage(index);
            currentIndex = index;
          });
        },
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: pages.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => pages[index],
      ),
    );
  }
}
