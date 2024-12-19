
import 'package:get/get.dart';

import '../model/shop_visit_model.dart';
import '../repositories/shop_visit_repository.dart';

class AddShopViewModel extends GetxController{

  var allShopVisit = <ShopVisitModel>[].obs;
  ShopVisitRepository shopvisitRepository = ShopVisitRepository();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllShopVisit();
  }

  fetchAllShopVisit() async{
    var shopvisit = await shopvisitRepository.getShopVisit();
    allShopVisit.value = shopvisit;
  }

  addShopVisit(ShopVisitModel shopvisitModel){
    shopvisitRepository.add(shopvisitModel);
    fetchAllShopVisit();
  }

  updateShopVisit(ShopVisitModel shopvisitModel){
    shopvisitRepository.update(shopvisitModel);
    fetchAllShopVisit();
  }

  deleteAddShop(int id){
    shopvisitRepository.delete(id);
    fetchAllShopVisit();
  }

}