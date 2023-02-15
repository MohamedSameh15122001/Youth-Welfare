import 'package:flutter/material.dart';

import 'category.dart';

class Categorys extends StatelessWidget {
  List<String> titleOfCategory = [
    "Scientific Activity Department",
    "Families Commission Departmen",
    "Cultural Activity Department",
    "Social activities Department",
    "Social Solidarity Fund Department",
    "Sport Activity Department",
    "Art Activities Department",
  ];
  List<String> imageOfCategory = [
    "lib/assets/images/c1.jpg",
    "lib/assets/images/c2.jpg",
    "lib/assets/images/c3.jpg",
    "lib/assets/images/c4.jpg",
    "lib/assets/images/c5.jpg",
    "lib/assets/images/c6.jpg",
    "lib/assets/images/c7.png",
  ];
  Categorys({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: titleOfCategory.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: .6,
            crossAxisCount: 2,
            crossAxisSpacing: 30,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Category(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10.0,
                        offset: const Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        width: 160,
                        height: 200,
                        fit: BoxFit.contain,
                        imageOfCategory[index],
                      ),
                      const Divider(color: Colors.grey, thickness: .3),
                      Text(
                        titleOfCategory[index],
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
