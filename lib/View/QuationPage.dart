import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quize_project/Model/AddQuatins.dart';
import 'package:quize_project/View/result.dart';

import '../Model/AddQuatins.dart';
import '../Model/AddQuatins.dart';
import '../Model/Quations.dart';
import '../Servise/FarebaseBackend.dart';
import '../Widgets/QuationList.dart';
import '../Widgets/quation.dart';

class QuationPage extends StatefulWidget {
  final String? quizeId;

  const QuationPage({Key? key, required this.quizeId}) : super(key: key);

  @override
  State<QuationPage> createState() => _QuationPageState();
}

int _correct = 0;
int _incorrect = 0;

int total = 0;

class _QuationPageState extends State<QuationPage> {
  @override
  String? get quizeId => quizeId;

  QuestionModel getQuestionModel(Quations quation) {
    total = total + 1;
    QuestionModel questionModel = new QuestionModel();

    questionModel.question = quation.Quation;

    List<String> options = [
      quation.option1,
      quation.option2,
      quation.option3,
      quation.option4,
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = quation.option1;
    questionModel.answered = false;

    return questionModel;
  }

  @override
  Widget build(BuildContext context) {
    var QuationFuture = FirestoreBackend().getQuation(widget.quizeId);
    print("QuationFuture");
    print(QuationFuture);
    List<Quations>? _quation;
    return FutureBuilder<List<Quations>>(
        future: QuationFuture,
        builder: (context, snapshot) {
          _quation = snapshot.hasData ? snapshot.data! : [];
          return Scaffold(
            body:
                // Column(
                //   children: [
                ListView.builder(
                    itemCount: _quation!.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (_, index) {
                      print(_quation![index]);
                      return QuationsTitle(
                        quation: getQuestionModel(_quation![index]),
                        index: index,
                      );
                    }),
            // ],
            //),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.check),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Results(
                              incorrect: _incorrect,
                              total: _quation!.length,
                              correct: _correct,
                            )));
              },
            ),
          );
        });
  }
}

class QuationsTitle extends StatefulWidget {
  final QuestionModel quation;

  final int index;

  QuationsTitle({required this.quation, required this.index});

  @override
  State<QuationsTitle> createState() => _QuationsTitleState();
}

class _QuationsTitleState extends State<QuationsTitle> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(widget.quation.question),
      const SizedBox(
        height: 12,
      ),
      GestureDetector(
        onTap: () {
          if (!widget.quation.answered) {
            if (widget.quation.option1 == widget.quation.correctOption) {
              setState(() {
                optionSelected = widget.quation.option1;
                widget.quation.answered = true;
                _correct = _correct + 1;
              });
            } else {
              setState(() {
                optionSelected = widget.quation.option1;
                widget.quation.answered = true;
                _incorrect = _incorrect + 1;
              });
            }
          }
        },
        child: QuationPlay(
          optionSelected: optionSelected,
          correctAnswer: widget.quation.option1,
          description: widget.quation.option1,
          option: "A",
        ),
      ),
      const SizedBox(
        height: 12,
      ),
      GestureDetector(
        onTap: () {
          if (!widget.quation.answered) {
            if (widget.quation.option2 == widget.quation.correctOption) {
              setState(() {
                optionSelected = widget.quation.option2;
                widget.quation.answered = true;
                _correct = _correct + 1;
              });
            } else {
              setState(() {
                optionSelected = widget.quation.option2;
                widget.quation.answered = true;
                _incorrect = _incorrect + 1;
              });
            }
          }
        },
        child: QuationPlay(
          optionSelected: optionSelected,
          correctAnswer: widget.quation.option1,
          description: widget.quation.option2,
          option: "B",
        ),
      ),
      SizedBox(
        height: 12,
      ),
      GestureDetector(
        onTap: () {
          if (!widget.quation.answered) {
            if (widget.quation.option3 == widget.quation.correctOption) {
              setState(() {
                optionSelected = widget.quation.option3;
                widget.quation.answered = true;
                _correct = _correct + 1;
              });
            } else {
              setState(() {
                optionSelected = widget.quation.option3;
                widget.quation.answered = true;
                _incorrect = _incorrect + 1;
              });
            }
          }
        },
        child: QuationPlay(
          optionSelected: optionSelected,
          correctAnswer: widget.quation.option1,
          description: widget.quation.option3,
          option: "C",
        ),
      ),
      SizedBox(
        height: 12,
      ),
      GestureDetector(
        onTap: () {
          if (!widget.quation.answered) {
            if (widget.quation.option4 == widget.quation.correctOption) {
              setState(() {
                optionSelected = widget.quation.option4;
                widget.quation.answered = true;
                _correct = _correct + 1;
              });
            } else {
              setState(() {
                optionSelected = widget.quation.option4;
                widget.quation.answered = true;
                _incorrect = _incorrect + 1;
              });
            }
          }
        },
        child: QuationPlay(
          optionSelected: optionSelected,
          correctAnswer: widget.quation.option1,
          description: widget.quation.option4,
          option: "D",
        ),
      )
    ]);
  }
}
