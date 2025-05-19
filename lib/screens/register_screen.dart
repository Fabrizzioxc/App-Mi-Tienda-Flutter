import 'package:flutter/material.dart';
import '../services/cliente_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final nombresCtrl = TextEditingController();
  final apellidoPCtrl = TextEditingController();
  final apellidoMCtrl = TextEditingController();
  final celularCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  bool cargando = false;

  Future<void> registrar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => cargando = true);

    final exito = await ClienteService.registrarCliente(
      nombres: nombresCtrl.text,
      apellidoPaterno: apellidoPCtrl.text,
      apellidoMaterno: apellidoMCtrl.text,
      celular: celularCtrl.text,
      email: emailCtrl.text,
      password: passwordCtrl.text,
    );

    setState(() => cargando = false);

    if (exito) {
      Navigator.pop(context); // Vuelve a login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("✅ Registro exitoso. Ahora inicia sesión."),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("❌ Error al registrar. Intenta de nuevo."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nombresCtrl,
                decoration: const InputDecoration(labelText: 'Nombres'),
                validator: (v) => v!.isEmpty ? 'Obligatorio' : null,
              ),
              TextFormField(
                controller: apellidoPCtrl,
                decoration: const InputDecoration(
                  labelText: 'Apellido paterno',
                ),
              ),
              TextFormField(
                controller: apellidoMCtrl,
                decoration: const InputDecoration(
                  labelText: 'Apellido materno',
                ),
              ),
              TextFormField(
                controller: celularCtrl,
                decoration: const InputDecoration(labelText: 'Celular'),
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: passwordCtrl,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: cargando ? null : registrar,
                child:
                    cargando
                        ? const CircularProgressIndicator()
                        : const Text("Registrarse"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
