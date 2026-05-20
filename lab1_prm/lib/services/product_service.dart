import '../models/product.dart';

class ProductService {
  // Static list để lưu trữ tất cả products
  static List<Product> _products = [];

  // Phương thức thêm sản phẩm
  static void add(Product product) {
    _products.add(product);
    print('✓ Đã thêm sản phẩm: ${product.name}');
  }

  // Phương thức chỉnh sửa sản phẩm
  static bool edit(int id, Product updatedProduct) {
    try {
      int index = _products.indexWhere((p) => p.id == id);
      if (index != -1) {
        _products[index] = updatedProduct;
        print('✓ Đã cập nhật sản phẩm ID: $id');
        return true;
      }
      print('✗ Không tìm thấy sản phẩm ID: $id');
      return false;
    } catch (e) {
      print('✗ Lỗi khi cập nhật: $e');
      return false;
    }
  }

  // Phương thức tìm kiếm theo tên
  static List<Product> search(String keyword) {
    return _products
        .where((p) => p.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }

  // Phương thức tìm kiếm theo ID
  static Product? find(int id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (e) {
      print('✗ Không tìm thấy sản phẩm ID: $id');
      return null;
    }
  }

  // Phương thức tăng giá lên 10% (sử dụng declarative-map)
  static List<Product> increasePrice() {
    return _products.map((product) {
      return Product(
        id: product.id,
        name: product.name,
        image: product.image,
        price: product.price * 1.1, // Tăng 10%
      );
    }).toList();
  }

  // Phương thức lấy danh sách sản phẩm
  static List<Product> getAll() {
    return _products;
  }

  // Phương thức xóa tất cả
  static void clear() {
    _products.clear();
    print('✓ Đã xóa toàn bộ sản phẩm');
  }

  // Phương thức lấy số lượng sản phẩm
  static int count() {
    return _products.length;
  }

  // Phương thức tính tổng giá trị
  static double getTotalValue() {
    return _products.fold(0.0, (sum, product) => sum + product.price);
  }

  // Phương thức tính giá trung bình
  static double getAveragePrice() {
    if (_products.isEmpty) return 0.0;
    return getTotalValue() / _products.length;
  }
}
