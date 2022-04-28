class Quize
{
  bool isCompleted;

  final String ?QuizeTitle;
  final String ?QuizeDescription;
  final String ?id;


  Quize({ this.QuizeTitle, this.QuizeDescription,required this.id})
      : isCompleted = false;

  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'QuizTitle': QuizeTitle,
      'QuizeDescription':QuizeDescription,
    };
  }

  @override
  String toString() {
    return 'Quize{id:$id,  QuizeTitle:$QuizeTitle,QuizeDescription:$QuizeDescription  }';
  }
}