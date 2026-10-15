import 'package:equatable/equatable.dart';

import '../../../domain/entities.dart';

class CartState extends Equatable {
	const CartState({this.items = const [], this.errorMessage});

	final List<CartLine> items;
	final String? errorMessage;

	double get total => items.fold(0, (sum, item) => sum + item.total);
	int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
	int get distinctItemCount => items.length;

	@override
	List<Object?> get props => [items, errorMessage];
}
