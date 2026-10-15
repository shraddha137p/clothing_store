import 'entities.dart';

abstract interface class ProductRepository {
	Future<List<Product>> getProducts();
}

abstract interface class ShoppingRepository {
	Future<List<Product>> getWatchlist();
	Future<void> addToWatchlist(Product product);
	Future<void> removeFromWatchlist(int productId);
	Future<List<CartLine>> getCart();
	Future<void> addToCart(Product product);
	Future<void> removeFromCart(int productId);
	Future<void> updateCartQuantity(int productId, int quantity);
	Future<void> clearCart();
}
