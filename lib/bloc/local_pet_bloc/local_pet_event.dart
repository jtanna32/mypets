part of 'local_pet_bloc.dart';

abstract class LocalPetEvent {
  const LocalPetEvent();
}

class AddPetEvent extends LocalPetEvent {
  PetModel? petData;

  AddPetEvent({this.petData});
}

class GetToInitialEvent extends LocalPetEvent {}

class GetAllPetEvent extends LocalPetEvent {}

