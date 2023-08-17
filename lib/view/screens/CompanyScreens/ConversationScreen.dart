import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/view/customWidget/textStyleWidget.dart';

import '../../../utils/size_config.dart';

class ConversationScreen extends StatefulWidget {
  static const String id = "conversation_screen";

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.scaleWidth(5)),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: SizeConfig.scaleWidth(20),
                  color: Color(0xff4C5175),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Card(
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAlias,
                shape: CircleBorder(),
                elevation: 4,
                color: Color(0xffcbb523),
                child: SizedBox(
                  width: SizeConfig.scaleWidth(30),
                  height: SizeConfig.scaleHeight(30),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/prof1.png',
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        title: TextStyleWidget("technolgy Magic", Colors.black,
            SizeConfig.scaleTextFont(15), FontWeight.w500),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: SizeConfig.scaleWidth(25),
            ),
            color: Color(0xff4C5175),
          ),
        ],
      ),
      body: Column(
        children: [
          Text(
            "sama",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          Spacer(),
          Row(
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
                            size: SizeConfig.scaleWidth(
                              25,
                            ),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.scaleHeight(48),
                          width: SizeConfig.scaleWidth(100),
                          child: TextField(
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
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: SizedBox(
                    width: SizeConfig.scaleWidth(50),
                    height: SizeConfig.scaleHeight(100),
                    child: Card(
                      shape: CircleBorder(),
                      elevation: 4,
                      color: Color(0xff4C5175),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: SizeConfig.scaleWidth(20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
