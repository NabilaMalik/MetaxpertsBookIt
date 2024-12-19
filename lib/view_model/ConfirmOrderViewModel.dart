
import 'package:get/get.dart';

import '../model/ConfirmOrderModel.dart';
import '../repositories/confirmOrderRepository.dart';
class ConfirmOrderViewModel extends GetxController{

  var allConfirmOrder = <ConfirmOrderModel>[].obs;
  ConfirmOrderRepository confirmorderRepository = ConfirmOrderRepository();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllConfirmOrder();
  }

  fetchAllConfirmOrder() async{
    var confirmorder = await confirmorderRepository.getConfirmOrder();
    allConfirmOrder.value = confirmorder;
  }

  addConfirmOrder(ConfirmOrderModel confirmorderModel){
    confirmorderRepository.add(confirmorderModel);
    fetchAllConfirmOrder();
  }

  updateConfirmOrder(ConfirmOrderModel confirmorderModel){
    confirmorderRepository.update(confirmorderModel);
    fetchAllConfirmOrder();
  }

  deleteConfirmOrder(int id){
    confirmorderRepository.delete(id);
    fetchAllConfirmOrder();
  }

}