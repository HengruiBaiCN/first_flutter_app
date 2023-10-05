class Product {
  int? id;
  String name;
  String? description;
  String? shortDescription;
  String? sku;
  String price;
  String? regularPrice;
  String? salePrice;
  String? stockStatus;
  List<ProductImages> images;
  List<Categories>? categories;

  Product(
      {this.id,
      required this.name,
      this.description,
      this.shortDescription,
      this.sku,
      required this.price,
      this.regularPrice,
      this.salePrice,
      this.stockStatus,
      required this.images,
      this.categories});

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        shortDescription = json['short_description'],
        sku = json['sku'],
        price = json['price'],
        regularPrice = json['regular_price'],
        salePrice = json['sale_price'],
        stockStatus = json['stock_status'],
        images = (json['images'] as List)
            .map((i) => ProductImages.fromJson(i))
            .toList(),
        categories = (json['categories'] as List)
            .map((i) => Categories.fromJson(i))
            .toList();
}

class ProductImages {
  int id;
  String src;

  ProductImages({required this.id, required this.src});

  ProductImages.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        src = json['src'];
}

class Categories {
  int id;
  String name;

  Categories({required this.id, required this.name});

  Categories.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['name'] = name;
    return data;
  }
}
