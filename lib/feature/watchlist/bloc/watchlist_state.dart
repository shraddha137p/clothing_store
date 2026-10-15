import 'package:equatable/equatable.dart';

import '../../../domain/entities.dart';

class WatchlistState extends Equatable {
	const WatchlistState({this.products = const [], this.errorMessage});

	final List<Product> products;
	final String? errorMessage;

	@override
	List<Object?> get props => [products, errorMessage];
}
