import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';
import 'detail_screen.dart';

class DashboardScreen extends StatelessWidget {

  final String email;

  const DashboardScreen({
    super.key,
    required this.email,
  });

  Future<void> logout(BuildContext context) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.clear();

    Navigator.pushAndRemoveUntil(

      context,

      MaterialPageRoute(
        builder: (context) =>
            const LoginScreen(),
      ),

      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {

    List<String> subjects = [

      "Mobile App Development",

      "Software Re-engineering",

      "Management Information Systems (MIS)",
    ];

    return Scaffold(

      appBar: AppBar(

        title: const Text("Dashboard"),
        centerTitle: true,

        actions: [

          IconButton(

            onPressed: () {
              logout(context);
            },

            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const SizedBox(height: 20),

            const CircleAvatar(

              radius: 50,

              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/300',
              ),
            ),

            const SizedBox(height: 20),

            Text(

              email,

              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            const Align(

              alignment: Alignment.centerLeft,

              child: Text(

                "Subjects",

                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(

              child: ListView.builder(

                itemCount: subjects.length,

                itemBuilder: (context, index) {

                  return Card(

                    elevation: 4,

                    margin:
                        const EdgeInsets.only(
                      bottom: 15,
                    ),

                    child: ListTile(

                      leading: const Icon(
                        Icons.book,
                      ),

                      title: Text(
                        subjects[index],
                      ),

                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                      ),

                      onTap: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (context) =>
                                DetailScreen(
                              subjectName:
                                  subjects[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}