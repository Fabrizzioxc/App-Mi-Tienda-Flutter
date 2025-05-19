// lib/screens/product_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  bool showInfo = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final p = widget.product;

    return Scaffold(
      appBar: AppBar(title: Text(p.nombre)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: p.fotoUrl,
                height: 160,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'S/ ${p.precioVenta.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(p.descripcion, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 4),
            Text(
              p.contenido.isNotEmpty ? p.contenido : 'Unidad: ${p.unidadVenta}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Información Adicional'),
              trailing: Icon(showInfo ? Icons.expand_less : Icons.expand_more),
              onTap: () => setState(() => showInfo = !showInfo),
            ),
            if (showInfo)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  p.infoAdicional.isNotEmpty
                      ? p.infoAdicional
                      : 'Sin información adicional disponible.',
                  style: const TextStyle(color: Colors.black87),
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed:
                      () => setState(() {
                        if (quantity > 1) quantity--;
                      }),
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('$quantity', style: const TextStyle(fontSize: 18)),
                IconButton(
                  onPressed: () => setState(() => quantity++),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  cart.addItem(
                    p.id,
                    p.nombre,
                    p.precioVenta,
                    p.fotoUrl,
                    quantity,
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'Agregar al carrito',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
