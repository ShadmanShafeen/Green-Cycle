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
  late ChatController? chatController = null;
  late final List<Map<String, dynamic>> users;
  ChatViewState chatViewState = ChatViewState.noData;

  @override
  void initState() {
    super.initState();
    fetchUsers(context);
  }

  @override
  void dispose() {
    chatController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: chatController != null
          ? ChatView(
              appBar: const ChatViewAppBar(
                backGroundColor: Colors.black87,
                backArrowColor: Colors.white,
                chatTitle: "Community Chat",
                chatTitleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                userStatus: "online",
                userStatusTextStyle: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 14,
                ),
                actions: [
                  Icon(Icons.more_vert),
                  SizedBox(width: 10),
                ],
              ),
              chatController: chatController!,
              chatViewState: chatViewState,
              onSendTap: onSendTap,
              featureActiveConfig: const FeatureActiveConfig(
                enableSwipeToReply: true,
                enableSwipeToSeeTime: false,
              ),
              chatBubbleConfig: ChatBubbleConfiguration(
                onDoubleTap: (message) {
                  // Your code goes here
                },
                outgoingChatBubbleConfig: const ChatBubble(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                inComingChatBubbleConfig: const ChatBubble(
                  // Receiver's message chat bubble
                  color: Colors.black87,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
              ),
              reactionPopupConfig: ReactionPopupConfiguration(
                backgroundColor: Colors.white,
                userReactionCallback: (message, emoji) {
                  // Your code goes here
                },
                padding: const EdgeInsets.all(12),
                shadow: const BoxShadow(
                  color: Colors.black54,
                  blurRadius: 20,
                ),
              ),
              sendMessageConfig: const SendMessageConfiguration(
                textFieldBackgroundColor: Colors.black87,
                enableCameraImagePicker: true,
                enableGalleryImagePicker: true,
                imagePickerIconsConfig: ImagePickerIconsConfiguration(
                  cameraIconColor: Colors.white,
                  galleryIconColor: Colors.white,
                ),
                voiceRecordingConfiguration: VoiceRecordingConfiguration(
                  iosEncoder: IosEncoder.kAudioFormatMPEG4AAC,
                  androidOutputFormat: AndroidOutputFormat.mpeg4,
                  androidEncoder: AndroidEncoder.aac,
                  bitRate: 128000,
                  sampleRate: 44100,
                  waveStyle: WaveStyle(
                    showMiddleLine: false,
                    waveColor: Colors.white,
                    extendWaveform: true,
                  ),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  void onSendTap(
      String message, ReplyMessage replyMessage, MessageType messageType) {
    final String currentUser = Auth().currentUser!.email!;

    final message0 = Message(
      id: '3',
      message: message,
      createdAt: DateTime.now(),
      sentBy: currentUser,
      replyMessage: replyMessage,
      messageType: messageType,
    );
    chatController!.addMessage(message0);
  }

  Future<void> fetchUsers(BuildContext context) async {
    try {
      setState(() {
        chatViewState = ChatViewState.loading;
      });

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
          currentUser:
              ChatUser(id: users.first['email'], name: users.first['name']),
          otherUsers: users
              .map(
                (e) => ChatUser(id: e['email'], name: e['name']),
              )
              .toList(),
        );

        setState(() {
          chatViewState = ChatViewState.hasMessages;
        });
      } else {
        createQuickAlert(
          context: context.mounted ? context : context,
          title: "Error Fetching users",
          message: "Error: ${response.statusCode}",
          type: "error",
        );
      }
    } catch (e) {
      createQuickAlert(
        context: context.mounted ? context : context,
        title: "Error Fetching users",
        message: "$e",
        type: "error",
      );
    }
  }
}
