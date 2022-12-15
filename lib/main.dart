import 'package:flutter/material.dart';
import 'package:verialma/global_key_kullanimi.dart';
import 'package:verialma/text_form_field_kullanimi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GlobalKeyKullanimi(),
    );
  }
}

class TextFieldIslemleri extends StatefulWidget {
  final String title;
  const TextFieldIslemleri({super.key, required this.title});

  @override
  State<TextFieldIslemleri> createState() => _TextFieldIslemleriState();
}

class _TextFieldIslemleriState extends State<TextFieldIslemleri> {
  late TextEditingController _emailController; //textFieldin durumunu tutar
  late FocusNode _focusNode;
  int maxLineCount = 1;
  @override
  void initState() {
    //widget ilk oluşturulduğunda bir kez çalıştırılır

    super.initState();
    _emailController = TextEditingController(text: 'varsayılanmail@gmail.com');
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {
        //burada yaptığımız şey şu  imleç hangi texte ise onun maxLineCountunu 3 yap
        if (_focusNode.hasFocus) {
          maxLineCount = 3;
        } else {
          maxLineCount = 1;
        }
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            focusNode: _focusNode,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress, //inputun tipini belirler
            textInputAction: TextInputAction.next,
            autofocus:
                true, //uygulama ilk açıldığında ekranda ilk bu textField e odaklanır
            maxLines: maxLineCount, //satır sayısı
            maxLength: 30, //maximum karakter sayısı
            onChanged: (String deger) {
              //burada deger parametresi ile textField içindekini verir
              if (deger.length > 3) {
                setState(() {
                  _emailController.value = TextEditingValue(
                      text: deger,
                      selection: TextSelection.collapsed(offset: deger.length));
                });
              }
            },
            decoration: InputDecoration(
              labelText: 'e mail',
              hintText: 'email giriniz',
              prefixIcon: Icon(Icons.mail),
              suffixIcon: Icon(Icons.add),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
            onSubmitted: (String deger) {
              //textInputAction a basıldığında textField de ne varsa onu verir
              print(deger);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_emailController.text),

          //Text(_emailController.text) burda yapılan işlem şu oluşturduğumuz kontrolü _emailControler.text ile içindeki değeri bastırdık.
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            keyboardType: TextInputType.number, //inputun tipini belirler
            textInputAction: TextInputAction.next,
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _emailController.text = 'şeydanurkuvvetli@gmail.com';
          });
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
