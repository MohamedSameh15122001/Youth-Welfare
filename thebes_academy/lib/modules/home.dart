import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  List<String> paragraphs = [
    "Youth welfare aims to preserve the community's existence, survival and continuity; as the young man is the one who transmits the culture of the society, its systems, methods of thinking, its sciences, literature, and arts. Young people not only preserve the social heritage and social values within their society but also transport them to other societies.",
    "Youth welfare provides the youth with the activity that is practiced in leisure - the activity that leads to instill a sense of comfort and pleasure and freedom in the self and disposal of physical energy and emotional overload.",
    "Youth care is a range of services offered to young people through various committees with the aim of providing them with a kind of collective experience that allows them to grow.",
    "The programs include directing students towards social development, health and psychological fitness as well as preparation for family life, professional orientation, and other activities that enhance the individual's performance and develop his innovative abilities. He also aims to deepen the belonging and loyalty to the community, the local community and the national society. The philosophy of life and seek to develop moral and spiritual values they have in the integration and consistency.",
    "It also focuses on the programs and activities of projects protecting the environment from pollution, whether by activating environmental awareness and improving the aesthetic sense of the members and about nature and considering the house, street, neighborhood and university as parts of the environmental framework objective for activities and services in terms of hygiene and campaigns, afforestation, clearing areas of waste and other projects to improve the environment. It is also interested in developing the queen of scientific research in young people and helping them to face daily and vital problems in a scientific way based on finding the facts, cloning relationships, finding accurate analyzes, and finding suitable solutions for each problem.",
  ];
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.mail,
                          size: 30,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Mail Us',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Send your inquiry',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.call),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Call Us',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '232143 - 12432',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: paragraphs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      paragraphs[index],
                      style: const TextStyle(
                        fontSize: 20,
                        height: 1.2,
                        wordSpacing: -2,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
