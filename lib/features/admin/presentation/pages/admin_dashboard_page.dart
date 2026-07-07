import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owlmart/core/di/injection.dart';
import '../bloc/admin_bloc.dart';
import '../bloc/admin_event.dart';
import '../bloc/admin_state.dart';
import 'category_crud_page.dart';
import 'admin_orders_page.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AdminBloc>()..add(const LoadAdminDashboardEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Dashboard'),
        ),
        body: BlocConsumer<AdminBloc, AdminState>(
          listener: (context, state) {
            if (state is AdminOperationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              context.read<AdminBloc>().add(const LoadAdminDashboardEvent());
            } else if (state is AdminError) {
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
            if (state is AdminLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AdminDashboardLoaded) {
              final stats = state.stats;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.4,
                      children: [
                        _buildStatCard('Total Products', '${stats.totalProducts}', Colors.blue, Icons.shopping_bag_outlined),
                        _buildStatCard('Active Products', '${stats.activeProducts}', Colors.green, Icons.check_circle_outline),
                        _buildStatCard('Total Orders', '${stats.totalOrders}', Colors.orange, Icons.shopping_cart_outlined),
                        _buildStatCard('Revenue', '\$${stats.totalRevenue.toStringAsFixed(2)}', Colors.teal, Icons.attach_money_outlined),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Management Console',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.category_outlined),
                            label: const Text('Categories'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const CategoryCrudPage()),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.receipt_long_outlined),
                            label: const Text('Orders'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const AdminOrdersPage()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Low Stock Warnings',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent),
                        ),
                        if (stats.lowStockProducts.isNotEmpty)
                          Chip(
                            label: Text('${stats.lowStockProducts.length} alert(s)'),
                            backgroundColor: Colors.red.shade50,
                            labelStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (stats.lowStockProducts.isEmpty)
                      const Card(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: Text('All products are sufficiently stocked.')),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: stats.lowStockProducts.length,
                        itemBuilder: (context, idx) {
                          final prod = stats.lowStockProducts[idx];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            child: ListTile(
                              title: Text(prod.name),
                              subtitle: Text('Category: ${prod.category}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Stock: ${prod.stock}',
                                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    icon: const Icon(Icons.edit_note, color: Colors.blue),
                                    onPressed: () => _showStockUpdateDialog(context, prod.id, prod.stock),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              );
            }
            return const Center(child: Text('Failed to load dashboard.'));
          },
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 28),
                Text(
                  title,
                  style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _showStockUpdateDialog(BuildContext context, String productId, int currentStock) {
    final controller = TextEditingController(text: '$currentStock');
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Update Product Stock'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'New Stock Level'),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(dialogContext),
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                final qty = int.tryParse(controller.text);
                if (qty != null) {
                  context.read<AdminBloc>().add(UpdateStockEvent(productId: productId, newStock: qty));
                }
                Navigator.pop(dialogContext);
              },
            ),
          ],
        );
      },
    );
  }
}
