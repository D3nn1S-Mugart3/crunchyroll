import 'package:crunchyroll/page/services/firebase/firebase_api.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isChecked = false;

  void _register() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final user = await FirebaseApi().register(email, password);
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Successful. Please log in.')),
      );
      Navigator.pushReplacementNamed(context, '/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Failed')),
      );
    }
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateButtonState);
    _passwordController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Crear Cuenta', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/crunchyroll-logo.png', height: 35,), // Cambia la ruta a tu imagen
              const SizedBox(height: 35),
              TextField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Colors.orange),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[900]!),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                style: const TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: const TextStyle(color: Colors.orange),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[900]!),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text(
                  'Quiero estar al día sobre Crunchyroll, ofertas y noticias.',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                value: _isChecked,
                activeColor: Colors.white,
                checkColor: Colors.black,
                onChanged: (bool? newValue) {
                  setState(() {
                    _isChecked = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                tileColor: Colors.black,
              ),
              const SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'Al crear una cuenta accedes a nuestros ',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  children: [
                    TextSpan(
                      text: 'Términos',
                      style: TextStyle(color: Colors.orange),
                    ),
                    TextSpan(
                      text: ' y ',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                      text: 'Política de Privacidad',
                      style: TextStyle(color: Colors.orange),
                    ),
                    TextSpan(
                      text: ' y confirmas que tienes 16 años o más.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isButtonEnabled ? _register : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isButtonEnabled ? Colors.orange : Colors.black,
                  foregroundColor: Colors.black,
                  side: BorderSide(color: _isButtonEnabled ? Colors.orange : Colors.grey),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  minimumSize: const Size.fromHeight(50), // Botón largo
                ),
                child: Text(
                  'CREAR CUENTA',
                  style: TextStyle(
                    color: _isButtonEnabled ? Colors.black : Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '¿Ya tienes una cuenta?',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      'Acceder',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
