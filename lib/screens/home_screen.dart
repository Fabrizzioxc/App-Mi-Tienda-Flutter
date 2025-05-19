import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../models/categoria.dart';
import '../services/product_service.dart';
import '../widgets/product_card.dart';
import '../widgets/category_card.dart';
import '../providers/cart_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Categoria> categorias = [];
  List<Categoria> subcategorias = [];
  List<Product> productos = [];

  Categoria? categoriaSeleccionada;
  String busqueda = '';

  @override
  void initState() {
    super.initState();
    cargarCategorias();
  }

  Future<void> cargarCategorias() async {
    final data = await ProductService.fetchCategorias();
    setState(() {
      categorias = data;
      if (categorias.isNotEmpty) {
        categoriaSeleccionada = categorias.first;
        cargarSubcategoriasYProductos(categoriaSeleccionada!.id);
      }
    });
  }

  Future<void> cargarSubcategoriasYProductos(String categoriaId) async {
    final subs = await ProductService.fetchSubcategorias(categoriaId);
    List<Product> productosAgrupados = [];

    for (final sub in subs) {
      final prods = await ProductService.fetchProductosPorSubcategoria(sub.id);
      productosAgrupados.addAll(prods);
    }

    setState(() {
      subcategorias = subs;
      productos = productosAgrupados;
    });
  }

  Future<void> buscar(String texto) async {
    setState(() {
      busqueda = texto;
    });

    if (texto.trim().isEmpty) {
      if (categoriaSeleccionada != null) {
        cargarSubcategoriasYProductos(categoriaSeleccionada!.id);
      }
      return;
    }

    final resultados = await ProductService.buscarProductos(texto);
    setState(() {
      productos = resultados;
      subcategorias = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi tienda'),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => Navigator.pushNamed(context, '/cart'),
              ),
              if (cart.totalItems > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 8,
                    child: Text(
                      cart.totalItems.toString(),
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔍 BUSCADOR
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: buscar,
              decoration: InputDecoration(
                hintText: 'Buscar productos...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 🟦 CATEGORÍAS
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                final cat = categorias[index];
                return CategoryCard(
                  categoria: cat,
                  seleccionada: categoriaSeleccionada?.id == cat.id,
                  onTap: () {
                    setState(() => categoriaSeleccionada = cat);
                    cargarSubcategoriasYProductos(cat.id);
                  },
                );
              },
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Productos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // 📦 PRODUCTOS
          Expanded(
            child:
                productos.isEmpty
                    ? const Center(child: Text('No se encontraron productos'))
                    : busqueda.isNotEmpty
                    // 🧠 Resultado de búsqueda directa
                    ? ListView.builder(
                      itemCount: productos.length,
                      itemBuilder: (context, index) {
                        final p = productos[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8,
                          ),
                          child: ProductCard(
                            id: p.id,
                            title: p.nombre,
                            price: p.precioVenta,
                            imageUrl: p.fotoUrl,
                            onAdd:
                                () => cart.addItem(
                                  p.id,
                                  p.nombre,
                                  p.precioVenta,
                                  p.fotoUrl,
                                ),
                          ),
                        );
                      },
                    )
                    // 🗂 Agrupado por subcategoría
                    : ListView.builder(
                      itemCount: subcategorias.length,
                      itemBuilder: (context, index) {
                        final sub = subcategorias[index];
                        final productosDeSub =
                            productos
                                .where((p) => p.subcategoriaId == sub.id)
                                .toList();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8,
                              ),
                              child: Text(
                                sub.descripcion,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 220,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: productosDeSub.length,
                                itemBuilder: (context, i) {
                                  final p = productosDeSub[i];
                                  return ProductCard(
                                    id: p.id,
                                    title: p.nombre,
                                    price: p.precioVenta,
                                    imageUrl: p.fotoUrl,
                                    onAdd:
                                        () => cart.addItem(
                                          p.id,
                                          p.nombre,
                                          p.precioVenta,
                                          p.fotoUrl,
                                        ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
