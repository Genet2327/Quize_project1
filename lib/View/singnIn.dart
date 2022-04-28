import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quize_project/View/signup.dart';

import '../Servise/auth.dart';
import '../utils/String_Validater.dart';
import 'HomePage.dart';

class singin extends StatefulWidget {
  const singin({Key? key}) : super(key: key);

  @override
  State<singin> createState() => _singinState();
}

class _singinState extends State<singin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  String _errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Sign In')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          TextFormField(
          controller: _emailController,
          decoration: InputDecoration(labelText: 'Email address'),
          keyboardType: TextInputType.emailAddress,
          validator: (input) {
            if (validateNonEmptyMessage(input) != null)
              return validateNonEmptyMessage(input);
            if (validateEmailAddress(input) != null)
              return (validateEmailAddress(input));
          },
        ),
        TextFormField(
          controller: _pwController,
          decoration: InputDecoration(labelText: 'Password'),
          validator: (input) => validatePassword(input),
          obscureText: true,
        ),
        ElevatedButton(
            onPressed: () async {
              final result = await AuthServise.signInWithEmailAndPassword(
                  email: _emailController.text, password: _pwController.text);
              if (result == null) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => HomePage()),
                      (_) => false,
                );
              } else {
                setState(() {
                  _errorMessage = result;
                });
              }
            },
            child: Text('sign in')),
        SizedBox(
          height: 20,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

            Text("Dont have an account?", style: TextStyle(fontSize: 15.5)),

        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => create()));
          },
          child: Text("Create Account ", style: TextStyle(
            fontSize: 15.5, decoration: TextDecoration.underline),)),
    ],
    ),

    // TODO insert email TextFormField
    // TODO insert password TextFormField
    // TODO insert ElevatedButton to validate email & pw
    ],
    ),
    );
  }
}
