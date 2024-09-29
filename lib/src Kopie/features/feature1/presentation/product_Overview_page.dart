import 'package:flutter/material.dart';
import 'package:product_list_system/src%20Kopie/data/product_list.dart';
import 'package:product_list_system/src%20Kopie/features/feature1/presentation/product_detail_page.dart';

class ProductOverviewPage extends StatelessWidget {
  const ProductOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produkte"),
        actions: [
          IconButton(
            icon: const Icon(Icons
                .shopping_cart), // Ein Knopf, der aussieht wie ein Einkaufswagen.
            onPressed: () {
              Navigator.pushNamed(context, '/cart'); // Navigiere zur CartPage
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length, // Ich sage, wie viele Produkte ich habe.
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].title),
            subtitle: Text(products[index].description),
            trailing: Text(
                "€${products[index].price.toStringAsFixed(2)}"), // trailing zeigt mir den Preis des Produkts auf 2 Stellen nach dem Komma.
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                    product: products[
                        index], // Ich übergebe das aktuelle Produkt zur Detailseite.
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
