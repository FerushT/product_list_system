import 'package:flutter/foundation.dart';
import '../../../data/product.dart';

class Cart with ChangeNotifier {
  // Ich erstelle eine neue Klasse für den Warenkorb und verwende "ChangeNotifier", damit andere Teile der App über Änderungen informiert werden können.

  final Map<Product, int> _items = {};
  // Ich erstelle eine Liste (Map), in der ich die Produkte speichere. Jedes Produkt hat eine Anzahl, wie oft es im Warenkorb ist.

  Map<Product, int> get items => _items;
  // Hier kann ich nachschauen, welche Produkte gerade im Warenkorb sind.

  void addToCart(Product product) {
    // Diese Funktion fügt ein Produkt in den Warenkorb hinzu.
    if (product.availability > 0) {
      // Zuerst schaue ich, ob das Produkt noch verfügbar ist (also nicht ausverkauft ist).
      if (_items.containsKey(product)) {
        // Wenn das Produkt bereits im Warenkorb ist, erhöhe ich die Anzahl um 1.
        _items[product] = _items[product]! + 1;
      } else {
        // Wenn das Produkt noch nicht im Warenkorb ist, füge ich es mit einer Anzahl von 1 hinzu.
        _items[product] = 1;
      }
      product.availability--;
      // Jedes Mal, wenn ich ein Produkt in den Warenkorb lege, verringere ich seine Verfügbarkeit.
      notifyListeners();
      // Ich sage allen anderen Teilen der App Bescheid, dass sich der Warenkorb geändert hat.
    }
  }

  void removeFromCart(Product product) {
    // Diese Funktion entfernt ein Produkt aus dem Warenkorb.
    if (_items.containsKey(product)) {
      // Zuerst schaue ich, ob das Produkt überhaupt im Warenkorb ist.
      if (_items[product]! > 1) {
        // Wenn ich mehr als eines von diesem Produkt im Warenkorb habe,verringere ich die Anzahl um 1.
        _items.update(product, (existingQuantity) => existingQuantity - 1);
      } else {
        // Wenn nur noch eins im Warenkorb ist, entferne ich das Produkt komplett.
        _items.remove(product);
      }
      product.availability++;
      // Jedes Mal, wenn ich ein Produkt aus dem Warenkorb entferne,
      // erhöhe ich seine Verfügbarkeit um 1.
      notifyListeners();
      // Ich sage wieder allen anderen Teilen der App Bescheid, dass sich der Warenkorb geändert hat.
    }
  }

  void clearCart() {
    // Diese Funktion leert den gesamten Warenkorb.
    _items.forEach((product, quantity) {
      product.availability += quantity;
      // Für jedes Produkt im Warenkorb erhöhe ich seine Verfügbarkeit entsprechend.
    });
    _items.clear();
    // Danach lösche ich alle Produkte aus dem Warenkorb.
    notifyListeners();
    // Ich sage allen Bescheid, dass der Warenkorb jetzt leer ist.
  }

  double get totalPrice {
    // Diese Funktion berechnet den Gesamtpreis des Warenkorbs.
    return _items.entries
        .map((entry) => entry.key.price * entry.value)
        // Ich nehme jedes Produkt im Warenkorb und multipliziere seinen Preis mit der Menge.
        .fold(0.0, (previousValue, element) => previousValue + element);
    // Dann summiere ich alle diese Werte, um den Gesamtpreis zu bekommen.
  }
}
