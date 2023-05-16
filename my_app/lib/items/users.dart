class UserGroup {
    String? uid;
    String? email;
    String? firstName;
    String? lastName;

    UserGroup({
      this.uid, 
      this.email, 
      this.firstName, 
      this.lastName, 
      });

    //using firebase user data
    factory UserGroup.fromMap(map){
      return UserGroup(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        lastName: map['lastName'],
      );
    }

    //send user data to firebase
    Map<String, dynamic> toMap() {
      return {
        'uid': uid,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
      };
    }
  
}