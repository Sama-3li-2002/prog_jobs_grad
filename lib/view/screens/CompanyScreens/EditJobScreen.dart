import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prog_jobs_grad/controller/FirebaseFireStoreHelper.dart';
import 'package:prog_jobs_grad/model/JobsModel.dart';
import 'package:prog_jobs_grad/view/customWidget/TextFieldWidget.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/com_home.dart';
import 'package:provider/provider.dart';
import '../../../providers/ComInfoProvider.dart';
import '../../../utils/size_config.dart';
import '../../customWidget/textStyleWidget.dart';
import 'CompanyInfoScreen.dart';

class EditJobScreen extends StatefulWidget {
  static const String id = "edit_job_screen";
  late List<Jobs> jobInfo;

  EditJobScreen({required this.jobInfo});

  @override
  State<EditJobScreen> createState() => _EditJobScreenState();
}

class _EditJobScreenState extends State<EditJobScreen> {
  TextEditingController? _sarlary;
  TextEditingController? _job_description;
  TextEditingController? _requried_skills_one;
  TextEditingController? _requried_skills_two;
  TextEditingController? _requried_skills_three;
  TextEditingController? _requried_skills_four;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ComInfoProvider>(context, listen: false).getComInfoObjects();

    _sarlary = TextEditingController(text: widget.jobInfo.first.salary);
    _job_description =
        TextEditingController(text: widget.jobInfo.first.job_description);
    _requried_skills_one =
        TextEditingController(text: widget.jobInfo.first.required_skills_one);
    _requried_skills_two =
        TextEditingController(text: widget.jobInfo.first.required_skills_two);
    _requried_skills_three =
        TextEditingController(text: widget.jobInfo.first.required_skills_three);
    _requried_skills_four =
        TextEditingController(text: widget.jobInfo.first.required_skills_four);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _sarlary?.dispose();
    _job_description?.dispose();
    _requried_skills_one?.dispose();
    _requried_skills_two?.dispose();
    _requried_skills_three?.dispose();
    _requried_skills_four?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: Consumer<ComInfoProvider>(
          builder: (context, comInfoProvider, _) => comInfoProvider
                  .comInfoList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: SizeConfig.scaleHeight(300),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                              ),
                              child: Image.asset(
                                "assets/images/image11.jpg",
                                fit: BoxFit.fill,
                                width: double.infinity,
                                color: Colors.black.withOpacity(0.7),
                                colorBlendMode: BlendMode.darken,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return CompanyInfo();
                                }));
                              },
                              child: FractionalTranslation(
                                translation: Offset(0.0, 0.5),
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.network(
                                    comInfoProvider.comInfoList.isNotEmpty
                                        ? comInfoProvider
                                                .comInfoList[0].image ??
                                            ""
                                        : "No Image",
                                    height: SizeConfig.scaleHeight(120),
                                    width: SizeConfig.scaleWidth(120),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              width: SizeConfig.screenWidth,
                              top: 10,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.zero,
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        size: SizeConfig.scaleWidth(20),
                                      ),
                                      color: Color(0xffD2D0D0FF),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.scaleHeight(65),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.apartment,
                              color: Color(0xffCBB523),
                              size: SizeConfig.scaleWidth(15),
                            ),
                            TextStyleWidget(
                                comInfoProvider.comInfoList.isNotEmpty
                                    ? comInfoProvider
                                            .comInfoList[0].companyName ??
                                        ""
                                    : "No Company Name",
                                Color(0xff4C5175),
                                SizeConfig.scaleTextFont(15),
                                FontWeight.w500),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.scaleHeight(10),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextStyleWidget(
                                    widget.jobInfo.isNotEmpty
                                        ? widget.jobInfo[0].job_name ?? ""
                                        : "No job Name",
                                    Color(0xffCBB523),
                                    SizeConfig.scaleTextFont(18),
                                    FontWeight.bold),
                                SizedBox(
                                  height: SizeConfig.scaleHeight(10),
                                ),
                                TextStyleWidget(
                                    "wage adjustment:",
                                    Color(0xff4C5175),
                                    SizeConfig.scaleTextFont(14),
                                    FontWeight.w500),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: SizeConfig.scaleWidth(8)),
                                    child: SizedBox(
                                      width: SizeConfig.scaleWidth(360),
                                      height: SizeConfig.scaleHeight(55),
                                      child: TextField(
                                        controller: _sarlary,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: r"$/months",
                                            hintStyle: TextStyle(
                                              fontSize:
                                                  SizeConfig.scaleTextFont(12),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.scaleHeight(10),
                                ),
                                TextStyleWidget(
                                    "Job description:",
                                    Color(0xff4C5175),
                                    SizeConfig.scaleTextFont(14),
                                    FontWeight.w500),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: TextField(
                                        controller: _job_description,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.scaleHeight(10),
                                ),
                                TextStyleWidget(
                                    "required skills:",
                                    Color(0xff4C5175),
                                    SizeConfig.scaleTextFont(14),
                                    FontWeight.w500),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: SizeConfig.scaleWidth(8),
                                          top: SizeConfig.scaleHeight(2),
                                          bottom: SizeConfig.scaleHeight(2),
                                        ),
                                        child: SizedBox(
                                          width: SizeConfig.scaleWidth(360),
                                          height: SizeConfig.scaleHeight(48),
                                          child: TextField(
                                            controller: _requried_skills_one,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'add the skill..',
                                                hintStyle: TextStyle(
                                                  fontSize:
                                                      SizeConfig.scaleTextFont(
                                                          12),
                                                )),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 1.5,
                                        color: Colors.grey.shade100,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: SizeConfig.scaleWidth(8),
                                          top: SizeConfig.scaleHeight(2),
                                          bottom: SizeConfig.scaleHeight(2),
                                        ),
                                        child: SizedBox(
                                          width: SizeConfig.scaleWidth(360),
                                          height: SizeConfig.scaleHeight(48),
                                          child: TextField(
                                            controller: _requried_skills_two,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'add the skill..',
                                                hintStyle: TextStyle(
                                                  fontSize:
                                                      SizeConfig.scaleTextFont(
                                                          12),
                                                )),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 1.5,
                                        color: Colors.grey.shade100,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: SizeConfig.scaleWidth(8),
                                          top: SizeConfig.scaleHeight(2),
                                          bottom: SizeConfig.scaleHeight(2),
                                        ),
                                        child: SizedBox(
                                          width: SizeConfig.scaleWidth(360),
                                          height: SizeConfig.scaleHeight(48),
                                          child: TextField(
                                            controller: _requried_skills_three,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'add the skill..',
                                                hintStyle: TextStyle(
                                                  fontSize:
                                                      SizeConfig.scaleTextFont(
                                                          12),
                                                )),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 1.5,
                                        color: Colors.grey.shade100,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: SizeConfig.scaleWidth(8),
                                          bottom: SizeConfig.scaleHeight(2),
                                          top: SizeConfig.scaleHeight(2),
                                        ),
                                        child: SizedBox(
                                          width: SizeConfig.scaleWidth(360),
                                          height: SizeConfig.scaleHeight(48),
                                          child: TextField(
                                            controller: _requried_skills_four,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'add the skill..',
                                                hintStyle: TextStyle(
                                                  fontSize:
                                                      SizeConfig.scaleTextFont(
                                                          12),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.scaleHeight(10),
                                ),
                                SizedBox(height: SizeConfig.scaleHeight(15)),
                                Center(
                                  child: Container(
                                    width: SizeConfig.scaleWidth(350),
                                    height: SizeConfig.scaleHeight(48),
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          FocusScope.of(context).unfocus();
                                          Fluttertoast.showToast(
                                            msg: "Updated successfully",
                                            toastLength: Toast.LENGTH_SHORT,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                          await performUpdate();
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return ComHomeScreen();
                                          }));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xff4C5175),
                                        ),
                                        child: TextStyleWidget(
                                            "Save",
                                            Color(0xffFAFAFA),
                                            SizeConfig.scaleTextFont(17),
                                            FontWeight.w700)),
                                  ),
                                ),
                              ]),
                        ),
                      ]),
                ),
        ),
      ),
    );
  }

  Future performUpdate() async {
    if (checkData()) await update();
  }

  bool checkData() {
    if (_sarlary!.text.isNotEmpty &&
        _job_description!.text.isNotEmpty &&
        _requried_skills_one!.text.isNotEmpty)
      return true;
    else
      print("can't be null");
    return false;
  }

  Future update() async {
    try {
      await FirebaseFireStoreHelper.instance
          .updateJobsDetails(getJobInfo(), widget.jobInfo[0].job_id!);
    } catch (e) {
      print("update : Exception: $e");
    }
  }

  Jobs getJobInfo() {
    return Jobs(
      job_description: _job_description?.text ?? '',
      salary: _sarlary?.text ?? '',
      required_skills_one: _requried_skills_one?.text ?? '',
      required_skills_two: _requried_skills_two?.text ?? '',
      required_skills_three: _requried_skills_three?.text ?? '',
      required_skills_four: _requried_skills_four?.text ?? '',
      job_image: widget.jobInfo.first.job_image,
      job_name: widget.jobInfo.first.job_name,
      company_name: widget.jobInfo.first.company_name,
      current_date: widget.jobInfo.first.current_date,
      current_time: widget.jobInfo.first.current_time,
      id: widget.jobInfo.first.id,
      job_id: widget.jobInfo.first.job_id,
    );
  }
}
