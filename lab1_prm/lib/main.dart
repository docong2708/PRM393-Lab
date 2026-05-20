// ignore_for_file: avoid_print

import 'dart:async';

import 'models/product.dart';
import 'services/product_service.dart';

void main() {
  final products = [
    Product(id: 1, name: 'Laptop Dell', image: 'dell.png', price: 1000),
    Product(id: 2, name: 'iPhone 15', image: 'iphone.png', price: 999),
    Product(id: 3, name: 'Samsung TV', image: 'tv.png', price: 500),
  ];

  _quietly(() {
    ProductService.clear();
    for (final product in products) {
      ProductService.add(product);
    }
  });

  _printTitle('PRODUCT LAB CONSOLE');
  _printInventory('Initial inventory', ProductService.getAll());

  final searchResults = ProductService.search('Dell');
  _printSection('Search result: keyword = "Dell"');
  _printInventoryRows(searchResults);

  final productById = ProductService.find(2);
  _printSection('Lookup result: id = 2');
  print(
    productById == null ? 'No product matched this id.' : _line(productById),
  );

  final updatedProduct = Product(
    id: 1,
    name: 'Laptop Dell XPS 15',
    image: 'dell-xps.png',
    price: 1200,
  );

  _quietly(() => ProductService.edit(1, updatedProduct));
  _printSection('After edit');
  _printInventoryRows(ProductService.getAll());

  final jsonData = {
    'id': 4,
    'name': 'iPad Pro',
    'image': 'ipad.png',
    'price': 1200.50,
  };
  final productFromJson = Product.fromJson(jsonData);
  _quietly(() => ProductService.add(productFromJson));

  _printSection('JSON mapping');
  print('fromJson  -> ${_line(productFromJson)}');
  print('toJson    -> ${products.first.toJson()}');

  final increasedPrices = ProductService.increasePrice();
  _printSection('Price simulation: +10%');
  print('Product              Current      After +10%');
  print('---------------------------------------------');
  for (var i = 0; i < ProductService.getAll().length; i++) {
    final current = ProductService.getAll()[i];
    final increased = increasedPrices[i];
    print(
      '${current.name.padRight(20)} '
      '${_money(current.price).padLeft(9)} '
      '${_money(increased.price).padLeft(13)}',
    );
  }

  _printSummary();
}

void _quietly(void Function() action) {
  runZoned<void>(
    action,
    zoneSpecification: ZoneSpecification(print: (_, parent, zone, line) {}),
  );
}

void _printTitle(String title) {
  print('');
  print('=================================================');
  print('              $title');
  print('=================================================');
  print('A compact report for Product model operations.');
}

void _printSection(String title) {
  print('');
  print('> $title');
  print('---------------------------------------------');
}

void _printInventory(String title, List<Product> products) {
  _printSection(title);
  _printInventoryRows(products);
}

void _printInventoryRows(List<Product> products) {
  if (products.isEmpty) {
    print('No products to display.');
    return;
  }

  print('ID   Name                 Image          Price');
  print('---------------------------------------------');
  for (final product in products) {
    print(_line(product));
  }
}

String _line(Product product) {
  return '${product.id.toString().padRight(4)} '
      '${product.name.padRight(20)} '
      '${product.image.padRight(13)} '
      '${_money(product.price).padLeft(8)}';
}

String _money(double value) => '\$${value.toStringAsFixed(2)}';

void _printSummary() {
  _printSection('Final dashboard');
  print('Items in store : ${ProductService.count()}');
  print('Total value    : ${_money(ProductService.getTotalValue())}');
  print('Average price  : ${_money(ProductService.getAveragePrice())}');
  print('');
  print('Status: LAB 1 REPORT COMPLETED');
}
