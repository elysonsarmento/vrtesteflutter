import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final IconData? icon;
  const CardItem(
      {super.key, required this.title, this.onTap, this.onDelete, this.icon});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          if (onDelete != null) onDelete!();
        }
      },
      key: UniqueKey(),
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Align(
            alignment: Alignment(-0.9, 0), child: Icon(Icons.delete)),
      ),
      direction: onDelete != null
          ? DismissDirection.startToEnd
          : DismissDirection.none,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 0.5,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          constraints: const BoxConstraints.expand(height: 70),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                  flex: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
              Icon(icon ?? Icons.chevron_right_rounded, size: 40),
            ],
          ),
        ),
      ),
    );
  }
}
