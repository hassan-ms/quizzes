class Question {
  final int id;
  final String questiontxt;
  final String imgUrl;
  final List<String> choices;
  final int answer;
  Question(
      {required this.id,
      required this.questiontxt,
      this.imgUrl = "",
      required this.choices,
      required this.answer});
}
