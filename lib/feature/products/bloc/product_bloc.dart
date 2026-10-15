import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
	ProductBloc(this.getProducts) : super(const ProductState()) {
		on<LoadProducts>((event, emit) async {
			emit(const ProductState(status: ProductStatus.loading));
			try {
				final products = await getProducts();
				emit(ProductState(
					status: products.isEmpty ? ProductStatus.empty : ProductStatus.success,
					products: products,
				));
			} catch (error) {
				emit(ProductState(
					status: ProductStatus.failure,
					errorMessage: error.toString(),
				));
			}
		});
		add(const LoadProducts());
	}

	final GetProductsUseCase getProducts;
}
