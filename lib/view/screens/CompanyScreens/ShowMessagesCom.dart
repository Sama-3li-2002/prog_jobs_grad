import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prog_jobs_grad/controller/FirebaseAuthController.dart';
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
    programmersStream = getCompanyProgrammersMessagesStream(FirebaseAuthController.fireAuthHelper.userId());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programmers Conversations'),
      ),
      body: StreamBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
        stream: programmersStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No programmers available.'),
            );
          }

          List<DocumentSnapshot<Map<String, dynamic>>> programmers = snapshot.data!;

          return ListView.builder(
            itemCount: programmers.length,
            itemBuilder: (context, index) {
              DocumentSnapshot<Map<String, dynamic>> programmer = programmers[index];
              String programmerId = programmer.id;
              String lastMessage = "No messages yet";
              // Get the last message from the programmer
              return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('Company')
                    .doc(FirebaseAuthController.fireAuthHelper.userId())
                    .collection('programmers')
                    .doc(programmerId)
                    .collection('messages')
                    .limit(1)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    lastMessage = snapshot.data!.docs[0]['messageContent'];
                  }

                  return ListTile(
                    title: Text('Programmer ID: $programmerId'),
                    subtitle: Text(lastMessage),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
Stream<List<DocumentSnapshot<Map<String, dynamic>>>> getCompanyProgrammersMessagesStream(String companyId) {
  CollectionReference programmersCollection = FirebaseFirestore.instance.collection('Company')
      .doc(companyId)
      .collection('programmers');
  return programmersCollection.snapshots().map((querySnapshot) {
    return querySnapshot.docs.map((queryDocumentSnapshot) =>
    queryDocumentSnapshot as DocumentSnapshot<Map<String, dynamic>>
    ).toList();
  });

}