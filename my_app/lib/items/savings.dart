class Saving{
  String? uid;
  String? amount;
  DateTime? dateTime;

  Saving({this.uid, this.amount, this.dateTime});

  factory Saving.fromMap(map){
    return Saving(
      uid: map['uid'],
      amount: map['amount'], 
      dateTime: map['dateTime'],
    );
  }

   Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'amount': amount,
      'dateTime': dateTime,

    };
  }
}