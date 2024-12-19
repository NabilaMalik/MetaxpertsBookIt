
import 'package:get/get.dart';

import '../model/AddShopModel.dart';
import '../repositories/AddShopRepository.dart';

class AddShopViewModel extends GetxController{

  var allAddShop = <AddShopModel>[].obs;
  AddShopRepository addShopRepository = AddShopRepository();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllAddShop();
  }

  fetchAllAddShop() async{
    var addShop = await addShopRepository.getAddShop();
    allAddShop.value = addShop;
  }

  addAddShop(AddShopModel addShopModel){
    addShopRepository.add(addShopModel);
    fetchAllAddShop();
  }

  updateAddShop(AddShopModel addShopModel){
    addShopRepository.update(addShopModel);
    fetchAllAddShop();
  }

  deleteAddShop(int id){
    addShopRepository.delete(id);
    fetchAllAddShop();
  }

}