class Category {
  int? categoryId;
  String? categoryName;
  String? categoryDescription;
  int? parentCategoryId;
  // String? categoryImage;
  // Image? categoryImage;

  Category({
    this.categoryId,
    this.categoryDescription,
    this.categoryName,
    // this.categoryImage,
    this.parentCategoryId,
  });

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['id'];
    categoryDescription = json['description'];
    categoryName = json['name'];
    parentCategoryId = json['parent'];

    // categoryImage =
    //     json['image'] != null ? new Image.fromJson(json['image']) : null;
  }
}

// class Image {
//   String url;

//   Image({required this.url});

//   Image.fromJson(Map<String, dynamic> json) : url = json['src'];
// }
