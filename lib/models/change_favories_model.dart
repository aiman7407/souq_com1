class ChangeFavoriteModel
{
  String message;
  bool status;

  ChangeFavoriteModel.fromJson(json){
    status=json['status'];
    message=json['message'];
  }
}