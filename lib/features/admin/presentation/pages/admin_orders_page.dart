import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owlmart/core/di/injection.dart';
import '../bloc/admin_bloc.dart';
import '../bloc/admin_event.dart';
import '../bloc/admin_state.dart';

class AdminOrdersPage extends StatelessWidget {
  const AdminOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> statuses = ['Pending', 'Shipped', 'Delivered', 'Cancelled'];

    return BlocProvider(
      create: (_) => sl<AdminBloc>()..add(const LoadAdminOrdersEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Store Orders'),
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
              context.read<AdminBloc>().add(const LoadAdminOrdersEvent());
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
            } else if (state is AdminOrdersLoaded) {
              final orders = state.orders;
              if (orders.isEmpty) {
                return const Center(child: Text('No orders placed yet.'));
              }
              return ListView.builder(
                itemCount: orders.length,
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, idx) {
                  final order = orders[idx];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order ID: ${order.id.length > 8 ? order.id.substring(0, 8) : order.id}...',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '\$${order.totalPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text('User: ${order.userId}'),
                          const SizedBox(height: 6),
                          Text(
                            'Items: ${order.itemNames.join(", ")}',
                            style: const TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Status: ${order.status}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _getStatusColor(order.status),
                                ),
                              ),
                              DropdownButton<String>(
                                value: statuses.contains(order.status) ? order.status : 'Pending',
                                icon: const Icon(Icons.arrow_drop_down),
                                underline: const SizedBox.shrink(),
                                items: statuses.map((String st) {
                                  return DropdownMenuItem<String>(
                                    value: st,
                                    child: Text(st),
                                  );
                                }).toList(),
                                onChanged: (String? newStatus) {
                                  if (newStatus != null) {
                                    context.read<AdminBloc>().add(
                                          UpdateOrderStatusEvent(
                                            orderId: order.id,
                                            status: newStatus,
                                          ),
                                        );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: Text('Failed to load orders.'));
          },
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Shipped':
        return Colors.blue;
      case 'Delivered':
        return Colors.green;
      case 'Cancelled':
      default:
        return Colors.red;
    }
  }
}
