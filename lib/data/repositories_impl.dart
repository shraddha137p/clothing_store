import '../domain/entities.dart';
import '../domain/repositories.dart';
import 'local_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
	ProductRepositoryImpl(this.dataSource);

	final ProductLocalDataSource dataSource;

	@override
	Future<List<Product>> getProducts() => dataSource.getProducts();
}

class ShoppingRepositoryImpl implements ShoppingRepository {
	ShoppingRepositoryImpl(this.dataSource);

	final ShoppingLocalDataSource dataSource;

	@override
	Future<List<Product>> getWatchlist() async => dataSource.getWatchlist();

	@override
	Future<void> addToWatchlist(Product product) async =>
			dataSource.addToWatchlist(product);

	@override
	Future<void> removeFromWatchlist(int productId) async =>
			dataSource.removeFromWatchlist(productId);

	@override
	Future<List<CartLine>> getCart() async => dataSource.getCart();

	@override
	Future<void> addToCart(Product product) async => dataSource.addToCart(product);

	@override
	Future<void> removeFromCart(int productId) async =>
			dataSource.removeFromCart(productId);

	@override
	Future<void> updateCartQuantity(int productId, int quantity) async =>
			dataSource.updateCartQuantity(productId, quantity);

	@override
	Future<void> clearCart() async => dataSource.clearCart();
}
