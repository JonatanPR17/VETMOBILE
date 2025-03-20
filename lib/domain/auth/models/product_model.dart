// lib/models/product_service.dart

class ProductService {
  final int id;
  final String name;
  final String type;
  final String description;
  final double price;
  final int stock;
  final bool state;
  final String brandName;
  final String categoryName;
  final List<ImageData> image;

  ProductService({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.price,
    required this.stock,
    required this.state,
    required this.brandName,
    required this.categoryName,
    required this.image,
  });

  factory ProductService.fromJson(Map<String, dynamic> json) {
    var list = json['image'] as List;
    List<ImageData> imageList = list.map((i) => ImageData.fromJson(i)).toList();

    return ProductService(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      description: json['description'],
      price: json['price'],
      stock: json['stock'],
      state: json['state'],
      brandName: json['brandName'],
      categoryName: json['categoryName'],
      image: imageList,
    );
  }
}

class ImageData {
  final int id;
  final String url;

  ImageData({required this.id, required this.url});

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json['id'],
      url: json['url'],
    );
  }
}
