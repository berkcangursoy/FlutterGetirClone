import 'package:yemek_uygulamasi/data/entity/adress_model.dart';
import 'package:yemek_uygulamasi/data/entity/kategori_model.dart';

class ListModels {
  final List<CategoryModel> categoryModel;
  final List<AdressModel> adressModel;

  ListModels({
    required this.categoryModel,
    required this.adressModel,
  });

  ListModels copyWith({
    List<CategoryModel>? categoryModel,
    List<AdressModel>? adressModel,
  }) {
    return ListModels(
      categoryModel: categoryModel ?? this.categoryModel,
      adressModel: adressModel ?? this.adressModel,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ListModels &&
              runtimeType == other.runtimeType &&
              categoryModel == other.categoryModel &&
              adressModel == other.adressModel;

  @override
  int get hashCode => categoryModel.hashCode ^ adressModel.hashCode;
}