import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:prog_jobs_grad/controller/FirebaseAuthController.dart';
import 'package:prog_jobs_grad/controller/FirebaseFireStoreHelper.dart';
import 'package:prog_jobs_grad/model/Message.dart';
import 'package:prog_jobs_grad/view/customWidget/textStyleWidget.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/ProfileInfoScreen.dart';
import 'package:prog_jobs_grad/view/screens/shared_screens/user_type.dart';
import '../../../utils/size_config.dart';

class ConversationScreen extends StatefulWidget {
  static const String id = "conversation_screen";
  //للمبرمج
   String? progUsername;
   String? progImage;
  String? programmerId;

  // للشركة
  String? companyUsername;
   String? comImage;
  String? companyId;


  ConversationScreen({
      this.progUsername,
      this.progImage,
      this.programmerId,
      this.companyUsername,
      this.comImage,
      this.companyId});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  late String messageContent;
  late String usernameSender;
  late TextEditingController MessagesController;
  Color? color = Colors.grey;

  // for date and time
  late String formattedDate;
  late String formattedTime;

  @override
  void initState() {
    super.initState();
    usernameSender = widget.progUsername!;
    MessagesController = TextEditingController();

    // for current time
    DateTime currentDate = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    formattedTime = DateFormat('hh:mm:ss a').format(currentDate);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    MessagesController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Color(0xff4C5175),
          elevation: 0,
          leading: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 3.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 15,
                    color: Color(0xffF5F5F5),
                  ),
                ),
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                shape: CircleBorder(),
                elevation: 4,
                color: Color(0xffcbb523),
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: ClipOval(
                    child: InkWell(
                      onTap: (){
                        if( UserTypeScreen.type == 'company'){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return ProfileInfo(widget.programmerId);
                              }));
                        }
                      },
                      child: Image.network(
                        UserTypeScreen.type == 'programmer'? widget.comImage! : widget.progImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          title: TextStyleWidget(UserTypeScreen.type == 'programmer'?widget.companyUsername! : widget.progUsername!, Colors.white,
              SizeConfig.scaleTextFont(15), FontWeight.w500),

        ),

        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/chatBackground.jpg"),
                  fit: BoxFit.cover,
                ),
              ),

              child: SingleChildScrollView(
                child: Container(
                  height: SizeConfig.scaleHeight(630),
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("Company")
                        .doc(widget.companyId)
                        .collection('programmersMessages')
                        .doc(widget.programmerId)
                        .collection('messages').orderBy("current_time",descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data == null) {
                        return Center(
                          child: Text("No messages available."),
                        );
                      }
                      final messagesQuery = snapshot.data!;
                      final messagesDocs = messagesQuery.docs;

                      final messages = messagesDocs
                          .map((doc) => Message.fromMap(doc.data()))
                          .toList();
                      return ListView.builder(
                        reverse: true,
                        // shrinkWrap: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {

                          final message = messages[index];
                          final content = message.content;
                          final time = message.current_time;
                          final type = message.type;


                          // لازالة الثواني من الوقت
                          late String formattedTime;
                          String timeString =
                              time ?? "";
                          try {
                            formattedTime = DateFormat('hh:mm a').format(
                                DateFormat('hh:mm:ss a').parse(timeString));
                          } catch (e) {
                            print("Invalid data format: $timeString");
                            formattedTime = "Invalid time format";
                          }
                          //---------------------------------------------------
                          print("Content $content");


                          final isMe = UserTypeScreen.type == type ;
                          return Padding(
                            padding: EdgeInsetsDirectional.only(
                              top: SizeConfig.scaleHeight(10),
                              end: isMe
                                  ? SizeConfig.scaleWidth(10)
                                  : SizeConfig.scaleWidth(220),
                              start: isMe
                                  ? SizeConfig.scaleWidth(220)
                                  : SizeConfig.scaleWidth(10),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isMe
                                    ? Color.fromRGBO(76, 81, 117, 0.3)
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: isMe
                                      ? Radius.circular(10)
                                      : Radius.circular(0),
                                  bottomRight: isMe
                                      ? Radius.circular(0)
                                      : Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.scaleHeight(10),
                                  horizontal: SizeConfig.scaleWidth(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: isMe
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(content,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight:
                                            FontWeight.w500)),
                                    SizedBox(
                                      height: 0.5,
                                    ),

                                    Row(
                                      children: [
                                        Spacer(),
                                        Text(formattedTime!,
                                            style: TextStyle(
                                                color: Color(0xff383737FF),
                                                fontSize: 11,
                                                fontWeight:
                                                FontWeight.w500)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),


            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.only(bottom:1.0),
                  child: Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: SizeConfig.scaleHeight(5),
                              left: SizeConfig.scaleWidth(5)),
                          child: SizedBox(
                            width: SizeConfig.scaleWidth(330),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 5,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.emoji_emotions_outlined,
                                      size: SizeConfig.scaleWidth(25),
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(40),
                                    width: SizeConfig.scaleWidth(270),
                                    child: TextField(
                                        controller: MessagesController,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: InputBorder.none,
                                          hintText: 'Messages...',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: SizeConfig.scaleTextFont(13),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 1),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          messageContent = value;
                                          setState(() {
                                            color = value.isEmpty
                                                ? Colors.grey
                                                : Colors.white;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 3),
                          child: SizedBox(
                            width: SizeConfig.scaleWidth(50),
                            height: SizeConfig.scaleHeight(100),
                            child: Card(
                              shape: CircleBorder(),
                              elevation: 4,
                              color: Color(0xff4C5175),
                              child: Center(
                                child: IconButton(
                                  onPressed: () async {
                                    if (messageContent!.isNotEmpty) {
                                      FocusScope.of(context).unfocus();
                                      await storeMessages(
                                          widget.companyId!);
                                      MessagesController?.clear();
                                      setState(() {
                                        messageContent = '';
                                        color = Colors.grey;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: color,
                                    size: SizeConfig.scaleWidth(20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        )


       );
  }

  Future storeMessages(String comId) async {
    await FirebaseFireStoreHelper.fireStoreHelper.sendMessageToCompany(
        comId,
        Message(
            content: messageContent,
            senderMessage: usernameSender,
            progImage: widget.progImage,
            current_time: formattedTime,
            current_date: formattedDate,
            progId: widget.programmerId,
            type: UserTypeScreen.type

        ));
  }
}