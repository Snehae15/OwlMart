import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owlmart/core/di/injection.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';

class CartPage extends StatelessWidget {
  final String userId;

  const CartPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CartBloc>()..add(LoadCartEvent(userId: userId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shopping Cart'),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                icon: const Icon(Icons.delete_sweep_outlined),
                onPressed: () {
                  context.read<CartBloc>().add(ClearCartItemsEvent(userId: userId));
                },
              );
            }),
          ],
        ),
        body: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            if (state is CartOperationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              context.read<CartBloc>().add(LoadCartEvent(userId: userId));
            } else if (state is CartError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              final items = state.items;
              if (items.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_outlined, size: 72, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Your cart is empty',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      padding: const EdgeInsets.all(12),
                      itemBuilder: (context, idx) {
                        final item = items[idx];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: item.imageUrl.isNotEmpty
                                      ? Image.network(
                                          item.imageUrl,
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => Container(
                                            width: 60,
                                            height: 60,
                                            color: Colors.grey.shade200,
                                            child: const Icon(Icons.image),
                                          ),
                                        )
                                      : Container(
                                          width: 60,
                                          height: 60,
                                          color: Colors.grey.shade200,
                                          child: const Icon(Icons.image),
                                        ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.productName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '\$${item.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline),
                                      onPressed: () {
                                        context.read<CartBloc>().add(
                                              UpdateItemQuantityEvent(
                                                userId: userId,
                                                productId: item.productId,
                                                quantity: item.quantity - 1,
                                              ),
                                            );
                                      },
                                    ),
                                    Text(
                                      '${item.quantity}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline),
                                      onPressed: () {
                                        context.read<CartBloc>().add(
                                              UpdateItemQuantityEvent(
                                                userId: userId,
                                                productId: item.productId,
                                                quantity: item.quantity + 1,
                                              ),
                                            );
                                      },
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                  onPressed: () {
                                    context.read<CartBloc>().add(
                                          RemoveItemFromCartEvent(
                                            userId: userId,
                                            productId: item.productId,
                                          ),
                                        );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(12),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$${state.totalPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Checkout',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(child: Text('Failed to load shopping cart.'));
          },
        ),
      ),
    );
  }
}
