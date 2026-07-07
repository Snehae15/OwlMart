import 'package:flutter/material.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;

  const PrimaryAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          letterSpacing: 0.5,
        ),
      ),
      centerTitle: centerTitle,
      leading: leading,
      actions: actions,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 0,
      bottom: bottom ??
          PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                color: Colors.grey.shade100,
                height: 1,
              ),
            ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
