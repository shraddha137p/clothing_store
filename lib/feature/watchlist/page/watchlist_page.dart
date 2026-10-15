import 'package:clothing_store/feature/watchlist/bloc/watchlist_bloc.dart';
import 'package:clothing_store/feature/watchlist/bloc/watchlist_event.dart';
import 'package:clothing_store/feature/watchlist/bloc/watchlist_state.dart';
import 'package:clothing_store/feature/widgets/product_card.dart';
import 'package:clothing_store/utilities/common/widgets/app_button.dart';
import 'package:clothing_store/utilities/common/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:go_router/go_router.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back to products',
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/products');
            }
          },
          icon: Icon(Icons.arrow_back, size: 22.r),
        ),
        title: CommonText.semiBold('Your Watchlist', size: 18.sp),
      ),
      body: BlocBuilder<WatchlistBloc, WatchlistState>(
        builder: (context, state) {
          if (state.errorMessage != null) {
            return Center(
              child: CommonText.regular(
                state.errorMessage!,
                size: 14.sp,
                color: Theme.of(context).colorScheme.error,
                textAlign: TextAlign.center,
              ),
            );
          }
          if (state.products.isEmpty) {
            return Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.favorite_border, size: 48.r),
                SizedBox(height: 12.h),
                CommonText.regular('Your watchlist is empty.', size: 14.sp),
                SizedBox(height: 12.h),
                AppButton(
                  label: 'Explore products',
                  textSize: 14.sp,
                  btnVerticalPadding: 12.h,
                  btnHorizontalPadding: 20.w,
                  btnCornerRadius: 10.r,
                  onTap: () => context.go('/products'),
                ),
              ]),
            );
          }
          return LayoutBuilder(builder: (context, constraints) {
            final columns = constraints.maxWidth > 900
              ? 4
              : constraints.maxWidth > 560 ? 3 : 2;
            return GridView.builder(
              padding: EdgeInsets.all(16.r),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                mainAxisSpacing: 14.h,
                crossAxisSpacing: 14.w,
                childAspectRatio: constraints.maxWidth < 390 ? 0.59 : 0.66,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ProductCard(
                  product: product,
                  isFavorite: true,
                  showCartControl: false,
                  onFavorite: () => context.read<WatchlistBloc>().add(
                    RemoveFromWatchlist(product.id),
                  ),
                );
              },
            );
          });
        },
      ),
    );
  }
}