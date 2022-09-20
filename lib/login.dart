import 'package:cashflow_sertifikasi/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset('images/budget.png')
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Buku Kas',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller : usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'username',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !_passwordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'password',
                          prefixIcon: const Icon(Icons.person_outline),
                          suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                  _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: ()async{
                  if (_formKey.currentState!.validate()) {
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    String username = pref.getString("username") ?? 'user';
                    String password = pref.getString("password") ?? 'user';
                    if (usernameController.text == username && passwordController.text == password) {
                      Navigator.pushAndRemoveUntil(context, 
                                  MaterialPageRoute(builder: (BuildContext context) => const HomePage()), 
                                  (route) => false);
                    }
                 }
                }, 
                child: const Text(
                  'Login'
                ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}