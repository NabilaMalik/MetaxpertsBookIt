class ReturnFormModel{
  int? id;
  String? selectShop;
  String? item;
  String? qty;
  String? reason;

  ReturnFormModel({
    this.id,
    this.selectShop,
    this.item,
    this.qty,
    this.reason,
  });

  factory ReturnFormModel.fromMap(Map<dynamic,dynamic> json){
    return ReturnFormModel(
      id: json['id'],
      selectShop: json['selectShop'],
      item: json['item'],
      qty: json['qty'],
      reason: json['reason'],
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'selectShop':selectShop,
      'item':item,
      'qty':qty,
      'reason':reason,
    };
  }
}
