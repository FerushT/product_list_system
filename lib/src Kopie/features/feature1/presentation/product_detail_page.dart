import 'package:flutter/material.dart';
import 'package:product_list_system/src%20Kopie/data/product.dart';
import 'package:provider/provider.dart'; // Provider hilft mir, den Zustand des Warenkorbs zu verwalten.
import 'cart.dart'; // Importiere die Cart-Klasse

class ProductDetailPage extends StatefulWidget {
  final Product
      product; // Hier speichere ich das Produkt, das ich in den Details anzeigen möchte.

  const ProductDetailPage({super.key, required this.product});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late int
      availability; // Variable, um die aktuelle Verfügbarkeit des Produkts zu speichern

  @override
  void initState() {
    super.initState();
    availability = widget.product.availability; // Verfügbarkeit initialisieren
  }

  void _addToCart() {
    if (availability > 0) {
      setState(() {
        availability--; // Verfügbarkeit um 1 verringern
      });
      Provider.of<Cart>(context, listen: false)
          .addToCart(widget.product); // Produkt in den Warenkorb legen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.product.title, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            Text(widget.product.description),
            const SizedBox(height: 10),
            Text(
                "Preis: €${widget.product.price.toStringAsFixed(2)}"), // Preis mit zwei Nachkommastellen
            const SizedBox(height: 10),
            Text("Verfügbarkeit: $availability"), // Aktuelle Verfügbarkeit
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: availability > 0
                  ? _addToCart
                  : null, // Button deaktivieren, wenn ausverkauft
              child: Text(availability > 0
                  ? "In den Warenkorb"
                  : "Ausverkauft"), // Button-Text
            ),
          ],
        ),
      ),
    );
  }
}
