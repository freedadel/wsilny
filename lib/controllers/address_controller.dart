
import 'package:get/get.dart';
import '../Models/address_model.dart';
import '../repository/address_repo.dart';



class AddressController extends GetxController{
  final AddressRepo addressRepo;

  AddressController({required this.addressRepo});
  List<dynamic> _addressList = [];
  List<dynamic> get addressList => _addressList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getAddressList()async{
    Response response = await addressRepo.getAddressList();
    if(response.statusCode==200){
      print("success got address");
      _addressList = [];
      _addressList.addAll(Addresses.fromJson(response.body).addresses);
        //print(_popularProductList);
        _isLoaded = true;
        update();
    }else{
      print("Faild to get address");
    }
  }
}