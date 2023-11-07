
class SocailUserModel{
       String? name;
       String? email;
       String? uId;
       String? phone;
       bool? isEmailVerified;
       String? image;
       String?bio;
       String?cover;
       SocailUserModel(
       {
         this.email,
         this.name,
         this.phone,
         this.uId,
         this.isEmailVerified,
         this.image,
         this.bio,
         this.cover,
     });
       SocailUserModel.forjson(Map<String,dynamic>json)
       {
         email=json['email'];
         name=json['name'];
         uId=json['uId'];
         phone=json['phone'];
         isEmailVerified=json[' isEmailVerified'];
         image=json['image'];
         bio=json['bio'];
         cover=json['cover'];
       }
       Map<String,dynamic>toMap(){
         return {
           'name':name,
           'email':email,
           'phone':phone,
           "uId":uId,
           'isEmailVerified': isEmailVerified,
           'image':image,
           'bio':bio,
           'cover':cover
         };
       }
}