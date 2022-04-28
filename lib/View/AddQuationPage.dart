import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Servise/FarebaseBackend.dart';
import '../utils/String_Validater.dart';
import 'HomePage.dart';
import 'QuationPage.dart';

class AddQuationPage extends StatefulWidget {
  final String quizeId;

  const AddQuationPage({Key? key, required this.quizeId}) : super(key: key);

  @override
  State<AddQuationPage> createState() => _AddQuationPageState();
}

class _AddQuationPageState extends State<AddQuationPage> {
  final _formKey = GlobalKey<FormState>();

  final Quation = TextEditingController();
  final option1 = TextEditingController();
  final option2 = TextEditingController();
  final option3 = TextEditingController();
  final option4 = TextEditingController();

  // override inistate
  void quation() {
    var result = FirestoreBackend().insertQutions(Quation.text, option1.text,
        option2.text, option3.text, option4.text, widget.quizeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Add Questions")),
        body: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextFormField(
              controller: Quation,
              decoration: const InputDecoration(labelText: 'Quation'),
              validator: (input) => validQuizeCreating(input),
            ),
            TextFormField(
              controller: option1,
              decoration:
                  const InputDecoration(labelText: 'option1 (Correct Answer)'),
              validator: (input) => validQuationCreating(input),
            ),
            TextFormField(
              controller: option2,
              decoration: const InputDecoration(labelText: ' option2'),
              validator: (input) => validQuationCreating(input),
            ),
            TextFormField(
              controller: option3,
              decoration: InputDecoration(labelText: 'option3'),
              validator: (input) => validQuationCreating(input),
            ),

            Row(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Text('Subbmit')),
                GestureDetector(
                    onTap: () {
                      quation();
                    },
                    child: Text('Add Quation'))
              ],
            ),
          ]),
        ));
  }
}
