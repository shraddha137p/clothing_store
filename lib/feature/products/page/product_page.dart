import 'package:clothing_store/feature/cart/bloc/cart_bloc.dart';
import 'package:clothing_store/feature/cart/bloc/cart_event.dart';
import 'package:clothing_store/feature/cart/bloc/cart_state.dart';
import 'package:clothing_store/feature/products/bloc/product_bloc.dart';
import 'package:clothing_store/feature/products/bloc/product_event.dart';
import 'package:clothing_store/feature/products/bloc/product_state.dart';
import 'package:clothing_store/feature/watchlist/bloc/watchlist_bloc.dart';
import 'package:clothing_store/feature/watchlist/bloc/watchlist_event.dart';
import 'package:clothing_store/feature/watchlist/bloc/watchlist_state.dart';
import 'package:clothing_store/feature/widgets/product_card.dart';
import 'package:clothing_store/utilities/common/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:go_router/go_router.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: CommonText.semiBold('Clothing Store', size: 18.sp),
        actions: [
          BlocBuilder<WatchlistBloc, WatchlistState>(
            builder: (context, state) => IconButton(
              tooltip: 'Watchlist',
              onPressed: () => context.push('/watchlist'),
              icon: Badge(
                label: CommonText.medium('${state.products.length}', size: 10.sp),
                isLabelVisible: state.products.isNotEmpty,
                child: Icon(Icons.favorite_border, size: 22.r),
              ),
            ),
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) => IconButton(
              tooltip: 'Shopping cart',
              onPressed: () => context.push('/cart'),
              icon: Badge(
                label: CommonText.medium('${state.distinctItemCount}', size: 10.sp),
                isLabelVisible: state.distinctItemCount > 0,
                child: Icon(Icons.shopping_bag_outlined, size: 22.r),
              ),
            ),
          ),
          SizedBox(width: 8.w),
        ],
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.status == ProductStatus.loading ||
              state.status == ProductStatus.initial) {
              return Center(
                child: SizedBox(
                  width: 32.r,
                  height: 32.r,
                  child: const CircularProgressIndicator(),
                ),
              );
          }
          if (state.status == ProductStatus.failure) {
            return _MessageState(
              icon: Icons.error_outline,
              message: state.errorMessage ?? 'Could not load products.',
              action: TextButton(
                onPressed: () => context.read<ProductBloc>().add(
                  const LoadProducts(),
                ),
                    child: CommonText.medium('Try again', size: 14.sp),
              ),
            );
          }
          if (state.status == ProductStatus.empty) {
            return const _MessageState(
              icon: Icons.inventory_2_outlined,
              message: 'No products available.',
            );
          }
          return BlocBuilder<WatchlistBloc, WatchlistState>(
            builder: (context, favorites) {
              final favoriteIds = favorites.products.map((item) => item.id).toSet();
              return BlocBuilder<CartBloc, CartState>(
                builder: (context, cartState) {
                  final quantities = {
                    for (final line in cartState.items)
                      line.product.id: line.quantity,
                  };
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final columns = constraints.maxWidth > 900
                          ? 4
                          : constraints.maxWidth > 560 ? 3 : 2;
                      return GridView.builder(
                        padding: EdgeInsets.all(16.r),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          mainAxisSpacing: 14.h,
                          crossAxisSpacing: 14.w,
                          childAspectRatio:
                              constraints.maxWidth < 390 ? 0.59 : 0.66,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return ProductCard(
                            product: product,
                            isFavorite: favoriteIds.contains(product.id),
                            currentQuantity: quantities[product.id] ?? 0,
                            onDecrease: () => context.read<CartBloc>().add(
                              DecreaseQuantity(product.id),
                            ),
                            onFavorite: () => context.read<WatchlistBloc>().add(
                              favoriteIds.contains(product.id)
                                  ? RemoveFromWatchlist(product.id)
                                  : AddToWatchlist(product),
                            ),
                            onAddToCart: () => context.read<CartBloc>().add(
                              AddToCart(product),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
        ),
      ),
    );
  }
}

class _MessageState extends StatelessWidget {
  const _MessageState({required this.icon, required this.message, this.action});
  final IconData icon;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 44.r),
            SizedBox(height: 12.h),
            CommonText.regular(message, size: 14.sp, textAlign: TextAlign.center),
            if (action != null) action!,
          ]),
        ),
      );
}
