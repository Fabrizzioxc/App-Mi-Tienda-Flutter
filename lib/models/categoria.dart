// lib/models/categoria.dart
class Categoria {
  final String id;
  final String descripcion;
  final String tipo;
  final String? categoriaPadreId;

  Categoria({
    required this.id,
    required this.descripcion,
    required this.tipo,
    this.categoriaPadreId,
  });

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      id: map['id'],
      descripcion: map['descripcion'],
      tipo: map['tipo'],
      categoriaPadreId: map['categoria_padre_id'],
    );
  }
}
