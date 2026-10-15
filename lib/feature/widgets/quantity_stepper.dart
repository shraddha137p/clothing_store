import 'package:clothing_store/utilities/common/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  });

  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton.filledTonal(
            style: IconButton.styleFrom(shape: const CircleBorder()),
            tooltip: 'Decrease quantity',
            constraints: BoxConstraints.tightFor(width: 32.r, height: 32.r),
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            onPressed: onDecrease,
            icon: Icon(Icons.remove, size: 18.r),
          ),
          Container(
            constraints: BoxConstraints(minWidth: 24.w),
            alignment: Alignment.center,
            child: CommonText.medium('$quantity', size: 13.sp),
          ),
          IconButton.filledTonal(
            style: IconButton.styleFrom(shape: const CircleBorder()),
            tooltip: 'Increase quantity',
            constraints: BoxConstraints.tightFor(width: 32.r, height: 32.r),
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            onPressed: onIncrease,
            icon: Icon(Icons.add, size: 18.r),
          ),
        ],
      ),
    );
  }
}