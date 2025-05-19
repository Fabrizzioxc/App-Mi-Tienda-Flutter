class Cliente {
  final String id;
  final String nombres;
  final String? apellidoPaterno;
  final String? apellidoMaterno;
  final String celular;
  final String email;
  final String? estado;

  Cliente({
    required this.id,
    required this.nombres,
    this.apellidoPaterno,
    this.apellidoMaterno,
    required this.celular,
    required this.email,
    this.estado,
  });

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'],
      nombres: map['nombres'],
      apellidoPaterno: map['apellido_paterno'],
      apellidoMaterno: map['apellido_materno'],
      celular: map['celular'],
      email: map['email'],
      estado: map['estado'],
    );
  }
}
