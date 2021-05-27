import 'package:meta/meta.dart';

class Slide {

  final String imageUrl;
  final String imageDesc;

  Slide(@required this.imageUrl,@required this.imageDesc);
}


final slideList = [
  Slide('assets/images/1.png', ''),
  Slide('assets/images/2.png', ''),
];
