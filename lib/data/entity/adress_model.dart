import 'package:yemek_uygulamasi/data/entity/sehir_model.dart';
import 'package:yemek_uygulamasi/data/entity/type_model.dart';

class AdressModel{
  int adressId;
  String adressPath;
  TypeModel type;
  SehirModel city;

  AdressModel({required this.adressId,required this.adressPath,required this.type,required this.city});
}
