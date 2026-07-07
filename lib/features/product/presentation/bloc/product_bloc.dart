import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';
import '../../domain/usecases/get_product_details_usecase.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/usecases/search_products_usecase.dart';
import '../../domain/usecases/toggle_product_status_usecase.dart';
import '../../domain/usecases/update_product_usecase.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final GetProductDetailsUseCase getProductDetailsUseCase;
  final AddProductUseCase addProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final ToggleProductStatusUseCase toggleProductStatusUseCase;
  final SearchProductsUseCase searchProductsUseCase;

  ProductBloc({
    required this.getProductsUseCase,
    required this.getProductDetailsUseCase,
    required this.addProductUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
    required this.toggleProductStatusUseCase,
    required this.searchProductsUseCase,
  }) : super(const ProductInitial()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<LoadProductDetailsEvent>(_onLoadProductDetails);
    on<AddProductEvent>(_onAddProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<ToggleProductStatusEvent>(_onToggleProductStatus);
    on<SearchProductsEvent>(_onSearchProducts);
  }

  Future<void> _onLoadProducts(LoadProductsEvent event, Emitter<ProductState> emit) async {
    emit(const ProductLoading());
    try {
      final products = await getProductsUseCase(
        GetProductsParams(category: event.category, onlyEnabled: event.onlyEnabled),
      );
      emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onLoadProductDetails(LoadProductDetailsEvent event, Emitter<ProductState> emit) async {
    emit(const ProductLoading());
    try {
      final product = await getProductDetailsUseCase(event.id);
      emit(ProductDetailsLoaded(product: product));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onAddProduct(AddProductEvent event, Emitter<ProductState> emit) async {
    emit(const ProductLoading());
    try {
      await addProductUseCase(event.product);
      emit(const ProductOperationSuccess(message: 'Product added successfully'));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onUpdateProduct(UpdateProductEvent event, Emitter<ProductState> emit) async {
    emit(const ProductLoading());
    try {
      await updateProductUseCase(event.product);
      emit(const ProductOperationSuccess(message: 'Product updated successfully'));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onDeleteProduct(DeleteProductEvent event, Emitter<ProductState> emit) async {
    emit(const ProductLoading());
    try {
      await deleteProductUseCase(event.id);
      emit(const ProductOperationSuccess(message: 'Product deleted successfully'));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onToggleProductStatus(ToggleProductStatusEvent event, Emitter<ProductState> emit) async {
    emit(const ProductLoading());
    try {
      await toggleProductStatusUseCase(
        ToggleProductStatusParams(id: event.id, isEnabled: event.isEnabled),
      );
      emit(ProductOperationSuccess(
        message: event.isEnabled ? 'Product enabled' : 'Product disabled',
      ));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onSearchProducts(SearchProductsEvent event, Emitter<ProductState> emit) async {
    emit(const ProductLoading());
    try {
      final products = await searchProductsUseCase(event.query);
      emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
}
