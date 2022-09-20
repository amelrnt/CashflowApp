import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({ Key? key }) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  void saveLoginInfo(String password, String newPassword) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String currentPassword = pref.getString("password") ?? '';
    if (password == currentPassword) {
      pref.setString("password", newPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, 
      appBar: AppBar(
        title: const Text('Cash Flow App'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal:15, vertical:30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Pengaturan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Ganti Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Password saat ini :'
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    const Text(
                      'Password Baru : '
                    ),
                    TextFormField(
                      controller: newPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ]
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed : ()async{
                    if (_formKey.currentState!.validate()) {
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      String currentPassword = pref.getString("password") ?? '';
                      if (passwordController.text == currentPassword) {
                        pref.setString("password", newPasswordController.text);
                      } 
                      const snackBar = SnackBar(
                        content: Text('New Password Saved!'),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);                  
                    }
                  },
                  child: const Text('Simpan'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed : (){
                    Navigator.pop(context);
                  },
                  style:  ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  ),
                child: const Text('<< Kembali'),
                ),
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  Image.asset('images/photo.JPG',
                  width: 100,
                  height: 100,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('About this APP',
                        style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Aplikasi ini dibuat oleh'),
                      Text('Nama : Amelia Rosanti '),
                      Text('Nim : 2141272007'),
                      Text('Tanggal : 18 September 2022'),
                    ],
                  )
                ],
              )
            ]
          ),
        ),
      ),
    );
  }
}