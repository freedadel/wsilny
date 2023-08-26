import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wsilny/Models/response_model.dart';
import 'package:wsilny/repository/location_repo.dart';

import '../Models/address_model.dart';

class LocationController extends GetxController implements GetxService{
LocationRepo locationRepo;
LocationController({required this.locationRepo});
bool _loading = false;
bool get loading=>_loading;
late Position _position;
Position get position => _position;
late Position _pickPostion;
Position get pickPosition => _pickPostion;
Placemark _placemark = Placemark();
Placemark get placemark => _placemark;
Placemark _pickPlacemark = Placemark();
Placemark get pickPlacemark => _pickPlacemark;
late List<AddressModel> _addressList=[];
List<AddressModel> get addressList=> _addressList;
late List<AddressModel> _allAddressList;
final List<String> _addressTypeList = ["home","office","others"];
List<String> get addressTypeList => _addressTypeList;
int _addressTypeIndex=0;
int get addressTypeIndex => _addressTypeIndex;
late Map<String,dynamic> _getAddress= <String, dynamic>{};
Map get getAddress=>_getAddress;

late GoogleMapController _mapController;
GoogleMapController get mapController => _mapController;
bool _updateAddressData=true;
bool _changeAddress=true;

void setMapController(GoogleMapController mapController){
  _mapController=mapController;
  print("Map Controller = "+_mapController.toString());
}

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if(_updateAddressData){
      _loading=true;
      update();
      try{
        if(fromAddress){
          _position=Position(
              latitude:position.target.latitude,
              longitude: position.target.longitude,
              timestamp: DateTime.now(),
              heading: 1,accuracy: 1,altitude: 1,speedAccuracy: 1,speed: 1
          );
        }else{
          _pickPostion=Position(
              latitude:position.target.latitude,
              longitude: position.target.longitude,
              timestamp: DateTime.now(),
              heading: 1,accuracy: 1,altitude: 1,speedAccuracy: 1,speed: 1
          );
        }

        if(_changeAddress){
          String _address = await getAddressFromGeocode(
            LatLng(
            position.target.latitude,
            position.target.longitude)
          );
          fromAddress?_placemark=Placemark(name: _address):
              _pickPlacemark=Placemark(name: _address);
        }

      }catch (e){
        print("Update position "+ e.toString());
      }
      _loading=false;
      update();
    }else{
      _updateAddressData = true;
    }
  }
  Future<String> getAddressFromGeocode(LatLng latLng) async{
    _loading = true;
    update();
  String _address = "Unkown location found";
    Response response = await locationRepo.getAddressFromGeocode(latLng);

    if(response.body["status"] == "OK"){
      _address=response.body["results"][0]['formatted_address'].toString();
      _loading=true;
      update();
      //print("printing address "+_address);
    }else{
      print("Error getting the google api");
    }
    _loading = false;
    update();
  return _address;
  }

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
      _loading=true;
      update();
    } catch (e) {
      print(e);
    }
    _loading = false;
    update();
    return _addressModel;
  }

  void setAddressTypeIndex(int index){
  _addressTypeIndex = index;
  update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async{
    _loading = true;
    update();
    Response response = await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if(response.statusCode==200){
      await getAddressList();
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModel);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
      print("Couldn't save address");
    }
    _loading = false;
    update();
    return responseModel;
  }

  getAddressList () async{
    _loading=true;
    update();
   Response response = await locationRepo.getAllAdress();
   if(response.statusCode==200){
      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address){
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
   }else{
     _addressList = [];
     _allAddressList = [];
   }

   _loading=false;
   update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async{
      String userAddress = jsonEncode(addressModel.toJson());
      return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList(){
  _allAddressList=[];
  _allAddressList=[];
  update();
  }

  String getUserAddressFromLocalStorage(){
  return locationRepo.getUserAddress();
  }
}