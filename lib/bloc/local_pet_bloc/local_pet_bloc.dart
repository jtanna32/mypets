import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mypets/model/pet_model.dart';
import 'package:mypets/source/local/pet_local_repository.dart';
import 'package:mypets/utils/navigation_util.dart';
import 'package:mypets/view/my_pet_page.dart';

part 'local_pet_event.dart';

part 'local_pet_state.dart';

class LocalPetBloc extends Bloc<LocalPetEvent, LocalPetState> {
  final PetLocalRepository localRepository;

  LocalPetBloc(this.localRepository) : super(LocalPetInitial()) {
    on<GetToInitialEvent>((event, emit) => emit(LocalPetInitial()));
    // add pet to cart
    on<AddPetEvent>((event, emit) async {
      addPet(event.petData!);
    });
    // call this event to reset to initial state
    on<GetAllPetEvent>((event, emit) async {
      emit(GetAllPetLoadingState());
      final pets = await localRepository.getAllPets();
      print(pets.length);
      if (pets.isEmpty) {
        emit(NoPetState(message: "No Pets available"));
      } else {
        emit(GetAllPetSuccessState(pets: pets));
      }
    });
  }

  void addPet(PetModel petsData) async {
    var result = await localRepository.createPet(petsData);
    if (result != null) {
      navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MyPetPage()),
          (route) => false);
      emit(AddPetSuccessState());
    } else {
      emit(AddPetFailureState(error: "Something went wrong"));
    }
  }
}
