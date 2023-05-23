class PhotoModel {
  String imgSrc;
  String photograprName;
  PhotoModel({required this.imgSrc, required this.photograprName});
  static PhotoModel fromApitoApp(Map<String, dynamic> photoMap) {
    return PhotoModel(
        imgSrc: photoMap['src']["portrait"],
        photograprName: (photoMap['photographer']));
  }
}
