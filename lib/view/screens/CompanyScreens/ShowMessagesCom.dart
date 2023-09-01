import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prog_jobs_grad/controller/FirebaseAuthController.dart';
import 'package:prog_jobs_grad/providers/MessagesComProvider.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/ConversationScreen.dart';
import 'package:provider/provider.dart';

import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';

class ShowMessagesCom extends StatefulWidget {
  static const String id = "show_messages_Com";
  const ShowMessagesCom({Key? key}) : super(key: key);

  @override
  State<ShowMessagesCom> createState() => _ShowMessagesComState();
}

class _ShowMessagesComState extends State<ShowMessagesCom> {
  late Stream<List<DocumentSnapshot<Map<String, dynamic>>>> programmersStream;

  @override
  void initState() {
    super.initState();
    Provider.of<MessagesComProvider>(context, listen: false)
        .getAllMessagesComObjects();
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: SizeConfig.scaleWidth(25),
            ),
            color:  Color(0xffF5F5F5),
          ),
        ],
      ),
      body: Consumer<MessagesComProvider>(
        builder: (context, messagesComProvider, _) => messagesComProvider
            .messagesList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: messagesComProvider.messagesList.length,
                      itemBuilder: (BuildContext context, int index) {

                        // لازالة الثواني من الوقت
                        late String formattedTime;
                        String timeString =  messagesComProvider.messagesList[index].current_time ?? "";
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
                                    ,programmerId:messagesComProvider.messagesList[index].progId! ,
                                     progUsername: messagesComProvider.messagesList[index].senderMessage! ,
                                    companyUsername:"" ,
                                    progImage:messagesComProvider.messagesList[index].progImage!,);
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
                                          messagesComProvider.messagesList.isNotEmpty
                                              ? messagesComProvider.messagesList[index].progImage ?? ""
                                              : "No Prog Image",
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
                                            top: 15
                                          ),
                                          child: Text(
                                            messagesComProvider.messagesList.isNotEmpty
                                                ? messagesComProvider.messagesList[index].senderMessage ?? ""
                                                : "No Sender Name",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),

                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:EdgeInsetsDirectional.only(
                                      top: 10
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          messagesComProvider.messagesList.isNotEmpty
                                              ? formattedTime ?? ""
                                              : "No Current Time",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                          ),
                                        ),
                                        SizedBox(height: SizeConfig.scaleHeight(5),),
                                        Text(
                                          messagesComProvider.messagesList.isNotEmpty
                                              ? messagesComProvider.messagesList[index].current_date?? ""
                                              : "No Current Date",
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
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}




