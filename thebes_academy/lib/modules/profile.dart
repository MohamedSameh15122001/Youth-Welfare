import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
          right: 12.0,
          bottom: 12.0,
          top: 30.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 80,
                  backgroundImage:
                      AssetImage('lib/assets/images/user_image.jpg'),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              'Code: 201900000',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Specialization: computer scinece',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Activites: football, chess',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  height: 60,
                  onPressed: () {},
                  color: Colors.blue[800],
                  child: const Text(
                    'SIGN OUT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
