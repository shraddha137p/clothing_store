import 'package:clothing_store/domain/entities.dart';
import 'package:clothing_store/feature/widgets/quantity_stepper.dart';
import 'package:clothing_store/utilities/common/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class ProductCard extends StatelessWidget {
	const ProductCard({
		super.key,
		required this.product,
		required this.isFavorite,
		required this.onFavorite,
		this.onAddToCart,
		this.currentQuantity = 0,
		this.onDecrease,
		this.showCartControl = true,
	});

	final Product product;
	final bool isFavorite;
	final VoidCallback onFavorite;
	final VoidCallback? onAddToCart;
	final int currentQuantity;
	final VoidCallback? onDecrease;
	final bool showCartControl;

	@override
	Widget build(BuildContext context) {
		final colors = Theme.of(context).colorScheme;
		return Card(
			clipBehavior: Clip.antiAlias,
			elevation: 1,
			margin: EdgeInsets.zero,
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Expanded(
						child: Stack(
							fit: StackFit.expand,
							children: [
								Image.asset(
									product.image,
									fit: BoxFit.cover,
									errorBuilder: (_, _, _) => ColoredBox(
										color: colors.surfaceContainerHighest,
										child: Icon(
											Icons.image_not_supported_outlined,
											size: 24.r,
										),
									),
								),
								Positioned(
									top: 6.h,
									right: 6.w,
									child: Material(
										color: colors.surface.withValues(alpha: 0.92),
										shape: const CircleBorder(),
										child: IconButton(
											tooltip: isFavorite ? 'Remove from watchlist' : 'Add to watchlist',
											visualDensity: VisualDensity.compact,
											onPressed: onFavorite,
											icon: Icon(
												isFavorite ? Icons.favorite : Icons.favorite_border,
												color: isFavorite ? colors.error : colors.onSurface,
												size: 20.r,
											),
										),
									),
								),
							],
						),
					),
					Padding(
						padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								CommonText.semiBold(
									product.name,
									size: 14.sp,
									maxLines: 1,
									overflow: TextOverflow.ellipsis,
								),
								SizedBox(height: 3.h),
								CommonText.regular(
									product.description,
									size: 12.sp,
									maxLines: 1,
									overflow: TextOverflow.ellipsis,
									color: colors.onSurfaceVariant,
								),
								SizedBox(height: 8.h),
								Row(
									children: [
										Expanded(
											child: CommonText.bold(
												'\$${product.price.toStringAsFixed(0)}',
												size: 16.sp,
											),
										),
										if (showCartControl && onAddToCart != null && currentQuantity == 0)
											IconButton.filledTonal(
												tooltip: 'Add to cart',
												onPressed: onAddToCart,
												visualDensity: VisualDensity.compact,
												icon: Icon(Icons.add_shopping_cart, size: 20.r),
											),
										if (showCartControl && onAddToCart != null && currentQuantity > 0)
											QuantityStepper(
												quantity: currentQuantity,
												onDecrease: onDecrease ?? () {},
													onIncrease: onAddToCart!,
											),
									],
								),
							],
						),
					),
				],
			),
		);
	}
}
