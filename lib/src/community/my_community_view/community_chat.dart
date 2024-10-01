import 'package:chatview/chatview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';

class CommunityChat extends StatefulWidget {
  const CommunityChat({super.key});

  @override
  State<CommunityChat> createState() => _CommunityChatState();
}

class _CommunityChatState extends State<CommunityChat> {
  late final ChatController chatController;
  late final List<Map<String, dynamic>> users;

  @override
  void initState() {
    super.initState();
    chatController = ChatController(
      initialMessageList: [],
      scrollController: ScrollController(),
      currentUser: ChatUser(id: '1', name: 'Flutter'),
      otherUsers: [ChatUser(id: '2', name: 'Simform')],
    );

    fetchUsers(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Future<void> fetchUsers(BuildContext context) async {
    try {
      final Dio dio = Dio();
      final String? email = Auth().currentUser?.email;
      final response =
          await dio.get("$serverURLExpress/community-members/${email!}");

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        users = data.map((e) => e as Map<String, dynamic>).toList();

        chatController = ChatController(
          initialMessageList: [],
          scrollController: ScrollController(),
          currentUser: ChatUser(id: '1', name: 'Flutter'),
          otherUsers: users
              .map((e) => ChatUser(id: e['_id'], name: e['name']))
              .toList(),
        );
      } else {
        createQuickAlert(
          context: context,
          title: "Error Fetching users",
          message: "Error: ${response.statusCode}",
          type: "error",
        );
      }
    } catch (e) {
      createQuickAlert(
        context: context,
        title: "Error Fetching users",
        message: "$e",
        type: "error",
      );
    }
  }
}
