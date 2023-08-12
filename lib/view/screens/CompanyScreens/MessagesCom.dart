import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/ConversationScreen.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';

class MessageCom extends StatefulWidget {
  static const String id = "messagesCom_screen";

  @override
  State<MessageCom> createState() => _MessageComState();
}

class _MessageComState extends State<MessageCom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: SizeConfig.scaleWidth(14),
          ),
          color: Color(0xff4C5175),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: SizeConfig.scaleWidth(22),
            ),
            color: Color(0xff4C5175),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextStyleWidget("Messages:", Color(0xffCBB523),
                SizeConfig.scaleTextFont(17), FontWeight.w600),
            SizedBox(height: SizeConfig.scaleHeight(5)),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 11,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: SizeConfig.scaleHeight(10)),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextStyleWidget(
                            "Today 11:30 AM",
                            Color(0xff4C5175),
                            SizeConfig.scaleTextFont(11),
                            FontWeight.w500),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return ConversationScreen();
                          }));
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Color(0xffcbb523),
                                  radius: 30,
                                  child: Image.asset(
                                    'assets/images/prof.png',
                                    height: SizeConfig.scaleHeight(55),
                                    width: SizeConfig.scaleWidth(88),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.scaleWidth(10),
                                ),
                                Expanded(
                                  child: TextStyleWidget(
                                      "Sohib Naser Khalaf",
                                      Color(0xff4C5175),
                                      SizeConfig.scaleTextFont(16),
                                      FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
