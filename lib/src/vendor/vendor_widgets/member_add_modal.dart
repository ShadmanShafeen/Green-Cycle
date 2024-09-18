import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/community/my_community_view/new_mem_req.dart';
import 'package:green_cycle/src/utils/server.dart';

class MemberAddModal extends StatefulWidget {
  const MemberAddModal({super.key});

  @override
  State<MemberAddModal> createState() => _MemberAddModalState();
}

class _MemberAddModalState extends State<MemberAddModal> {
  
  late final List joinRequests;
  Future<void> getJoinRequests() async {
    try {
      final dio = Dio();
      final email = Auth().currentUser?.email;
      final response =
          await dio.get("$serverURLExpress/vendor/join-requests/$email");
      joinRequests = response.data[0]['join_requests'];
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    getJoinRequests();
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          image: DecorationImage(
              image: AssetImage(
                'lib/assets/img/member_modal_bg.jpg',
              ),
              fit: BoxFit.cover,
              opacity: .8)),
      child: Column(
        children: [
          const SizedBox(
            height: 60,
            child: Center(
              child: Text(
                'Member Request',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: getJoinRequests(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LinearProgressIndicator(
                        color: Theme.of(context).colorScheme.surface,
                      );
                    }
                    else if (snapshot.hasError) {
                      return const Center(
                          child: Text(
                            'Error Fetching Data :(',
                            style: TextStyle(color: Colors.white),
                          ),
                      );
                    }
                    else {
                      return ListView(
                        children: [
                          ...joinRequests.map(toElement)
                        ],
                      )
                    }
                  })),
        ],
      ),
    );
  }
}
