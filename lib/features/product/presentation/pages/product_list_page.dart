import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owlmart/core/di/injection.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import 'product_add_edit_page.dart';
import 'product_details_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final _searchController = TextEditingController();
  String? _selectedCategory;
  bool _onlyEnabled = false;

  final List<String> _categories = ['All', 'Electronics', 'Clothing', 'Home', 'Groceries', 'Books'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadProducts(BuildContext context) {
    context.read<ProductBloc>().add(
          LoadProductsEvent(
            category: _selectedCategory == 'All' ? null : _selectedCategory,
            onlyEnabled: _onlyEnabled ? true : null,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductBloc>()..add(const LoadProductsEvent()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('OwlMart Products'),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => _loadProducts(context),
              ),
            ],
          ),
          body: BlocListener<ProductBloc, ProductState>(
            listener: (context, state) {
              if (state is ProductOperationSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                _loadProducts(context);
              } else if (state is ProductError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.redAccent,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _loadProducts(context);
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        context.read<ProductBloc>().add(SearchProductsEvent(query: value.trim()));
                      } else {
                        _loadProducts(context);
                      }
                    },
                  ),
                ),
                // Filter switches & Categories
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Show only active products',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Switch(
                        value: _onlyEnabled,
                        onChanged: (val) {
                          setState(() {
                            _onlyEnabled = val;
                          });
                          _loadProducts(context);
                        },
                      ),
                    ],
                  ),
                ),
                // Category list
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemBuilder: (context, idx) {
                      final cat = _categories[idx];
                      final isSelected =
                          (_selectedCategory == null && cat == 'All') || (_selectedCategory == cat);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(cat),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedCategory = cat == 'All' ? null : cat;
                            });
                            _loadProducts(context);
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                // Product Grid/List
                Expanded(
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProductsLoaded) {
                        final products = state.products;
                        if (products.isEmpty) {
                          return const Center(child: Text('No products found.'));
                        }
                        return ListView.builder(
                          itemCount: products.length,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          itemBuilder: (context, idx) {
                            final prod = products[idx];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 6.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: prod.imageUrl.isNotEmpty
                                      ? Image.network(
                                          prod.imageUrl,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => Container(
                                            width: 50,
                                            height: 50,
                                            color: Colors.grey.shade300,
                                            child: const Icon(Icons.image),
                                          ),
                                        )
                                      : Container(
                                          width: 50,
                                          height: 50,
                                          color: Colors.grey.shade300,
                                          child: const Icon(Icons.image),
                                        ),
                                ),
                                title: Text(
                                  prod.name,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text('\$${prod.price.toStringAsFixed(2)} | Stock: ${prod.stock}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Switch(
                                      value: prod.isEnabled,
                                      onChanged: (val) {
                                        context.read<ProductBloc>().add(
                                              ToggleProductStatusEvent(id: prod.id, isEnabled: val),
                                            );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                                      onPressed: () {
                                        _showDeleteDialog(context, prod.id);
                                      },
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProductDetailsPage(productId: prod.id),
                                    ),
                                  ).then((_) => _loadProducts(context));
                                },
                              ),
                            );
                          },
                        );
                      }
                      return const Center(child: Text('Start by loading products.'));
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProductAddEditPage(),
                ),
              ).then((_) => _loadProducts(context));
            },
          ),
        );
      }),
    );
  }

  void _showDeleteDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: const Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(dialogContext),
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                context.read<ProductBloc>().add(DeleteProductEvent(id: id));
                Navigator.pop(dialogContext);
              },
            ),
          ],
        );
      },
    );
  }
}
