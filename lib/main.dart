import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mypets/bloc/local_pet_bloc/local_pet_bloc.dart';
import 'package:mypets/model/infection.dart';
import 'package:mypets/model/medical_contact.dart';
import 'package:mypets/model/pet_model.dart';
import 'package:mypets/source/local/pet_local_repository_impl.dart';
import 'package:mypets/utils/navigation_util.dart';
import 'package:mypets/view/my_pet_page.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // var path = Directory.current.path;
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = documentsDirectory.path;

  Hive
    ..init(path)
    ..registerAdapter<PetModel>(PetModelAdapter())
    ..registerAdapter<MedicalContact>(MedicalContactAdapter())
    ..registerAdapter<Infection>(InfectionAdapter())
  ;

  Hive.openBox<PetModel>("petBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LocalPetBloc(PetLocalRepositoryImpl()))
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyPetPage(),
      ),
    );
  }
}
