// lib/models/product.dart
class Product {
  final String id;
  final String nombre;
  final String descripcion;
  final String unidadVenta;
  final String categoriaId;
  final String subcategoriaId;
  final String contenido;
  final String infoAdicional;
  final String estado;
  final String fotoUrl;
  final String moneda;
  final double valorVenta;
  final double tasaImpuesto;
  final double precioVenta;

  Product({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.unidadVenta,
    required this.categoriaId,
    required this.subcategoriaId,
    required this.contenido,
    required this.infoAdicional,
    required this.estado,
    required this.fotoUrl,
    required this.moneda,
    required this.valorVenta,
    required this.tasaImpuesto,
    required this.precioVenta,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      unidadVenta: map['unidad_venta'],
      categoriaId: map['categoria_id'],
      subcategoriaId: map['subcategoria_id'],
      contenido: map['contenido'] ?? '',
      infoAdicional: map['info_adicional'] ?? '',
      estado: map['estado'],
      fotoUrl: map['foto_url'] ?? '',
      moneda: map['moneda'],
      valorVenta: (map['valor_venta'] as num).toDouble(),
      tasaImpuesto: (map['tasa_impuesto'] as num).toDouble(),
      precioVenta: (map['precio_venta'] as num).toDouble(),
    );
  }
}
