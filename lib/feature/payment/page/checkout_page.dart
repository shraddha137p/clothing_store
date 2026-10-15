import 'package:clothing_store/feature/cart/bloc/cart_bloc.dart';
import 'package:clothing_store/feature/cart/bloc/cart_event.dart';
import 'package:clothing_store/feature/payment/bloc/payment_bloc.dart';
import 'package:clothing_store/feature/payment/bloc/payment_event.dart';
import 'package:clothing_store/feature/payment/bloc/payment_state.dart';
import 'package:clothing_store/utilities/common/widgets/app_button.dart';
import 'package:clothing_store/utilities/common/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:go_router/go_router.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state.status == PaymentStatus.success) {
          context.read<CartBloc>().add(const LoadCart());
          context.go('/payment-result');
        }
      },
      builder: (context, payment) {
        final cart = context.watch<CartBloc>().state;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              tooltip: 'Back to cart',
              onPressed: payment.status == PaymentStatus.loading
                  ? null
                  : () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/cart');
                      }
                    },
              icon: Icon(Icons.arrow_back, size: 22.r),
            ),
            title: CommonText.semiBold('Order Summary', size: 18.sp),
          ),
          body: cart.items.isEmpty
              ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                  CommonText.regular(
                    'There are no items to check out.',
                    size: 14.sp,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  AppButton(
                    label: 'Continue shopping',
                    textSize: 14.sp,
                    btnVerticalPadding: 12.h,
                    btnHorizontalPadding: 20.w,
                    btnCornerRadius: 10.r,
                    onTap: () => context.go('/products'),
                  ),
                ]))
              : ListView(padding: EdgeInsets.all(20.r), children: [
                  ...cart.items.map((line) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Row(children: [
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText.medium(line.product.name, size: 14.sp),
                          SizedBox(height: 2.h),
                          CommonText.regular(
                            'Quantity: ${line.quantity}',
                            size: 12.sp,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ],
                      )),
                      CommonText.medium(
                        '\$${line.total.toStringAsFixed(2)}',
                        size: 14.sp,
                      ),
                    ]),
                  )),
                  Divider(height: 32.h),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    CommonText.semiBold('Amount payable', size: 16.sp),
                    CommonText.bold('\$${cart.total.toStringAsFixed(2)}', size: 18.sp),
                  ]),
                  if (payment.status == PaymentStatus.failure) ...[
                    SizedBox(height: 12.h),
                    CommonText.regular(
                      payment.errorMessage ?? 'Payment failed. Please try again.',
                      size: 13.sp,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ],
                  SizedBox(height: 24.h),
                  AppButton(
                    label: payment.status == PaymentStatus.loading
                        ? 'Processing payment...'
                        : 'Pay Now',
                    type: payment.status == PaymentStatus.loading
                        ? ButtonType.disable
                        : ButtonType.primary,
                    textSize: 16.sp,
                    btnVerticalPadding: 14.h,
                    btnCornerRadius: 10.r,
                    onTap: payment.status == PaymentStatus.loading
                        ? null
                        : () => context.read<PaymentBloc>().add(
                              InitiatePayment(cart.total),
                            ),
                  ),
                ]),
        );
      },
    );
  }
}