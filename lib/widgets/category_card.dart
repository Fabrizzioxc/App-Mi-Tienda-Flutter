// lib/widgets/category_card.dart
import 'package:flutter/material.dart';
import '../models/categoria.dart';

class CategoryCard extends StatelessWidget {
  final Categoria categoria;
  final bool seleccionada;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.categoria,
    required this.onTap,
    this.seleccionada = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: seleccionada ? Colors.teal : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          categoria.descripcion,
          style: TextStyle(
            color: seleccionada ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
