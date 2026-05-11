import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {

  final String subjectName;

  const DetailScreen({
    super.key,
    required this.subjectName,
  });

  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> subjectData = {

      "Mobile App Development": {

        "image":
            "https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c",

        "description":
            "This course focuses on developing modern mobile applications using Flutter framework. Students learn UI design, state management, APIs, and app deployment.",

        "schedule":
            "Monday & Wednesday\n10:00 AM - 11:30 AM",
      },

      "Software Re-engineering": {

        "image":
            "https://images.unsplash.com/photo-1515879218367-8466d910aaa4",

        "description":
            "This course teaches software maintenance, restructuring, reverse engineering, and modernization techniques used in large-scale systems.",

        "schedule":
            "Tuesday & Thursday\n1:00 PM - 2:30 PM",
      },

      "Management Information Systems (MIS)": {

        "image":
            "https://images.unsplash.com/photo-1454165804606-c3d57bc86b40",

        "description":
            "MIS explores how organizations use information systems and technology to improve business operations, decision-making, and management processes.",

        "schedule":
            "Friday\n9:00 AM - 12:00 PM",
      },
    };

    var currentSubject = subjectData[subjectName];

    return Scaffold(

      appBar: AppBar(
        title: const Text("Subject Detail"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Image.network(

              currentSubject["image"],

              height: 220,
              width: double.infinity,

              fit: BoxFit.cover,
            ),

            Padding(

              padding: const EdgeInsets.all(20),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(

                    subjectName,

                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(

                    "Course Description",

                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(

                    currentSubject["description"],

                    style: const TextStyle(
                      fontSize: 17,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(

                    "Schedule Details",

                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Card(

                    elevation: 4,

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15),
                    ),

                    child: Padding(

                      padding:
                          const EdgeInsets.all(18),

                      child: Row(

                        children: [

                          const Icon(
                            Icons.schedule,
                            size: 35,
                          ),

                          const SizedBox(width: 15),

                          Expanded(

                            child: Text(

                              currentSubject["schedule"],

                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}