import 'package:clothing_store/domain/entities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
	CartBloc({
		required this.getCart,
		required this.addProduct,
		required this.removeProduct,
		required this.updateQuantity,
		required this.clear,
	}) : super(const CartState()) {
		on<LoadCart>((event, emit) => _load(emit));
		on<AddToCart>((event, emit) async {
			await addProduct(event.product);
			await _load(emit);
		});
		on<RemoveFromCart>((event, emit) async {
			await removeProduct(event.productId);
			await _load(emit);
		});
		on<IncreaseQuantity>((event, emit) async {
			final line = _line(event.productId);
			if (line != null) await updateQuantity(event.productId, line.quantity + 1);
			await _load(emit);
		});
		on<DecreaseQuantity>((event, emit) async {
			final line = _line(event.productId);
			if (line != null) await updateQuantity(event.productId, line.quantity - 1);
			await _load(emit);
		});
		on<ClearCart>((event, emit) async {
			await clear();
			await _load(emit);
		});
		add(const LoadCart());
	}

	final GetCartUseCase getCart;
	final AddToCartUseCase addProduct;
	final RemoveFromCartUseCase removeProduct;
	final UpdateCartQuantityUseCase updateQuantity;
	final ClearCartUseCase clear;

	CartLine? _line(int id) {
		for (final line in state.items) {
			if (line.product.id == id) return line;
		}
		return null;
	}

	Future<void> _load(Emitter<CartState> emit) async {
		try {
			emit(CartState(items: await getCart()));
		} catch (error) {
			emit(CartState(items: state.items, errorMessage: error.toString()));
		}
	}
}
