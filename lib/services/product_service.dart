// lib/services/product_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product.dart';
import '../models/categoria.dart';

class ProductService {
  static Future<List<Product>> fetchProducts() async {
    try {
      final response = await Supabase.instance.client
          .from('productos')
          .select()
          .eq('estado', 'A');

      if (response is List) {
        return response.map((e) => Product.fromMap(e)).toList();
      } else {
        print('❌ Error inesperado: $response');
        return [];
      }
    } catch (e) {
      print('❌ Error al cargar productos: $e');
      return [];
    }
  }

  static Future<List<Categoria>> fetchCategorias() async {
    final response = await Supabase.instance.client
        .from('categorias')
        .select()
        .eq('tipo', 'C')
        .eq('estado', 'A')
        .order('descripcion', ascending: true);

    return (response as List).map((e) => Categoria.fromMap(e)).toList();
  }

  static Future<List<Categoria>> fetchSubcategorias(
    String categoriaPadreId,
  ) async {
    final response = await Supabase.instance.client
        .from('categorias')
        .select()
        .eq('tipo', 'S')
        .eq('estado', 'A')
        .eq('categoria_padre_id', categoriaPadreId)
        .order('descripcion', ascending: true);

    return (response as List).map((e) => Categoria.fromMap(e)).toList();
  }

  static Future<List<Product>> fetchProductosPorSubcategoria(
    String subcategoriaId,
  ) async {
    final response = await Supabase.instance.client
        .from('productos')
        .select()
        .eq('estado', 'A')
        .eq('subcategoria_id', subcategoriaId);

    return (response as List).map((e) => Product.fromMap(e)).toList();
  }

  static Future<List<Product>> buscarProductos(String query) async {
    final response = await Supabase.instance.client
        .from('productos')
        .select()
        .eq('estado', 'A')
        .ilike('nombre', '%$query%');

    return (response as List).map((e) => Product.fromMap(e)).toList();
  }
}
