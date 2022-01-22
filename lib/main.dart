import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textFieldDecoration = const InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 5));

  TextEditingController textEditControllerLogin = TextEditingController();
  TextEditingController textEditControllerPassword = TextEditingController();

  var login = '';
  var password = '';

  void _loadLoginPassword() async {

    final preference = await SharedPreferences.getInstance();
    setState(() {
      login = preference.getString('login') ?? '';
      password = preference.getString('password') ?? '';

      textEditControllerLogin.text = login;
      textEditControllerPassword.text = password;
    });
  }

  void _saveLoginPassword() async {
    final preference = await SharedPreferences.getInstance();
    preference.setString('login', textEditControllerLogin.text);
    preference.setString('password', textEditControllerPassword.text);

  }

  @override
  void initState() {
    super.initState();
    _loadLoginPassword();
  }


  @override
  Widget build(BuildContext context) {

    String _authentication() {
      final login = textEditControllerLogin.text;
      final password = textEditControllerPassword.text;

      _saveLoginPassword();

      if (login == 'MyLogin' && password == 'MyPassword') {
        return 'Вы авторизовались';
      } else {
        return 'Не правильный логин или пароль';
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('3.1'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(children: [
            const Text(
              'Login',
            ),
            TextField(
              style: const TextStyle(fontWeight: FontWeight.w600),
              controller: textEditControllerLogin,
              decoration: textFieldDecoration,
              textAlign: TextAlign.center,
              readOnly: false,
            ),
            const Text(
              'Password',
            ),
            TextField(
              style: const TextStyle(fontWeight: FontWeight.w600),
              controller: textEditControllerPassword,
              decoration: textFieldDecoration,
              textAlign: TextAlign.center,
              readOnly: false,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    action: SnackBarAction(
                      label: '',
                      onPressed: () {},
                    ),
                    content: Text(_authentication()),
                    duration: const Duration(milliseconds: 1500),
                    width: 280.0, // Width of the SnackBar.
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                );
              },
              child: const Text(
                'Войти',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
