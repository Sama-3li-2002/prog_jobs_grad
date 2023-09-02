import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prog_jobs_grad/controller/FirebaseAuthController.dart';
import 'package:prog_jobs_grad/controller/FirebaseFireStoreHelper.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/ConversationScreen.dart';
import '../../../model/Message.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';

class ShowMessagesCom extends StatefulWidget {
  static const String id = "show_messages_Com";
  const ShowMessagesCom({Key? key}) : super(key: key);

  @override
  State<ShowMessagesCom> createState() => _ShowMessagesComState();
}

class _ShowMessagesComState extends State<ShowMessagesCom> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff4C5175),
          elevation: 0,
          leading: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: SizeConfig.scaleWidth(15)),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: SizeConfig.scaleWidth(20),
                    color: Color(0xffF5F5F5),
                  ),
                ),
              ),
            ],
          ),
          title: TextStyleWidget("Chats", Colors.white,
              SizeConfig.scaleTextFont(20), FontWeight.w500),
        ),
        body:
        StreamBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
          stream: FirebaseFireStoreHelper.fireStoreHelper.getCompanyProgrammersMessagesStream(
            FirebaseAuthController.fireAuthHelper.userId(),
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (!snapshot.hasData) {
              return Text('No programmers available.');
            }

            List<DocumentSnapshot<Map<String, dynamic>>> programmers = snapshot.data!;

            return FutureBuilder<List<Message>>(
              future: getLastMessages(programmers),
              builder: (context, messageSnapshot) {
                if (messageSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (!messageSnapshot.hasData) {
                  return Text('Error fetching messages.');
                }

                List<Message> lastMessages = messageSnapshot.data!;

                return ListView.builder(
                  itemCount: programmers.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot<Map<String, dynamic>> programmer =
                    programmers[index];
                    String senderName = programmer.get("senderName");
                    print("the sender name is:"+ senderName);
                    String lastMessage =
                    lastMessages.isNotEmpty ? lastMessages[index].content : "No messages yet";
                    print(lastMessages[index].content);print(lastMessages[index].current_time);

                    // لازالة الثواني من الوقت
                    late String formattedTime;
                    String timeString =  lastMessages[index].current_time ?? "";
                    try {
                      formattedTime = DateFormat('hh:mm a').format(DateFormat('hh:mm:ss a').parse(timeString));
                    } catch (e) {
                      print("Invalid data format: $timeString");
                      formattedTime = "Invalid time format";
                    }

                    return InkWell(
                      onTap: (){

                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return ConversationScreen(companyId: FirebaseAuthController.fireAuthHelper.userId()
                                ,programmerId:lastMessages[index].progId! ,
                                progUsername:lastMessages[index].senderMessage! ,
                                companyUsername:"" ,
                                progImage:lastMessages[index].progImage!,);
                            }));

                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                            bottom: 2
                        ),

                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: CircleBorder(),
                                color: Color(0xffcbb523),
                                child: SizedBox(
                                  width: 45,
                                  height: 45,
                                  child: ClipOval(
                                    child: Image.network(
                                      lastMessages[index].progImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          top: 10
                                      ),
                                      child: Text(
                                        lastMessages[index].senderMessage ?? "",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      lastMessages[index].content ?? "",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:EdgeInsetsDirectional.only(
                                    top: 10
                                ),
                                child: Column(
                                  children: [
                                    Text(formattedTime ?? "",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                    SizedBox(height: SizeConfig.scaleHeight(5),),
                                    Text(
                                      lastMessages[index].current_date?? "",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        )
    );
  }
  Future<List<Message>> getLastMessages(
      List<DocumentSnapshot<Map<String, dynamic>>> programmers) async {
    List<Message> lastMessages = [];

    for (var programmer in programmers) {
      String programmerId = programmer.id;
      print("the prog id:"+ programmerId);
      String lastMessage = "No messages yet";

      CollectionReference messagesCollection = FirebaseFirestore.instance
          .collection('Company')
          .doc(FirebaseAuthController.fireAuthHelper.userId())
          .collection('programmersMessages')
          .doc(programmerId)
          .collection('messages');

      QuerySnapshot<Object?> messagesSnapshot = await messagesCollection
          .orderBy('current_time', descending: true)
          .limit(1)
          .get();

      for (var element in messagesSnapshot.docs) {
        lastMessages.add(Message.fromMap(element.data() as Map<String, dynamic>));
      }

    }

    return lastMessages;
  }
}