import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mypets/model/pet_model.dart';

class ViewPetDetailPage extends StatefulWidget {
  PetModel? model;

  ViewPetDetailPage({Key? key, this.model}) : super(key: key);

  @override
  State<ViewPetDetailPage> createState() => _ViewPetDetailPageState();
}

class _ViewPetDetailPageState extends State<ViewPetDetailPage> {
  int? page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Center(
        child: const Text("Pet Details"),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.white,
            child: CarouselSlider(
              options: CarouselOptions(
                onPageChanged: (value, reason) {
                  setState(() {
                    page = value;
                  });
                },
                disableCenter: true,
              ),
              items: widget.model?.dogImages!
                  .map(
                    (item) => Image.memory(base64Decode(item)),
                  )
                  .toList(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.model!.dogImages!.map((e) => Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: page == widget.model!.dogImages!.indexOf(e) ? Colors.black : Colors.red,
                  shape: BoxShape.circle
              ),
            )).toList(),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dog Details",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Name: ${widget.model?.name}"),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Breed: ${widget.model?.breed}"),
                    Text("Species: ${widget.model?.species}"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("sex: ${widget.model?.sex}"),
                    Text("weight: ${widget.model?.weight}"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("birthmark: ${widget.model?.birthmark}"),
                    Text("last pregnancy: ${widget.model?.lastPregnancy}}"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text("sterialization: ${widget.model?.sterilization}"),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Medical Contact",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "Doctor name: ${widget.model?.medicalContact?.doctorName}"),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "Clinic Address: ${widget.model?.medicalContact?.clinicAddress}}"),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "Clinic hours: ${widget.model?.medicalContact?.clinicHours}"),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "Clinic contact: ${widget.model?.medicalContact?.clinicContact}"),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Owner Details",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Owner name: ${widget.model?.ownerName}"),
                SizedBox(
                  height: 10,
                ),
                Text("Owner address: ${widget.model?.ownerAddress}"),
                SizedBox(
                  height: 10,
                ),
                Text("Owner contact: ${widget.model?.ownerContact}"),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Treatment Details",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                widget.model?.treatment != null &&
                        widget.model!.treatment!.length > 0
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.model?.treatment?.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Treatment: ${widget.model?.treatment![index].treatment}",
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Infection: ${widget.model?.treatment![index].infection}",
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Last visiting date: ${widget.model?.treatment![index].lastVisitDate}",
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Is recurring : ${widget.model?.treatment![index].isRecurring ?? false}",
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Recurring days: ${widget.model?.treatment![index].recurringDays ?? ""}",
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Doctor details: ${widget.model?.treatment![index].doctorDetails}",
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
