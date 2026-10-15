import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases.dart';
import 'watchlist_event.dart';
import 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
	WatchlistBloc({
		required this.getWatchlist,
		required this.addProduct,
		required this.removeProduct,
	}) : super(const WatchlistState()) {
		on<LoadWatchlist>((event, emit) => _load(emit));
		on<AddToWatchlist>((event, emit) async {
			await addProduct(event.product);
			await _load(emit);
		});
		on<RemoveFromWatchlist>((event, emit) async {
			await removeProduct(event.productId);
			await _load(emit);
		});
		add(const LoadWatchlist());
	}

	final GetWatchlistUseCase getWatchlist;
	final AddToWatchlistUseCase addProduct;
	final RemoveFromWatchlistUseCase removeProduct;

	Future<void> _load(Emitter<WatchlistState> emit) async {
		try {
			emit(WatchlistState(products: await getWatchlist()));
		} catch (error) {
			emit(WatchlistState(errorMessage: error.toString()));
		}
	}
}
