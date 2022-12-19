// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mypets/bloc/local_pet_bloc/local_pet_bloc.dart';
import 'package:mypets/view/add_pet_details.dart';
import 'package:mypets/view/view_pet_detail_page.dart';

class MyPetPage extends StatefulWidget {
  const MyPetPage({Key? key}) : super(key: key);

  @override
  _MyPetPageState createState() => _MyPetPageState();
}

class _MyPetPageState extends State<MyPetPage> {
  int total = 0;

  @override
  void initState() {
    super.initState();
    context.read<LocalPetBloc>().add(GetAllPetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPetDetails()),
            );
          },
          child: Icon(Icons.add)),
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      /*    leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back)),*/
      title: Center(child: Text("My Pets")),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(child:
        BlocBuilder<LocalPetBloc, LocalPetState>(builder: (context, state) {
      if (state is GetAllPetLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is NoPetState) {
        return Center(
          child: Text("No pet available"),
        );
      } else if (state is GetAllPetSuccessState) {
        return Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(
            itemCount: state.pets!.length,
            cacheExtent: 1 / 2,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var petData = state.pets!.getAt(index);
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewPetDetailPage(model: petData),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  topLeft: Radius.circular(20)),
                              child: Container(
                                color: Colors.grey.withOpacity(0.3),
                                height: 100,
                                width: 100,
                                child: petData?.dogImages != null && petData!.dogImages!.length > 0 ? Image.memory(
                                    base64Decode(petData.dogImages![0] ?? "")) : SizedBox.shrink(),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "name: ${petData?.name ?? ""}",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Breed: ${petData?.breed ?? ""}"),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("sex: ${petData?.sex ?? ""}"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }

      return Container();
    }));
  }
}
