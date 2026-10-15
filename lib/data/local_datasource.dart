import 'dart:convert';

import 'package:flutter/services.dart';

import 'models.dart';
import '../domain/entities.dart';

class ProductLocalDataSource {
	Future<List<ProductModel>> getProducts() async {
		final jsonString = await rootBundle.loadString('assets/products.json');
		final decoded = jsonDecode(jsonString) as List<dynamic>;
		return decoded
				.map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
				.toList();
	}
}

class ShoppingLocalDataSource {
	final Map<int, Product> _watchlist = {};
	final Map<int, CartLine> _cart = {};

	List<Product> getWatchlist() => List.unmodifiable(_watchlist.values);

	void addToWatchlist(Product product) => _watchlist[product.id] = product;

	void removeFromWatchlist(int id) => _watchlist.remove(id);

	List<CartLine> getCart() => List.unmodifiable(_cart.values);

	void addToCart(Product product) {
		final line = _cart[product.id];
		_cart[product.id] = CartLine(
			product: product,
			quantity: (line?.quantity ?? 0) + 1,
		);
	}

	void removeFromCart(int id) => _cart.remove(id);

	void updateCartQuantity(int id, int quantity) {
		final line = _cart[id];
		if (line == null) return;
		if (quantity < 1) {
			_cart.remove(id);
		} else {
			_cart[id] = CartLine(product: line.product, quantity: quantity);
		}
	}

	void clearCart() => _cart.clear();
}
