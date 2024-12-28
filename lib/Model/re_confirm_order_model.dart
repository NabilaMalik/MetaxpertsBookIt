import 'dart:ffi';

class ReConfirmOrderModel{
  int? id;
  String? orderId;
  String? customerName;
  String? phoneNumber;
  String? description;
  String? qty;
  String? amount;
  String? total;
  String? creditLimit;
  String? required;

  ReConfirmOrderModel({
    this.id,
    this.orderId,
    this.customerName,
    this.phoneNumber,
    this.description,
    this.qty,
    this.amount,
    this.total,
    this.creditLimit,
    this.required,
  });
  factory ReConfirmOrderModel.fromMap(Map<dynamic,dynamic> json){
    return ReConfirmOrderModel(
      id: json['id'],
      orderId: json['orderId'],
      customerName: json['customerName'],
      phoneNumber: json['phoneNumber'],
      description:json['description'],
      qty:json['qty'],
      amount:json['amount'],
      total:json['total'],
      creditLimit:json['creditLimit'],
      required:json['required'],
    );}
  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'orderId':orderId,
      'customerName':customerName,
      'phoneNumber':phoneNumber,
      'description':description,
      'qty':qty,
      'amount':amount,
      'total':total,
      'creditLimit':creditLimit,
      'required':required,
    };
  }
}
