import 'package:equatable/equatable.dart';
import '../../domain/entities/product_entity.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductsEvent extends ProductEvent {
  final String? category;
  final bool? onlyEnabled;

  const LoadProductsEvent({this.category, this.onlyEnabled});

  @override
  List<Object?> get props => [category, onlyEnabled];
}

class LoadProductDetailsEvent extends ProductEvent {
  final String id;

  const LoadProductDetailsEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class AddProductEvent extends ProductEvent {
  final ProductEntity product;

  const AddProductEvent({required this.product});

  @override
  List<Object?> get props => [product];
}

class UpdateProductEvent extends ProductEvent {
  final ProductEntity product;

  const UpdateProductEvent({required this.product});

  @override
  List<Object?> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  final String id;

  const DeleteProductEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class ToggleProductStatusEvent extends ProductEvent {
  final String id;
  final bool isEnabled;

  const ToggleProductStatusEvent({required this.id, required this.isEnabled});

  @override
  List<Object?> get props => [id, isEnabled];
}

class SearchProductsEvent extends ProductEvent {
  final String query;

  const SearchProductsEvent({required this.query});

  @override
  List<Object?> get props => [query];
}
