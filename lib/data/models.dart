import '../domain/entities.dart';

class ProductModel extends Product {
	const ProductModel({
		required super.id,
		required super.name,
		required super.description,
		required super.price,
		required super.image,
	});

	factory ProductModel.fromJson(Map<String, dynamic> json) {
		return ProductModel(
			id: json['id'] as int,
			name: json['name'] as String,
			description: json['description'] as String,
			price: (json['price'] as num).toDouble(),
			image: json['image'] as String,
		);
	}
}
