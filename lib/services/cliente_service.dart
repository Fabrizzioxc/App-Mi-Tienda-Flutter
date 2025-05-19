import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cliente.dart';

class ClienteService {
  static final _supabase = Supabase.instance.client;

  /// Registro de nuevo cliente
  static Future<bool> registrarCliente({
    required String nombres,
    required String apellidoPaterno,
    required String apellidoMaterno,
    required String celular,
    required String email,
    required String password,
  }) async {
    try {
      await _supabase.from('clientes').insert({
        'nombres': nombres,
        'apellido_paterno': apellidoPaterno,
        'apellido_materno': apellidoMaterno,
        'celular': celular,
        'email': email,
        'password': password,
      });
      return true;
    } catch (e) {
      print('❌ Error al registrar cliente: $e');
      return false;
    }
  }

  /// Login de cliente
  static Future<Cliente?> loginCliente({
    required String email,
    required String password,
  }) async {
    try {
      final response =
          await _supabase
              .from('clientes')
              .select()
              .eq('email', email)
              .eq('password', password)
              .maybeSingle();

      if (response != null) {
        final cliente = Cliente.fromMap(response);

        // ✅ Guardar sesión localmente
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('is_logged_in', true);
        await prefs.setString('cliente_id', cliente.id);
        await prefs.setString('cliente_nombre', cliente.nombres);
        await prefs.setString('cliente_email', cliente.email);

        return cliente;
      }

      return null;
    } catch (e) {
      print('❌ Error en login: $e');
      return null;
    }
  }

  /// Cerrar sesión
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
