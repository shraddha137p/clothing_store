import 'package:equatable/equatable.dart';

import '../../../domain/entities.dart';

abstract class CartEvent extends Equatable {
	const CartEvent();
	@override
	List<Object?> get props => [];
}

class LoadCart extends CartEvent {
	const LoadCart();
}

class AddToCart extends CartEvent {
	const AddToCart(this.product);
	final Product product;
	@override
	List<Object?> get props => [product.id];
}

class RemoveFromCart extends CartEvent {
	const RemoveFromCart(this.productId);
	final int productId;
	@override
	List<Object?> get props => [productId];
}

class IncreaseQuantity extends CartEvent {
	const IncreaseQuantity(this.productId);
	final int productId;
	@override
	List<Object?> get props => [productId];
}

class DecreaseQuantity extends CartEvent {
	const DecreaseQuantity(this.productId);
	final int productId;
	@override
	List<Object?> get props => [productId];
}

class ClearCart extends CartEvent {
	const ClearCart();
}
