import 'package:hive_flutter/adapters.dart';
import 'package:mypets/model/pet_model.dart';
import 'package:mypets/source/local/pet_local_repository.dart';
import 'package:mypets/utils/database_utils/hive_data_store.dart';

class PetLocalRepositoryImpl extends PetLocalRepository {
  final petDao = HiveDataStore();

  Future<Box<PetModel>> getAllPets() async {
    final box = await Hive.openBox<PetModel>('petBox');

    return box;
  }

  Future<int> createPet(PetModel data) =>
      HiveDataStore().addUser(petModel: data);
}
