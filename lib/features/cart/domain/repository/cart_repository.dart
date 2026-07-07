import '../entities/cart_item_entity.dart';

abstract class CartRepository {
  Future<List<CartItemEntity>> getCart(String userId);
  Future<void> addToCart(String userId, CartItemEntity item);
  Future<void> removeFromCart(String userId, String productId);
  Future<void> updateQuantity(String userId, String productId, int quantity);
  Future<void> clearCart(String userId);
}
