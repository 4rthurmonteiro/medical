class SignUpValidators {
  String validateNotEmpty(String text){
    if(text.length == 0) return "Campo não pode ser vázio!";
    return null;
  }

  String validateDate(DateTime date){
    if(date == null) return "Preencha a data de nascimento";
    return null;
  }
}