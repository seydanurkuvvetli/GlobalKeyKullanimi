import 'package:email_validator/email_validator.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class TextFormFieldKullanimi extends StatefulWidget {
  const TextFormFieldKullanimi({super.key});

  @override
  State<TextFormFieldKullanimi> createState() => _TextFormFieldKullanimiState();
}

class _TextFormFieldKullanimiState extends State<TextFormFieldKullanimi> {
  String _email = '', _password = '', _userName = '';
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Form field kullanımı'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: 'seydanurkuwetli',
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Username',
                  hintText: 'username',
                ),
                onSaved: (deger) {
                  _userName = deger!; //null değer olabilir bu yüzden ! koyarız.
                },
                validator: (deger) {
                  if (deger!.length < 4) {
                    return 'Username en az 4 karakter olmalı';
                  } else
                    return null;
                },
              ),
              SizedBox(height: 10), //iki kutucuk arasındaki boşluk
              TextFormField(
                keyboardType: TextInputType
                    .emailAddress, //klavyede email e uygun @ işaraeti gibi şeyler çıkar
                initialValue: 'seydanurkuwetli@gmail.com',
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'E-mail',
                  hintText: 'E mail giriniz',
                ),
                onSaved: (deger) {
                  _email = deger!;
                },
                validator: (deger) {
                  if (deger!.isEmpty) {
                    return 'email boş olamaz';
                  } else if (!EmailValidator.validate(deger)) {
                    return 'Geçerli mail giriniz';
                  } else
                    return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Password',
                  hintText: 'Password',
                ),
                onSaved: (deger) {
                  _password = deger!;
                },
                validator: (deger) {
                  if (deger!.length < 6) {
                    return 'şifre en az 6  karakter olmalı';
                  } else
                    return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  bool _validate = _formkey.currentState!
                      .validate(); //currentState null olabilir
                  if (_validate) {
                    _formkey.currentState!
                        .save(); //diğer onsave metotları tetiklenecektir.ve textlerdeki veriler değişkenlere aktarılır.

                    String result =
                        "userName:$_userName\nemail:$_email\nsifre:$_password";
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.orange,
                        content: Text(result),
                      ),
                    );
                    _formkey.currentState!.reset();
                  }
                },
                child: Text('onayla'),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
