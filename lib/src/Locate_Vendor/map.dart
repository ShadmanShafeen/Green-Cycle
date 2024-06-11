import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../widgets/nav_bar.dart";

class LocateMap extends StatelessWidget {
  const LocateMap({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> recentArray = [
      "Motijheel High School",
      "Dhaka University",
      "Dhaka Medical College",
      "Dhaka College",
      "Dhaka City College",
      "Dhaka Residential Model College",
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              context.go('/home');
            }
          },
        ),
        title: const Text(
          "Locate Your Vendor",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: Colors.black54),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            Image.asset(
              "lib/assets/images/map.png",
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Recents",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    ...recentArray.map(
                      (recent) => Column(
                        children: [
                          Card(
                            color: Colors.white10,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: InkWell(
                              onTap: () {
                            
                              },
                              highlightColor: Colors.grey,
                              splashColor: Colors.grey,
                              child: Row(children: [
                                const Icon(Icons.search),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    recent,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
          ]),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
