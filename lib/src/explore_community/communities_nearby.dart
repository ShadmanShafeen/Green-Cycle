import 'package:flutter/material.dart';
import 'package:green_cycle/src/explore_community/communities.dart';

class CommunitiesNearby extends StatelessWidget {
  const CommunitiesNearby({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.arrow_back_ios,
          ),
          title: const Column(
            children: [
              Text(
                'Communities',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Near You',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          actions: const [
            Icon(
              Icons.search,
            )
          ],
        ),
        body: ListView.builder(
            prototypeItem: const SizedBox(
              height: 200,
              width: double.infinity,
            ),
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                    image: AssetImage(communities[index].image),
                  )),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            communities[index].location,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            communities[index].com_name,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      const Icon(
                        Icons.arrow_circle_right,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
