class ConfirmOrderModel{
  int? id;
  String? shopName;
  String? ownerName;
  String? phoneNumber;
  String? brand;
  String? total;
  String? creditLimit;
  String? requiredDelivery;

  ConfirmOrderModel({
    this.id,
    this.shopName,
    this.ownerName,
    this.phoneNumber,
    this.brand,
    this.total,
    this.creditLimit,
    this.requiredDelivery,
  });
  factory ConfirmOrderModel.fromMap(Map<dynamic,dynamic> json){
    return ConfirmOrderModel(
      id: json['id'],
      shopName: json['shopName'],
      ownerName: json['ownerName'],
      phoneNumber: json['phoneNumber'],
      brand:json['brand'],
      total:json['total'],
      creditLimit:json['creditLimit'],
      requiredDelivery:json['requiredDelivery'],
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'shopName':shopName,
      'ownerName':ownerName,
      'phoneNumber':phoneNumber,
      'brand':brand,
      'total':total,
      'creditLimit':creditLimit,
      'requiredDelivery':requiredDelivery,
    };
  }

}
