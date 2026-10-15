import 'package:clothing_store/data/local_datasource.dart';
import 'package:clothing_store/data/repositories_impl.dart';
import 'package:clothing_store/domain/usecases.dart';
import 'package:clothing_store/feature/cart/bloc/cart_bloc.dart';
import 'package:clothing_store/feature/products/bloc/product_bloc.dart';
import 'package:clothing_store/feature/payment/bloc/payment_bloc.dart';
import 'package:clothing_store/feature/watchlist/bloc/watchlist_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothing_store/utilities/routing/app_router.dart';
import 'package:clothing_store/utilities/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final shoppingRepository = ShoppingRepositoryImpl(ShoppingLocalDataSource());
    return ScreenUtilPlusInit(
      designSize: const Size(402, 956),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ProductBloc(
              GetProductsUseCase(ProductRepositoryImpl(ProductLocalDataSource())),
            )),
            BlocProvider(create: (_) => WatchlistBloc(
              getWatchlist: GetWatchlistUseCase(shoppingRepository),
              addProduct: AddToWatchlistUseCase(shoppingRepository),
              removeProduct: RemoveFromWatchlistUseCase(shoppingRepository),
            )),
            BlocProvider(create: (_) => CartBloc(
              getCart: GetCartUseCase(shoppingRepository),
              addProduct: AddToCartUseCase(shoppingRepository),
              removeProduct: RemoveFromCartUseCase(shoppingRepository),
              updateQuantity: UpdateCartQuantityUseCase(shoppingRepository),
              clear: ClearCartUseCase(shoppingRepository),
            )),
            BlocProvider(create: (_) => PaymentBloc(
              processPayment: const ProcessDummyPaymentUseCase(),
              clearCart: ClearCartUseCase(shoppingRepository),
            )),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,
            theme: AppTheme.lightTheme,
          ),
        );
      },
    );
  }
}
