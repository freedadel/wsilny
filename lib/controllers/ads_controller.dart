import 'package:get/get.dart';
import '../Models/ads_model.dart';
import '../repository/ads_repo.dart';

class AdsController extends GetxController{
  final AdsRepo adsRepo;

  AdsController({required this.adsRepo});
  List<dynamic> _adsList = [];
  List<dynamic> get adsList => _adsList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getAdsList()async{
    Response response = await adsRepo.getAdsList();
    if(response.statusCode==200){
      print("success got ads");
      _adsList = [];
      _adsList.addAll(Ad.fromJson(response.body).ads);
        //print(_popularProductList);
        _isLoaded = true;
        update();
    }else{
      print("Faild to get ads");
    }
  }
}