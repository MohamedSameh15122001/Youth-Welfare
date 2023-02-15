import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

List<String> activitysImages = [
  "lib/assets/images/1.jpg",
  "lib/assets/images/2.jpg",
  "lib/assets/images/3.jpg",
  "lib/assets/images/4.jpg",
  "lib/assets/images/5.jpg",
  "lib/assets/images/6.jpg",
  "lib/assets/images/7.jpg",
  "lib/assets/images/8.jpeg",
];

class Home extends StatelessWidget {
  String paragraph =
      "Youth welfare aims to preserve the community's existence, survival and continuity; as the young man is the one who transmits the culture of the society, its systems, methods of thinking, its sciences, literature, and arts. Young people not only preserve the social heritage and social values within their society but also transport them to other societies.\n\nYouth welfare provides the youth with the activity that is practiced in leisure - the activity that leads to instill a sense of comfort and pleasure and freedom in the self and disposal of physical energy and emotional overload.\n\nYouth care is a range of services offered to young people through various committees with the aim of providing them with a kind of collective experience that allows them to grow.\n\nThe programs include directing students towards social development, health and psychological fitness as well as preparation for family life, professional orientation, and other activities that enhance the individual's performance and develop his innovative abilities. He also aims to deepen the belonging and loyalty to the community, the local community and the national society. The philosophy of life and seek to develop moral and spiritual values they have in the integration and consistency.\n\nIt also focuses on the programs and activities of projects protecting the environment from pollution, whether by activating environmental awareness and improving the aesthetic sense of the members and about nature and considering the house, street, neighborhood and university as parts of the environmental framework objective for activities and services in terms of hygiene and campaigns, afforestation, clearing areas of waste and other projects to improve the environment. It is also interested in developing the queen of scientific research in young people and helping them to face daily and vital problems in a scientific way based on finding the facts, cloning relationships, finding accurate analyzes, and finding suitable solutions for each problem.";
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 20),
                  const Text(
                    'Youth Welfare',
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
                      Text('  2022-06-02'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      paragraph,
                      style: const TextStyle(
                        fontSize: 18,
                        height: 1.2,
                        wordSpacing: -2,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
