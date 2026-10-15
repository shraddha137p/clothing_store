import 'package:clothing_store/data/local_datasource.dart';
import 'package:clothing_store/domain/entities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const product = Product(
    id: 1,
    name: 'Cotton Tee',
    description: 'Soft cotton',
    price: 25,
    image: 'assets/images/products/tshirt.png',
  );

  test('cart line total uses product price and quantity', () {
    const line = CartLine(product: product, quantity: 3);
    expect(line.total, 75);
  });

  test('watchlist can add and remove products', () {
    final dataSource = ShoppingLocalDataSource();
    dataSource.addToWatchlist(product);
    expect(dataSource.getWatchlist(), [product]);

    dataSource.removeFromWatchlist(product.id);
    expect(dataSource.getWatchlist(), isEmpty);
  });

  test('cart quantities update and zero removes the item', () {
    final dataSource = ShoppingLocalDataSource();
    dataSource.addToCart(product);
    dataSource.addToCart(product);
    dataSource.updateCartQuantity(product.id, 4);
    expect(dataSource.getCart().single.quantity, 4);

    dataSource.updateCartQuantity(product.id, 0);
    expect(dataSource.getCart(), isEmpty);
  });
}