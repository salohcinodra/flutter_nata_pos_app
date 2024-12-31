import 'dart:convert';

class ProductResponseModel {
  final String? status;
  final List<Product>? data;

  ProductResponseModel({
    this.status,
    this.data,
  });

  factory ProductResponseModel.fromJson(String str) =>
      ProductResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponseModel.fromMap(Map<String, dynamic> json) =>
      ProductResponseModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Product>.from(json["data"]!.map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Product {
  final int? id;
  final int? categoryId;
  final String? name;
  final String? description;
  final String? image;
  final String? price;
  final int? stock;
  final int? status;
  final int? isFavorite;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    this.id,
    this.categoryId,
    this.name,
    this.description,
    this.image,
    this.price,
    this.stock,
    this.status,
    this.isFavorite,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        categoryId: json["categoryId"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        stock: json["stock"],
        status: json["status"],
        isFavorite: json["is_Favorite"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  factory Product.fromLocalMap(Map<String, dynamic> json) => Product(
        id: json["productId"],
        categoryId: json["categoryId"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        stock: json["stock"],
        status: json["status"],
        isFavorite: json["isFavorite"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toLocalMap() => {
        "productId": id,
        "categoryId": categoryId,
        "categoryName": '',
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "stock": stock,
        "status": status,
        "isFavorite": isFavorite,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };

  Map<String, dynamic> toMap() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "stock": stock,
        "status": status,
        "is_Favorite": isFavorite,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
