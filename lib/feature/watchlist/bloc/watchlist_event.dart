import 'package:equatable/equatable.dart';

import '../../../domain/entities.dart';

abstract class WatchlistEvent extends Equatable {
	const WatchlistEvent();
	@override
	List<Object?> get props => [];
}

class LoadWatchlist extends WatchlistEvent {
	const LoadWatchlist();
}

class AddToWatchlist extends WatchlistEvent {
	const AddToWatchlist(this.product);
	final Product product;
	@override
	List<Object?> get props => [product.id];
}

class RemoveFromWatchlist extends WatchlistEvent {
	const RemoveFromWatchlist(this.productId);
	final int productId;
	@override
	List<Object?> get props => [productId];
}
