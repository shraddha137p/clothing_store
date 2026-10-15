import 'dart:math';

import 'entities.dart';
import 'repositories.dart';

class GetProductsUseCase {
	const GetProductsUseCase(this.repository);
	final ProductRepository repository;
	Future<List<Product>> call() => repository.getProducts();
}

class GetWatchlistUseCase {
	const GetWatchlistUseCase(this.repository);
	final ShoppingRepository repository;
	Future<List<Product>> call() => repository.getWatchlist();
}

class AddToWatchlistUseCase {
	const AddToWatchlistUseCase(this.repository);
	final ShoppingRepository repository;
	Future<void> call(Product product) => repository.addToWatchlist(product);
}

class RemoveFromWatchlistUseCase {
	const RemoveFromWatchlistUseCase(this.repository);
	final ShoppingRepository repository;
	Future<void> call(int productId) => repository.removeFromWatchlist(productId);
}

class GetCartUseCase {
	const GetCartUseCase(this.repository);
	final ShoppingRepository repository;
	Future<List<CartLine>> call() => repository.getCart();
}

class AddToCartUseCase {
	const AddToCartUseCase(this.repository);
	final ShoppingRepository repository;
	Future<void> call(Product product) => repository.addToCart(product);
}

class RemoveFromCartUseCase {
	const RemoveFromCartUseCase(this.repository);
	final ShoppingRepository repository;
	Future<void> call(int productId) => repository.removeFromCart(productId);
}

class UpdateCartQuantityUseCase {
	const UpdateCartQuantityUseCase(this.repository);
	final ShoppingRepository repository;
	Future<void> call(int productId, int quantity) =>
			repository.updateCartQuantity(productId, quantity);
}

class ClearCartUseCase {
	const ClearCartUseCase(this.repository);
	final ShoppingRepository repository;
	Future<void> call() => repository.clearCart();
}

class ProcessDummyPaymentUseCase {
	const ProcessDummyPaymentUseCase();

	Future<OrderReceipt> call(double amount) async {
		if (amount <= 0) throw StateError('Your cart is empty.');
		await Future<void>.delayed(const Duration(seconds: 1));
		final suffix = Random().nextInt(900000) + 100000;
		return OrderReceipt(orderId: 'ORD-$suffix', amount: amount);
	}
}
