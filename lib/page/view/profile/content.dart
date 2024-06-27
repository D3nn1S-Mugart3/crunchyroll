import 'package:crunchyroll/page/services/firebase/firebase_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContentProfile extends StatefulWidget {
  final String userName;

  const ContentProfile({super.key, required this.userName});

  @override
  _ContentProfileState createState() => _ContentProfileState();
}

class _ContentProfileState extends State<ContentProfile> {
  String _email = '';

  @override
  void initState() {
    super.initState();
    _getUserEmail();
  }

  Future<void> _getUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _email = user?.email ?? 'Email not available';
    });
  }

  Future<void> _logout(BuildContext context) async {
    final firebaseApi = FirebaseApi();
    await firebaseApi.signOut(); // Cierra sesión de Google y Firebase
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        _buildArrowRow('Cambiar perfil', ''),
        Divider(color: Colors.grey),
        SizedBox(height: 24),
        _buildSectionTitle('Preferencia de contenido de ${widget.userName}', color: Colors.grey),
        SizedBox(height: 20),
        _buildSwitchRow('Contenido para adultos', false),
        Divider(color: Colors.grey),
        SizedBox(height: 20),
        _buildArrowRow('Idioma del audio', 'Español (América Latina)'),
        Divider(color: Colors.grey),
        SizedBox(height: 20),
        _buildArrowRow('Idioma de los Subtítulos/CC', 'Español (A...'),
        SizedBox(height: 20),
        _buildSwitchRow('Mostrar Subtítulos Descriptivos', true),
        Divider(color: Colors.grey),
        SizedBox(height: 24),
        _buildSectionTitle('Suscripción', color: Colors.grey),
        SizedBox(height: 20),
        _buildArrowRow('Suscripción', 'Mega Fan'),
        Divider(color: Colors.grey),
        SizedBox(height: 20),
        _buildArrowRow('Notificaciones', ''),
        Divider(color: Colors.grey),
        SizedBox(height: 20),
        _buildArrowRow('Email', _email),
        Divider(color: Colors.grey),
        SizedBox(height: 20),
        _buildArrowRow('Contraseña', ''),
        Divider(color: Colors.grey),
        SizedBox(height: 24),
        _buildSectionTitle('Experiencia de la App', color: Colors.grey),
        SizedBox(height: 20),
        _buildSwitchRow('Utilizar conexión de datos', true),
        Divider(color: Colors.grey),
        SizedBox(height: 20),
        _buildArrowRow('Configuración de notificaciones', ''),
        Divider(color: Colors.grey),
        SizedBox(height: 20),
        _buildArrowRow('Aplicaciones conectadas', ''),
        Divider(color: Colors.grey),
        SizedBox(height: 24),
        _buildSectionTitle('Ver sin conexión', color: Colors.grey),
        SizedBox(height: 20),
        _buildSwitchRow('Sincronizar usando conexión de datos', false),
        Divider(color: Colors.grey),
        SizedBox(height: 20),
        _buildArrowRow('Calidad de la Sincronización', 'Alta'),
        Divider(color: Colors.grey),
        SizedBox(height: 24),
        _buildSectionTitle('Privacidad', color: Colors.grey),
        SizedBox(height: 20),
        _buildArrowRow('Do not sell my personal information', ''),
        Divider(color: Colors.grey),
        SizedBox(height: 20),
        _buildArrowRow('Borrar mi cuenta', ''),
        Divider(color: Colors.grey),
        SizedBox(height: 24),
        _buildSectionTitle('Soporte', color: Colors.grey),
        SizedBox(height: 20),
        _buildSectionTitle('¿Necesitas ayuda?'),
        Divider(color: Colors.grey),
        SizedBox(height: 24),
        GestureDetector(
          onTap: () => _logout(context),
          child: Row(
            children: [
              Text(
                "Salir",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ],
          ),
        ),
        // _buildSectionTitle('Salir'),
        SizedBox(height: 30),
        Center(
          child: Column(
            children: [
              Text(
                'Versión 3.56.2 (759)',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'Términos del servicio',
                style: TextStyle(fontSize: 16, color: Colors.orange),
              ),
              SizedBox(height: 10),
              Text(
                'Política de privacidad',
                style: TextStyle(fontSize: 16, color: Colors.orange),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, {Color color = Colors.white}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 15, color: color),
        )
      ],
    );
  }

  Widget _buildSwitchRow(String title, bool value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        Transform.scale(
          scale: 0.7,
          child: Switch(
            value: value,
            onChanged: (bool newValue) {},
            activeColor: Colors.blue,
            inactiveThumbColor: Colors.grey[300],
            inactiveTrackColor: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildArrowRow(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        Row(
          children: [
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }
}
