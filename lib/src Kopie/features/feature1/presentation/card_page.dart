import 'package:flutter/material.dart';
import 'package:product_list_system/src%20Kopie/features/feature1/presentation/cart.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ich benutze Provider, um auf den Warenkorb zuzugreifen
    final cart = Provider.of<Cart>(context);

    // Wenn der Warenkorb leer ist, zeige eine Nachricht an
    if (cart.items.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Warenkorb"),
        ),
        body: const Center(
            child: Text(
                "Ihr Warenkorb ist leer.")), // Nachricht, wenn der Warenkorb leer ist
      );
    }

    // Wenn der Warenkorb nicht leer ist, zeige die Warenkorb-Inhalte an
    return Scaffold(
      appBar: AppBar(
        title: const Text("Warenkorb"),
        actions: [
          // Hier kann ich Aktionen hinzufügen, wie z.B. einen Button zum Leeren des Warenkorbs
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              cart.clearCart(); // Wenn ich auf das Symbol klicke, wird der ganze Warenkorb geleert.
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              // Ich benutze ListView.builder, um die Produkte im Warenkorb anzuzeigen.
              itemCount: cart.items.length, // Anzahl der Produkte im Warenkorb.
              itemBuilder: (context, index) {
                // Für jedes Produkt im Warenkorb erstelle ich eine ListTile.
                final product = cart.items.keys
                    .toList()[index]; // Das Produkt aus den Keys der items.
                final quantity =
                    cart.items[product]; // Die Menge dieses Produkts.

                return ListTile(
                  title: Text(product.title),
                  subtitle: Text("Anzahl: $quantity"),
                  trailing: Text(
                      "€${(product.price * quantity!).toStringAsFixed(2)}"), // Preis für die Menge.
                  leading: IconButton(
                    icon: const Icon(Icons
                        .remove), // Ein Knopf, um das Produkt zu entfernen.
                    color: Colors.red,
                    onPressed: () {
                      cart.removeFromCart(
                          product); // Produkt aus dem Warenkorb entfernen.
                    },
                  ),
                );
              },
            ),
          ),
          // Unten zeige ich den Gesamtpreis der Produkte im Warenkorb an.
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Gesamtpreis: €${cart.totalPrice.toStringAsFixed(2)}", // Gesamtpreis des Warenkorbs.
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
