import 'package:flutter/material.dart';

class Image_profile extends StatelessWidget {
  const Image_profile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 254,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/fondo/colores.avif'), // Ruta de tu imagen
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ContentProfile extends StatelessWidget {
  const ContentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        _buildArrowRow('Cambiar perfil', ' '),
        Divider(color: Colors.grey),
        SizedBox(height: 24),
        _buildSectionTitle('Preferencia de contenido de usuario', color: Colors.grey),
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
        _buildArrowRow('Email', 'a.dennis.mugarte@gmail.com'),
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
        _buildSectionTitle('Salir'),
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
          scale: 0.7, // Ajusta el tamaño del switch
          child: Switch(
            value: value,
            onChanged: (bool newValue) {},
            activeColor: Colors.blue, // Color cuando el Switch está activado
            inactiveThumbColor: Colors.grey[300], // Color del pulgar cuando el Switch está desactivado
            inactiveTrackColor: Colors.grey[400], // Color de la pista cuando el Switch está desactivado
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