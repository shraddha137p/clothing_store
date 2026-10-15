import 'package:equatable/equatable.dart';

import '../../../domain/entities.dart';

enum ProductStatus { initial, loading, success, empty, failure }

class ProductState extends Equatable {
	const ProductState({
		this.status = ProductStatus.initial,
		this.products = const [],
		this.errorMessage,
	});

	final ProductStatus status;
	final List<Product> products;
	final String? errorMessage;

	@override
	List<Object?> get props => [status, products, errorMessage];
}
