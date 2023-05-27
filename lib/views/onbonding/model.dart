import 'package:easy_localization/easy_localization.dart';

class SliderModel{

  String imageAssetPath;
  String title;
  String desc;

  SliderModel({required this.imageAssetPath,required this.title,required this.desc});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides(){

  List<SliderModel> slides =   <SliderModel>[];
  SliderModel sliderModel =   SliderModel(desc: '', title: '', imageAssetPath: '');

  //1
  sliderModel.setDesc(tr("findyourfavoritefoodanytime"));
  sliderModel.setTitle(tr("findyourfavoritefood"));
  sliderModel.setImageAssetPath("assets/onbondingone.png");
  slides.add(sliderModel);

  sliderModel =   SliderModel(imageAssetPath: '', desc: '', title: '');

  //2
  sliderModel.setDesc(tr("ourdeliveryman"));
  sliderModel.setTitle(tr("hotdeliveryhome"));
  sliderModel.setImageAssetPath("assets/onbondingtwo.png");
  slides.add(sliderModel);

  sliderModel =    SliderModel(imageAssetPath: '', desc: '', title: '');

  //3
  sliderModel.setDesc(tr("youreceivethe"));
  sliderModel.setTitle(tr("receivethegreatfood"));
  sliderModel.setImageAssetPath("assets/onbondingthree.png");
  slides.add(sliderModel);

  sliderModel =    SliderModel(imageAssetPath: '', desc: '', title: '');

  return slides;
}