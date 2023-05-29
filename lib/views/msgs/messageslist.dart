import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../controllers/messages_controller.dart';
import 'chatpage.dart';
import 'comps/styles.dart';
import 'comps/widgets.dart';
import 'package:get/get.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({Key? key}) : super(key: key);
  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  bool open  = false;
  @override
  Widget build(BuildContext context) {
    Get.find<MessagesController>().getAllMessagesList();
    return Scaffold(
      backgroundColor: Colors.indigo.shade400,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade400,
        title: const Text('Flash Chat'),
        elevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    open == true? open = false: open = true;
                  });
                },
                icon:  Icon(
                  open == true? Icons.close_rounded :Icons.search_rounded,
                  size: 30,
                )),
          )
        ],
      ),
      drawer: ChatWidgets.drawer(),
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(0),
                  child: Container(
                    color: Colors.indigo.shade400,
                    padding: const EdgeInsets.all(8),
                    height: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: Text(
                            'Recent Users',
                            style: Styles.h1(),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: 80,
                          child: GetBuilder<MessagesController>(builder: (messages){
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: messages.messagesList.length,
                                itemBuilder: (context, i) {
                                  return ChatWidgets.circleProfile(i);
                                },
                              );
                            }
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: Styles.friendsBox(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Text(
                            'Contacts',
                            style: Styles.h1().copyWith(color: Colors.indigo),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: GetBuilder<MessagesController>(builder: (messages){
                                return ListView.builder(
                                  itemCount: messages.messagesList.length,
                                  itemBuilder: (context, i) {
                                    return ChatWidgets.card(
                                      title: messages.messagesList[i].sender,
                                      subtitle: messages.messagesList[i].comment,
                                      time: messages.messagesList[i].createdAt,
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              messages.getMSGDetails(messages.messagesList[i].sender_id.toString());
                                              if (kDebugMode) {
                                                print("ID:${messages.messagesList[i]}");
                                              }
                                              return ChatPage(
                                                id: messages.messagesList[i].sender_id.toString(),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              }
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ChatWidgets.searchBar(open)
          ],
        ),
      ),
    );
  }
}
