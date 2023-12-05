
import 'package:flutter/material.dart';

/*class EbChatScreen extends StatefulWidget {
  const EbChatScreen({Key? key}) : super(key: key);
  @override
  //State<EbChatScreen> createState() => _EbChatScreenState();
}*/

/*class _EbChatScreenState extends State<EbChatScreen> {
  StreamChatClient? client;
  User? currentUser;
  String ebchatKey =
      "ZcKRmDG40hbNfg/3L2lJ92jJ/r/IYUmMnwZZp3YTXOuX3bal2bcaHMScpmShkCMkJXDlSliSv9nIMnzx7ATosercD5vfzWk3C2NlrWX2JrC1cHhGQCGi3x1Z/1ZhSZgmTbAHKYce66qayzD1p2LY2lcZTnrsZhqp961xWHYrC/4=";

  String azureMapsApiKey = "AZUREMAPSKEY";
  @override
  void initState() {
    initilizeClient();
    currentUser = User(id: "Med6200", name: "Ali", extraData: const {
      "email": "info@letsplay.qa",
      "phone": "",
    });
    super.initState();
  }

  Future<void> initilizeClient() async {
    String key = await EBChatService.getCompanyStreamAcess(ebchatKey);
    client = StreamChatClient(key);
    client!
        .on(
      EventType.messageNew,
      EventType.notificationMessageNew,
    )
        .listen((event) {
      showNotifcation(event, context);
    });
    if (mounted) {
      setState(() {
        client;
      });
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color(0xff214496),
        title: const Text('Support Chat'),
      ),
      body: client != null
          ? EBChatWidget(
              key: const Key("Med6200"),
              ebchatToken: ebchatKey,
              client: client!,
              currentUser: currentUser!,
              azureMapsApiKey: azureMapsApiKey,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  void showNotifcation(Event event, BuildContext context) {
    if (![
      EventType.messageNew,
      EventType.notificationMessageNew,
    ].contains(event.type)) {
      return;
    }
    if (event.message == null) return;
  }
}*/
