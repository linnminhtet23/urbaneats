class SliderModel {
  String imagePath;
  String title;
  String desc;

  SliderModel({this.imagePath, this.title, this.desc});
  void setImagePath(String getImagePath){
    imagePath= getImagePath;
  }
  void setTitle(String getTitle){
    title= getTitle;
  }
  void setDesc(String getDesc){
    desc= getDesc;
  }
  String getImagePath(){
    return imagePath;
  }
  String getTitle(){
    return title;
  }
  String getDesc(){
    return desc;
  }
}

List<SliderModel> getSlide() {
  List<SliderModel> slides= new List<SliderModel>();
  SliderModel sliderModel= new SliderModel();
  sliderModel.setImagePath("assets/icon/foodlocation.png");
  sliderModel.setTitle("Search");
  sliderModel.setDesc("Discover food and restaurant aroung urban area");
  slides.add(sliderModel);

  sliderModel= new SliderModel();
  sliderModel.setImagePath("assets/icon/food2.png");
  sliderModel.setTitle("Search");
  sliderModel.setDesc("Discover food and restaurant aroung urban area");
  slides.add(sliderModel);

  sliderModel= new SliderModel();
  sliderModel.setImagePath("assets/icon/restaurant.png");
  sliderModel.setTitle("Search");
  sliderModel.setDesc("Discover food and restaurant aroung urban area");
  slides.add(sliderModel);

  return slides;
  
}
