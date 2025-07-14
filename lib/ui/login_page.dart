import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _loading = false;
  String? _error;

  void _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    await Future.delayed(const Duration(seconds: 1));
    if (_emailController.text == 'user@nubank.com' &&
        _passwordController.text == '123456') {
      if (!mounted) return;
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
    } else {
      setState(() {
        _error = 'E-mail ou senha inválidos';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final padding = isTablet ? 48.0 : 16.0;
    final fieldFont = isTablet ? 22.0 : 16.0;
    final buttonFont = isTablet ? 22.0 : 16.0;
    final logoSize = isTablet ? 100.0 : 60.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(padding),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.account_circle,
                  size: logoSize,
                  color: const Color(0xFF820AD1),
                ),
                const SizedBox(height: 32),
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: isTablet ? 32 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(fontSize: fieldFont),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Informe o e-mail' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  style: TextStyle(fontSize: fieldFont),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Informe a senha' : null,
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                ],
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF820AD1),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: isTablet ? 20 : 14,
                      ),
                      textStyle: TextStyle(fontSize: buttonFont),
                    ),
                    onPressed: _loading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              _login();
                            }
                          },
                    child: _loading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Entrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
