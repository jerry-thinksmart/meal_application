import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '/screens/admin-tab_screen.dart';
import '/screens/tabs_screen.dart';
// import './screens/categories_screen.dart';
import 'login_details.dart';
// import 'packageR:http_image_provider/http_image_provider.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login-page';
  final Function addLoginDetails;

  LoginPage(this.addLoginDetails);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();
  String error = '';

  void _submitData() {
    if (_passwordController.text.isEmpty) {
      return;
    }
    final enteredEmail = _emailController.text;
    final enteredPassword = double.parse(_passwordController.text);

    if (enteredEmail.isEmpty || enteredPassword <= 0) {
      return;
    }

    widget.addLoginDetails(
      enteredEmail,
      enteredPassword,
    );
    void _validateDetails() {
      final List<LoginDetails> _userDetails = [
        LoginDetails(
          email: 'John@gmail.com',
          password: 2345,
        ),
        LoginDetails(
          email: 'Obi@gmail.com',
          password: 4567,
        ),
        LoginDetails(
          email: 'Ada',
          password: 7890,
        ),
      ];
      if (enteredEmail == _userDetails[0].email &&
          enteredPassword == _userDetails[0].password) {
        Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
      } else if (enteredEmail == _userDetails[1].email &&
          enteredPassword == _userDetails[1].password) {
        Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
      } else if (enteredEmail == _userDetails[2].email &&
          enteredPassword == _userDetails[2].password) {
        Navigator.of(context).pushReplacementNamed(AdminTabsScreen.routeName);
      } else {
        if (enteredEmail != _userDetails[0].email &&
            enteredPassword != _userDetails[0].password) {
          error = 'Your email and Password are wrong';
        } else {
          error = '';
        }
        if (enteredEmail != _userDetails[1].email &&
            enteredPassword != _userDetails[1].password) {
          error = 'Your email and Password are wrong';
        } else {
          error = '';
        }
        if (enteredEmail != _userDetails[2].email &&
            enteredPassword != _userDetails[2].password) {
          error = 'Your email and Password are wrong';
        } else {
          error = '';
        }
      }
    }

    _validateDetails();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Container(
        padding: const EdgeInsets.all(60),
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.all(20),
          height: mediaQuery.size.height * 10,
          width: mediaQuery.size.width * 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Email'),
                controller: _emailController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Password'),
                controller: _passwordController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              ElevatedButton(
                // textColor: Theme.of(context).primaryColor,
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  _submitData();
                },
              ),
              Text(error),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
