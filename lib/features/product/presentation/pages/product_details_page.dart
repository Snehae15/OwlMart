import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owlmart/core/di/injection.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import 'product_add_edit_page.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductBloc>()..add(LoadProductDetailsEvent(id: productId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product Details'),
          actions: [
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductDetailsLoaded) {
                  return IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductAddEditPage(product: state.product),
                        ),
                      ).then((_) {
                        if (context.mounted) {
                          context.read<ProductBloc>().add(LoadProductDetailsEvent(id: productId));
                        }
                      });
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailsLoaded) {
              final prod = state.product;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: prod.imageUrl.isNotEmpty
                            ? Image.network(
                                prod.imageUrl,
                                height: 250,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  height: 250,
                                  width: double.infinity,
                                  color: Colors.grey.shade200,
                                  child: const Icon(Icons.image, size: 80, color: Colors.grey),
                                ),
                              )
                            : Container(
                                height: 250,
                                width: double.infinity,
                                color: Colors.grey.shade200,
                                child: const Icon(Icons.image, size: 80, color: Colors.grey),
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Product Name & Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            prod.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '\$${prod.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Category & Status Chips
                    Row(
                      children: [
                        Chip(
                          label: Text(prod.category),
                          backgroundColor: Colors.purple.shade50,
                          labelStyle: const TextStyle(color: Colors.purple),
                        ),
                        const SizedBox(width: 8),
                        Chip(
                          label: Text(prod.isEnabled ? 'Active' : 'Disabled'),
                          backgroundColor: prod.isEnabled ? Colors.green.shade50 : Colors.red.shade50,
                          labelStyle: TextStyle(color: prod.isEnabled ? Colors.green : Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Description
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      prod.description.isNotEmpty ? prod.description : 'No description provided.',
                      style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
                    ),
                    const SizedBox(height: 24),
                    // Stock info
                    Row(
                      children: [
                        const Icon(Icons.inventory_2_outlined, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          'Stock: ${prod.stock} items available',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (state is ProductError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.redAccent, fontSize: 16),
                ),
              );
            }
            return const Center(child: Text('Failed to load product details.'));
          },
        ),
      ),
    );
  }
}
