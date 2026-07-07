import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owlmart/core/di/injection.dart';
import '../bloc/wishlist_bloc.dart';
import '../bloc/wishlist_event.dart';
import '../bloc/wishlist_state.dart';

class WishlistPage extends StatelessWidget {
  final String userId;

  const WishlistPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WishlistBloc>()..add(LoadWishlistEvent(userId: userId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Wishlist'),
        ),
        body: BlocConsumer<WishlistBloc, WishlistState>(
          listener: (context, state) {
            if (state is WishlistOperationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              context.read<WishlistBloc>().add(LoadWishlistEvent(userId: userId));
            } else if (state is WishlistError) {
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
            if (state is WishlistLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WishlistLoaded) {
              final items = state.items;
              if (items.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border_outlined, size: 72, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Your wishlist is empty',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
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
                          IconButton(
                            icon: const Icon(Icons.favorite, color: Colors.redAccent),
                            onPressed: () {
                              context.read<WishlistBloc>().add(
                                    RemoveItemFromWishlistEvent(
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
              );
            }
            return const Center(child: Text('Failed to load wishlist.'));
          },
        ),
      ),
    );
  }
}
