
abstract class Storage {
  Future<void > getQuize ();

  Future<void> insertQuize( String title, String QuizeDescription);
  Future<void> insertQutions(String quation, String option1, String option2, String option3, String option4, String id);

}
