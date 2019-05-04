class Validator {
  String word;
  String word2check;
  bool correct = false;


   Validator(String word, String word2check) {
    this.word = word;
    this.word2check = word2check;
   }

   bool validate(String word, String word2check) {
     correct = word2check == word;
     return correct;
   }
}
