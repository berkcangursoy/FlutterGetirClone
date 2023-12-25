import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_uygulamasi/data/repo/yemeklerdao_repository.dart';

class SepetSayfaCubit extends Cubit<void> {
  SepetSayfaCubit():super(0);

  var yrepo = YemeklerDaoRepository();

  Future<void> sepettenAl(String kullanici_adi) async {
    var liste = await yrepo.sepettenAl(kullanici_adi);
    emit(liste);
  }

  Future<void> sepettenSil(int sepet_yemek_id, String kullanici_adi) async {
    var liste = await yrepo.sepettenSil(sepet_yemek_id, kullanici_adi);
    emit(liste);
  }
}