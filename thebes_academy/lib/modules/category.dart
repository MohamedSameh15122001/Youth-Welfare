import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:thebes_academy/modules/home.dart';

import 'category_details.dart';

class Category extends StatelessWidget {
  List<String> activitys = [
    "Opening of the new school year.",
    "The ideal male and female student competition at the university level.",
    "New Year's Celebration.",
    "Chess competition (teams - individual) at the university faculties level.",
    "Social research competition.",
    "Competition (student - coach).",
    "Celebration of the ideal mother.",
    "Orphan's Day Celebration.",
    "Organizing several leadership training camps in several governorates during the summer vacation.",
    "Seminars and community initiatives and the implementation of many medical convoys.",
    "People’s Festival under the name “Against Extremism and Terrorism”",
    "Social research competition at the level of Egyptian universities, institutes and academies.",
    "Girls' Youth Week.",
    "University Youth Week.",
    "Creativity competition.",
    "Ideal students competition at the level of Egyptian universities.",
    "The first summit of universities at Benha University.",
    "The project of employing students during the summer vacation.",
    "Any other proposed work.",
  ];

  Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.abc),
          )
        ],
        backgroundColor: Colors.blue[800],
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Thebes '),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                width: 50,
                'lib/assets/images/logo.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const Text(' Academy'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 220,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(
                  seconds: 3,
                ),
                autoPlayAnimationDuration: const Duration(
                  seconds: 1,
                ),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1,
              ),
              items: activitysImages.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .9,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(color: Colors.amber),
                      child: Image.asset(
                        i,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Social activity',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .4,
                    child: Divider(
                      color: Colors.blue[800],
                      thickness: 5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                      ),
                      Text('  2022-10-16'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ReadMoreText(
                      'Believing in the vital role of managing social activities and camps in the formation of an integrated and balanced personality, understanding self-affirmation, the ability to develop skills, deepening the spirit of participation and community through activities, creating appropriate opportunities for practicing activity, encouraging students to scientific research and providing technical and financial support in order to develop capabilities, develop skills and assume responsibility, and work on Providing social support to the incapable, people with special needs, patients and orphans (through guidance and counseling).\n\nIt is one of the pillars upon which the General Administration of Youth Welfare is based, through the activities implemented by the administration at the level of university students, as well as between students of the university and other universities.',
                      trimLines: 10,
                      // textAlign: TextAlign.left,
                      lessStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                      moreStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                      trimMode: TrimMode.Line,
                      trimCollapsedText: " Show More ",
                      trimExpandedText: " Show Less ",
                      style: const TextStyle(
                        fontSize: 18,
                        height: 1.2,
                        wordSpacing: -2,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.blue[800],
                    thickness: 5,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'The most important activities:-',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: activitys.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryDetails(),
                              ),
                            );
                          }),
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 2.0,
                                  offset: const Offset(0.0, 4.0),
                                ),
                              ],
                              color: Colors.grey[300],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.social_distance,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        activitys[index],
                                        style: const TextStyle(
                                          // color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // const SizedBox(height: 30),
                  // const Text(
                  //   'Some pictures of the activities carried out:-',
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
