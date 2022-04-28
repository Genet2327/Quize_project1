import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quize_project/Model/Quez.dart';

import '../Servise/FarebaseBackend.dart';
import '../utils/String_Validater.dart';
import 'AddQuationPage.dart';

class CreateQuize extends StatefulWidget {
  const CreateQuize({Key? key}) : super(key: key);

  @override
  State<CreateQuize> createState() => _CreateQuizeState();
}

class _CreateQuizeState extends State<CreateQuize> {
  final _formKey = GlobalKey<FormState>();

  final _QuizeUrl = TextEditingController();
  final _QuozeTitle = TextEditingController();
  final _QuozeDescription = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Quizea')),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextFormField(
              controller: _QuozeTitle,
              decoration: InputDecoration(labelText: 'Quize Title'),
              validator: (input) => validQuizeCreating(input),

            ),
            TextFormField(
              controller: _QuozeDescription,
              decoration: InputDecoration(labelText: 'Quize Description'),
              validator: (input) => validQuizeCreating(input),

            ),
            ElevatedButton(
                onPressed: () async {
                 Future<Quize> result= FirestoreBackend().insertQuize(
                       _QuozeTitle.text, _QuozeDescription.text);
                 print(result);
                 print("id");



                String QuizeId = await result.then((value) => value.id) as String;
                 print("id");
                 print(QuizeId);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  AddQuationPage(quizeId: QuizeId)));
                },
                child: Text('Create Quize'))


          ],
        ),
      ),
    );
  }
}
