class ReConfirmOrderModel{
  int? id;
  String? product;
  String? quantity;
  String? inStock;
  String? rate;
  String? amounT;

  ReConfirmOrderModel({
    this.id,
    this.product,
    this.quantity,
    this.inStock,
    this.rate,
    this.amounT,
  });
  factory ReConfirmOrderModel.fromMap(Map<dynamic,dynamic> json){
    return ReConfirmOrderModel(
      id: json['id'],
      product: json['product'],
      quantity: json['quantity'],
      inStock: json['inStock'],
      rate:json['rate'],
      amounT:json['amounT'],

    );}
  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'product':product,
      'quantity':quantity,
      'inStock':inStock,
      'rate':rate,
      'amounT':amounT,
    };
  }
}
