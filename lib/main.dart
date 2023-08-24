import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/providers/ArchiveProvider.dart';
import 'package:prog_jobs_grad/providers/ComInfoProvider.dart';
import 'package:prog_jobs_grad/providers/CompaniesJobsProvider.dart';
import 'package:prog_jobs_grad/providers/CompanyJobsProvider.dart';
import 'package:prog_jobs_grad/providers/FavoriteProvider.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/AcceptPersonScreen.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/AddNewJobScreen.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/ArchiveScreen.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/CompanyInfoEditScreen.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/CompanyInfoScreen.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/ConversationScreen.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/EditJobScreen.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/MessagesCom.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/com_all_jobs.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/com_home.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/com_logo.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/no_of_request.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/FavoriteScreen.dart';
import 'package:prog_jobs_grad/view/screens/CompanyScreens/JobsCompanyDetailsScreen.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/MessagesProg.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/NotificationDetialsScreen.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/NotificationsScreen.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/ProfileInfoEditScreen.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/ProfileInfoScreen.dart';
import 'package:prog_jobs_grad/view/screens/shared_screens/SettingScreen.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/SubmitJopScreen.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/all_jobs.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/home.dart';
import 'package:prog_jobs_grad/view/screens/ProgrammerScreen/request_status.dart';
import 'package:prog_jobs_grad/view/screens/shared_screens/splash_screen.dart';
import 'package:prog_jobs_grad/view/screens/shared_screens/forget_password.dart';
import 'package:prog_jobs_grad/view/screens/shared_screens/login.dart';
import 'package:prog_jobs_grad/view/screens/shared_screens/signup.dart';
import 'package:prog_jobs_grad/view/screens/shared_screens/user_type.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CompanyJobsProvider>(create: (context) {
        return CompanyJobsProvider();
      }),
      ChangeNotifierProvider<ComInfoProvider>(create: (context) {
        return ComInfoProvider();
      }),
      ChangeNotifierProvider<CompaniesJobsProvider>(create: (context) {
        return CompaniesJobsProvider();
      }),
      ChangeNotifierProvider<FavoriteProvider>(create: (context) {
        return FavoriteProvider();
      }),
      ChangeNotifierProvider<ArchiveProvider>(create: (context) {
        return ArchiveProvider();
      }),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        UserTypeScreen.id: (context) => UserTypeScreen(),
        LoginScreen.id: (context) => LoginScreen(
              userType: '',
            ),
        SignupScreen.id: (context) => SignupScreen(userType: ''),
        ForgetPasswordScreen.id: (context) => ForgetPasswordScreen(
              userType: '',
            ),
        HomeScreen.id: (context) => HomeScreen(),
        AllJobScreen.id: (context) => AllJobScreen(),
        RequestStatusScreen.id: (context) => RequestStatusScreen(),
        NotificationScreen.id: (context) => NotificationScreen(),
        SettingScreen.id: (context) => SettingScreen(),
        JobsCompanyDetailsScreen.id: (context) => JobsCompanyDetailsScreen(
              items: [],
            ),
        SubmitJopScreen.id: (context) => SubmitJopScreen(
              itemsComInfo: [],
              ComId: '',
              JobId: '',
            ),
        ComLogoScreen.id: (context) => ComLogoScreen(comName: ""),
        NumberOfRequestsScreen.id: (context) => NumberOfRequestsScreen(),
        ComAllJobScreen.id: (context) => ComAllJobScreen(),
        ComHomeScreen.id: (context) => ComHomeScreen(),
        AddNewJobScreen.id: (context) => AddNewJobScreen(),
        MessageCom.id: (context) => MessagesProg(),
        MessagesProg.id: (context) => MessagesProg(),
        EditJobScreen.id: (context) => EditJobScreen(jobInfo: []),
        NotificationDetailsScreen.id: (context) => NotificationDetailsScreen(),
        ConversationScreen.id: (context) => ConversationScreen(),
        AcceptPerson.id: (context) => AcceptPerson(),
        Archive.id: (context) => Archive(),
        Favorite.id: (context) => Favorite(),
        CompanyInfoEdit.id: (context) => CompanyInfoEdit(),
        CompanyInfo.id: (context) => CompanyInfo(),
        ProfileInfoEdit.id: (context) => CompanyInfoEdit(),
        ProfileInfo.id: (context) => CompanyInfo(),
      },
    );
  }
}
