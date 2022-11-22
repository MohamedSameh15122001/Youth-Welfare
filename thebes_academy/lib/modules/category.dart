import 'package:flutter/material.dart';
import 'package:thebes_academy/modules/register.dart';

class Category extends StatelessWidget {
  List<String> activitys = [
    "1- Opening of the new school year.",
    "2- The ideal male and female student competition at the university level.",
    "3- New Year's Celebration.",
    "4- Chess competition (teams - individual) at the university faculties level.",
    "5- Social research competition.",
    "6- Competition (student - coach).",
    "7- Celebration of the ideal mother.",
    "8- Orphan's Day Celebration.",
    "9- Organizing several leadership training camps in several governorates during the summer vacation.",
    "10- Seminars and community initiatives and the implementation of many medical convoys.",
    "11- People’s Festival under the name “Against Extremism and Terrorism”",
    "12- Social research competition at the level of Egyptian universities, institutes and academies.",
    "13- Girls' Youth Week.",
    "14- University Youth Week.",
    "15- Creativity competition.",
    "16 - Ideal students competition at the level of Egyptian universities.",
    "17- The first summit of universities at Benha University.",
    "18 - The project of employing students during the summer vacation.",
    "19- Any other proposed work.",
  ];
  List<String> activitysImages = [
    "lib/assets/images/images_of_c1.jpg",
    "lib/assets/images/images_of_c2.jpg",
    "lib/assets/images/images_of_c3.jpg",
    "lib/assets/images/images_of_c4.jpg",
    "lib/assets/images/images_of_c5.jpg",
    "lib/assets/images/images_of_c6.jpg",
    "lib/assets/images/images_of_c7.jpg",
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
        child: Padding(
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Believing in the vital role of managing social activities and camps in the formation of an integrated and balanced personality, understanding self-affirmation, the ability to develop skills, deepening the spirit of participation and community through activities, creating appropriate opportunities for practicing activity, encouraging students to scientific research and providing technical and financial support in order to develop capabilities, develop skills and assume responsibility, and work on Providing social support to the incapable, people with special needs, patients and orphans (through guidance and counseling).',
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.2,
                    wordSpacing: -2,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'It is one of the pillars upon which the General Administration of Youth Welfare is based, through the activities implemented by the administration at the level of university students, as well as between students of the university and other universities.',
                  style: TextStyle(
                    fontSize: 20,
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
                            builder: (context) => const Register(),
                          ),
                        );
                      }),
                      child: Text(
                        activitys[index],
                        style: TextStyle(color: Colors.blue[800]),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              const Text(
                'Some pictures of the activities carried out:-',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: activitysImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        activitysImages[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
