class Product {
	const Product({
		required this.id,
		required this.name,
		required this.description,
		required this.price,
		required this.image,
	});

	final int id;
	final String name;
	final String description;
	final double price;
	final String image;
}

class CartLine {
	const CartLine({required this.product, required this.quantity});

	final Product product;
	final int quantity;
	double get total => product.price * quantity;
}

class OrderReceipt {
	const OrderReceipt({required this.orderId, required this.amount});

	final String orderId;
	final double amount;
}
