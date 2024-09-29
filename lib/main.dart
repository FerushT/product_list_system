import 'package:flutter/material.dart';
import 'package:product_list_system/src%20Kopie/features/feature1/presentation/card_page.dart';
import 'package:product_list_system/src%20Kopie/features/feature1/presentation/cart.dart';
import 'package:product_list_system/src%20Kopie/features/feature1/presentation/product_Overview_page.dart';
import 'package:provider/provider.dart'; // Mit Provider sorge ich dafür, dass ich den Warenkorb überall in der App benutzen kann.

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          Cart(), // Hier erstelle ich den Warenkorb, der beobachtet, was hineingelegt oder herausgenommen wird.
      child:
          const MyApp(), // Hier starte ich die App und mache den Warenkorb überall nutzbar.
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: "Warenkorb App",

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          const ProductOverviewPage(), // Hier sorge ich dafür, dass die App auf der Produktübersichtsseite startet.
      routes: {
        "/cart": (context) =>
            const CartPage(), // Ich lege fest, dass der Warenkorb über die Route "/cart" aufgerufen wird.
      },
    );
  }
}
