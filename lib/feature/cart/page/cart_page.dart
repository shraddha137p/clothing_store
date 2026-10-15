import 'package:clothing_store/domain/entities.dart';
import 'package:clothing_store/feature/cart/bloc/cart_bloc.dart';
import 'package:clothing_store/feature/cart/bloc/cart_event.dart';
import 'package:clothing_store/feature/cart/bloc/cart_state.dart';
import 'package:clothing_store/feature/widgets/quantity_stepper.dart';
import 'package:clothing_store/utilities/common/widgets/app_button.dart';
import 'package:clothing_store/utilities/common/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

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
        title: CommonText.semiBold('Shopping Cart', size: 18.sp),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.shopping_bag_outlined, size: 48.r),
                SizedBox(height: 12.h),
                CommonText.regular('Your cart is empty.', size: 14.sp),
                SizedBox(height: 12.h),
                AppButton(
                  label: 'Continue shopping',
                  textSize: 14.sp,
                  btnVerticalPadding: 12.h,
                  btnHorizontalPadding: 20.w,
                  btnCornerRadius: 10.r,
                  onTap: () => context.go('/products'),
                ),
              ]),
            );
          }
          return Column(children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(16.r),
                itemCount: state.items.length,
                separatorBuilder: (_, _) => SizedBox(height: 10.h),
                itemBuilder: (context, index) => _CartItem(line: state.items[index]),
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
                child: Row(children: [
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min, children: [
                      CommonText.regular('${state.itemCount} items', size: 12.sp),
                      CommonText.semiBold(
                        'Total  \$${state.total.toStringAsFixed(2)}',
                        size: 18.sp,
                      ),
                    ]),
                  ),
                  AppButton(
                    label: 'Checkout',
                    textSize: 14.sp,
                    btnVerticalPadding: 12.h,
                    btnHorizontalPadding: 18.w,
                    btnCornerRadius: 10.r,
                    onTap: () => context.push('/checkout'),
                  ),
                ]),
              ),
            ),
          ]);
        },
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({required this.line});
  final CartLine line;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CartBloc>();
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: Image.asset(line.product.image, width: 76.w, height: 86.h,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => SizedBox(
                    width: 76.w, height: 86.h,
                    child: Icon(Icons.image_not_supported, size: 20.r))),
          ),
          SizedBox(width: 12.w),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            CommonText.semiBold(
              line.product.name,
              size: 14.sp,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            CommonText.regular(
              '\$${line.product.price.toStringAsFixed(2)} each',
              size: 12.sp,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            CommonText.medium(
              'Line total: \$${line.total.toStringAsFixed(2)}',
              size: 14.sp,
            ),
            Row(children: [
              QuantityStepper(
                quantity: line.quantity,
                onDecrease: () => bloc.add(DecreaseQuantity(line.product.id)),
                onIncrease: () => bloc.add(IncreaseQuantity(line.product.id)),
              ),
              const Spacer(),
              IconButton(
                tooltip: 'Remove item',
                onPressed: () => bloc.add(RemoveFromCart(line.product.id)),
                icon: Icon(Icons.delete_outline, size: 20.r),
              ),
            ]),
          ])),
        ]),
      ),
    );
  }
}