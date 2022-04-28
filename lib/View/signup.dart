import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



import '../Servise/auth.dart';
import '../utils/String_Validater.dart';
import 'HomePage.dart';

class create extends StatefulWidget {
  const create({Key? key}) : super(key: key);

  @override
  State<create> createState() => _createState();
}

class _createState extends State<create> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  String _errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Account')),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email address'),
              validator: (input) {
                if (validateNonEmptyMessage(input) != null)
                  return validateNonEmptyMessage(input);
                if (validateEmailAddress(input) != null)
                  return (validateEmailAddress(input));
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: _pwController,
              decoration: InputDecoration(labelText: 'Password'),
              validator: (input) => validatePassword(input),
              obscureText: true,
            ),
            ElevatedButton(
                onPressed: () async
                {
                  if (_formKey.currentState!.validate()) {
                    final result = await AuthServise.createAccountWithEmailAndPassword(
                        email: _emailController.text,
                        password: _pwController.text);
                    if (result == null) {
                      print(result);
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => HomePage()),
                            (_) => false,
                      );
                    } else {
                      setState(() {
                        _errorMessage = result;
                      });
                    }

                    // TODO create the account and store the result
                    // If the result is null, navigate to the home page
                    // Otherwise, show the error message on the screen - To do this you will need to create a Text widget in the Column
                  }
                },
                child: Text('Create Account'))

            // TODO insert email TextFormField
            // TODO insert password TextFormField
            // TODO insert ElevatedButton to validate email & pw
          ],
        ),
      ),
    );
  }
}
