import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(() => NavigationBar(
        height: 70,
        elevation: 0,
        selectedIndex: controller.selectedIndex.value,
        onDestinationSelected: (index) => controller.selectedIndex.value = index,
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Juice'),
          NavigationDestination(icon: Icon(Iconsax.heart), label: 'Food'),
          // NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
          NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
        ],
      )),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final List<Widget> screens = [
    HomePage(),
    Container(color: Colors.purple),
    // Container(color: Colors.orange),
    Container(color: Colors.blue),
  ];
}
