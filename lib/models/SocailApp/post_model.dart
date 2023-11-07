
class PostModel{
  String? name;
  String? uId;
  String? image;
  String? dataTime;
  String? text;
  String? postImage;
  PostModel(
      {
        this.name,
        this.uId,
        this.image,
        this.text,
        this.dataTime,
        this.postImage
      });
  PostModel.forjson(Map<String,dynamic>json)
  {
    name=json['name'];
    uId=json['uId'];
    image=json['image'];
    text=json['text'];
    dataTime=json['dataTime'];
    postImage=json['postImage'];
  }
  Map<String,dynamic>toMap(){
    return {
      'name':name,
      "uId":uId,
      'image':image,
      'text':text,
      'dataTime':dataTime,
      'postImage':postImage
    };
  }
}