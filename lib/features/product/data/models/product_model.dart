import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({required super.id});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
