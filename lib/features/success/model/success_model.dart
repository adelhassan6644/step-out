class SuccessModel {
  String? title;
  bool isPopUp;
  String? term;
  String? description;
  String? btnText;
  dynamic onTap;
  SuccessModel({
    this.title,
    this.isPopUp = true,
    this.description,
    this.term,
    this.btnText,
    this.onTap,
  });
}
