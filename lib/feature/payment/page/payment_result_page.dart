import 'package:clothing_store/feature/payment/bloc/payment_bloc.dart';
import 'package:clothing_store/utilities/common/widgets/app_button.dart';
import 'package:clothing_store/utilities/common/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:go_router/go_router.dart';

class PaymentResultPage extends StatelessWidget {
  const PaymentResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final receipt = context.watch<PaymentBloc>().state.receipt;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: receipt == null
                ? Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.error_outline, size: 56.r),
                    SizedBox(height: 16.h),
                    CommonText.regular(
                      'Payment result is unavailable.',
                      size: 14.sp,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12.h),
                    AppButton(
                      label: 'Back to products',
                      textSize: 14.sp,
                      btnVerticalPadding: 12.h,
                      btnHorizontalPadding: 20.w,
                      btnCornerRadius: 10.r,
                      onTap: () => context.go('/products'),
                    ),
                  ])
                : Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.check_circle, size: 72.r,
                        color: Theme.of(context).colorScheme.primary),
                    SizedBox(height: 20.h),
                    CommonText.semiBold('Payment successful', size: 22.sp),
                    SizedBox(height: 8.h),
                    CommonText.regular('Order ${receipt.orderId}', size: 14.sp),
                    SizedBox(height: 4.h),
                    CommonText.bold(
                      'Paid \$${receipt.amount.toStringAsFixed(2)}',
                      size: 18.sp,
                    ),
                    SizedBox(height: 24.h),
                    AppButton(
                      label: 'Continue shopping',
                      textSize: 14.sp,
                      btnVerticalPadding: 12.h,
                      btnHorizontalPadding: 20.w,
                      btnCornerRadius: 10.r,
                      onTap: () => context.go('/products'),
                    ),
                  ]),
          ),
        ),
      ),
    );
  }
}