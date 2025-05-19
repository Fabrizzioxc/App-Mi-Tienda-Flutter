
# 📱 Mi Tienda – Flutter + Supabase

Una app móvil de ejemplo para mostrar productos, gestionar un carrito de compras y permitir el registro/login de usuarios.

---

## 🚀 Características

- 🛍️ Catálogo de productos con imagen, precio y descripción
- 📂 Visualización por categoría y subcategoría
- 🔎 Buscador de productos por nombre
- ➕ Agregar productos al carrito y ver subtotal
- 🔐 Login y registro personalizado (tabla `clientes`)
- ☁️ Backend conectado con Supabase

---

## 🧱 Tecnologías usadas

- Flutter
- Supabase (Base de datos + Storage)
- `provider` para estado del carrito
- `shared_preferences` para mantener la sesión iniciada
- `supabase_flutter` para conexión a la BD
- `flutter_dotenv` para gestión de variables de entorno
- `cached_network_image` para mostrar imágenes desde el storage

---

## 📁 Estructura de carpetas

```
lib/
├── models/              # Modelos de datos (Producto, Cliente, etc.)
├── services/            # Lógica de conexión a Supabase
├── screens/             # Login, Registro, Home, Carrito
├── widgets/             # Componentes visuales reutilizables
├── providers/           # Gestión de carrito (Provider)
```

---

## ⚙️ Configuración inicial

### 1. Clonar el proyecto

```bash
git clone https://github.com/tuusuario/mi_tienda.git
cd mi_tienda
```

### 2. Instalar dependencias

```bash
flutter pub get
```

### 3. Crear archivo `.env` en la raíz del proyecto

```env
SUPABASE_URL=https://xxxx.supabase.co
SUPABASE_ANON_KEY=tu_anon_key
```

### 4. Incluir `.env` en el `pubspec.yaml`

```yaml
flutter:
  assets:
    - .env
```

### 5. Ejecutar la app

```bash
flutter run
```

---

## ✅ Funcionalidades por implementar (opcional)

- 🧾 Historial de compras
- 🧑 Perfil del cliente
- 🔒 Hash de contraseñas (seguridad real)
- 💳 Integración con métodos de pago

---

## 📌 Nota de seguridad

Actualmente las contraseñas se almacenan en texto plano (solo con fines de prueba). Para producción, se recomienda aplicar hashing seguro (`bcrypt`, `argon2`, etc.).
