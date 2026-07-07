import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owlmart/core/di/injection.dart';
import '../../domain/entities/category_entity.dart';
import '../bloc/admin_bloc.dart';
import '../bloc/admin_event.dart';
import '../bloc/admin_state.dart';

class CategoryCrudPage extends StatefulWidget {
  const CategoryCrudPage({super.key});

  @override
  State<CategoryCrudPage> createState() => _CategoryCrudPageState();
}

class _CategoryCrudPageState extends State<CategoryCrudPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AdminBloc>()..add(const LoadAdminCategoriesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manage Categories'),
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
              _controller.clear();
              context.read<AdminBloc>().add(const LoadAdminCategoriesEvent());
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
            } else if (state is AdminCategoriesLoaded) {
              final categories = state.categories;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'New Category Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () {
                              final text = _controller.text.trim();
                              if (text.isNotEmpty) {
                                final cat = CategoryEntity(
                                  id: '',
                                  name: text,
                                  slug: text.toLowerCase().replaceAll(RegExp(r'\s+'), '-'),
                                  createdAt: DateTime.now(),
                                );
                                context.read<AdminBloc>().add(AddCategoryEvent(category: cat));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Add'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: categories.isEmpty
                        ? const Center(child: Text('No categories created.'))
                        : ListView.builder(
                            itemCount: categories.length,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemBuilder: (context, idx) {
                              final cat = categories[idx];
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 4.0),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                child: ListTile(
                                  title: Text(cat.name),
                                  subtitle: Text('Slug: ${cat.slug}'),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                                    onPressed: () {
                                      context.read<AdminBloc>().add(DeleteCategoryEvent(id: cat.id));
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              );
            }
            return const Center(child: Text('Failed to load categories.'));
          },
        ),
      ),
    );
  }
}
