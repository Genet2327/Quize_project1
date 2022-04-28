class Quations {

  final String Quation;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String id;
  bool? answor;
  String ?correctOption;

  Quations(
      {required this.Quation,
      required this.option1,
      required this.option2,
      required this.option3,
      required this.option4,
      required this.id});


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quation': Quation,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'option4': option4,
    };
  }

  @override
  String toString() {
    return 'Quations{id:$id, Quation:$Quation, option1:$option1,option2:$option2,option3:$option3,option4:$option4  }';
  }
}
