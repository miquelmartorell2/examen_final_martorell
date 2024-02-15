import 'package:flutter/material.dart';
import '../preferences/preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _username = Preferences.username;
  String _password = Preferences.password;
  bool _isLogged = Preferences.login;

  @override
  void initState() {
    super.initState();
    if (_isLogged) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed('home');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username'
              ),
              onChanged: (value) {
                _username = value;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              obscureText: true, // Campo de contraseña
              decoration: InputDecoration(
                labelText: 'Password'
              ),
              onChanged: (value) {
                _password = value;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                Preferences.username = _username;
                Preferences.password = _password;
                Preferences.login = true;
                Navigator.of(context).pushNamed('home');
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
