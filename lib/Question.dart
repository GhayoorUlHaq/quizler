class Question {
  String _question;
  bool _answer;
  Question(ques, ans) {
    this._question = ques;
    this._answer = ans;
  }
  String getQuestion() {
    return this._question;
  }

  bool getAnswer() {
    return this._answer;
  }
}
