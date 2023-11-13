import 'package:eco_buy/screens/web_side/add_products.dart';
import 'package:eco_buy/screens/web_side/cart_items.dart';
import 'package:eco_buy/screens/web_side/dashboard_screen.dart';
import 'package:eco_buy/screens/web_side/delete_products.dart';
import 'package:eco_buy/screens/web_side/update_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class WebAdminScreen extends StatefulWidget {
  static const String id = "webadminscreen";

  @override
  State<WebAdminScreen> createState() => _WebAdminScreenState();
}

class _WebAdminScreenState extends State<WebAdminScreen> {
  Widget selectedScreen = const DashboardScreen();

  chooseScreen(item) {
    switch (item.route) {
      case DashboardScreen.id:
        setState(() {
          selectedScreen = DashboardScreen();
        });
        break;
      case AddProductsScreen.id:
        setState(() {
          selectedScreen = AddProductsScreen();
        });
        break;
      case UpdateProductsScreen.id:
        setState(() {
          selectedScreen = UpdateProductsScreen();
        });
        break;
      case DeleteProductScreen.id:
        setState(() {
          selectedScreen = DeleteProductScreen();
        });
        break;
      case CartItemsScreen.id:
        setState(() {
          selectedScreen = CartItemsScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('ADMIN'),
        ),
        sideBar: SideBar(
          width: 350,
          textStyle: TextStyle(fontSize: 20, color: Colors.white),
          backgroundColor: Colors.black,
          selectedRoute: WebAdminScreen.id,
          onSelected: (route) {
            chooseScreen(route);
          },
          items: const [
            AdminMenuItem(
                title: 'DASHBOARD',
                icon: Icons.dashboard,
                route: DashboardScreen.id),
            AdminMenuItem(
                title: 'ADD PRODUCTS',
                icon: Icons.add,
                route: AddProductsScreen.id),
            AdminMenuItem(
                title: 'UPDATE PRODUCTS',
                icon: Icons.update_sharp,
                route: UpdateProductsScreen.id),
            AdminMenuItem(
                title: 'DELETE PRODUCTS',
                icon: Icons.delete,
                route: DeleteProductScreen.id),
            AdminMenuItem(
                title: 'CART ITEMS',
                icon: Icons.shopping_cart_checkout,
                route: CartItemsScreen.id),
          ],
        ),
        body: selectedScreen);
  }
}
