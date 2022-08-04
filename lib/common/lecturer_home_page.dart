// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_lecon/models/users_instance_model.dart';
// import 'package:provider/provider.dart';
// import '../../models/ticket_model.dart';
// import '../../services/firebase_auth_methods.dart';
// import '../pages/lecturer/reply_ticket_page.dart';
// import 'lecturer_profile_page.dart';
// import 'reply_ticket_page.dart';
//
// class LecturerHomePage extends StatelessWidget {
//   static const routeName = '/lecturer-home-page';
//   LecturerHomePage({Key? key}) : super(key: key);
//   List list = [];
//   @override
//   Widget build(BuildContext context) {
//     final user = context.read<FirebaseAuthMethods>().user;
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.person),
//           onPressed: () =>
//               Navigator.popAndPushNamed(context, LecturerProfilePage.routeName),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: StreamBuilder<List<Ticket>>(
//           stream: readTickets(user: user),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               final tickets = snapshot.data!;
//               return Center(
//                 child: SizedBox(
//                   width: 300,
//                   child: Column(
//                     children: tickets.map(buildTicket).toList(),
//                   ),
//                 ),
//               );
//             } else {
//               return Center(child: Text(snapshot.toString()));
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   Stream<List<Ticket>> readTickets({required user}) {
//     return FirebaseFirestore.instance
//         .collection('tickets')
//         .where('receiver', isEqualTo: user.uid)
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.docs.map((doc) => Ticket.fromJson(doc.data())).toList());
//   }
//
//   Widget buildTicket(Ticket ticket) {
//     var studentUid = ticket.studentUid;
//     getStudent(studentUid: studentUid);
//
//     return Container(
//         margin: const EdgeInsets.only(top: 15),
//         padding: const EdgeInsets.all(23.0),
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.black, width: 0.4),
//             borderRadius: BorderRadius.circular(23.0)),
//         child: Container(
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text('From: getStudent(Ticket t)'),
//             FutureBuilder(
//                 future: getStudent(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     return Text(list[0][0].email);
//                   }
//                   return CircularProgressIndicator();
//                 }), // getStudent
//             Center(child: Text('Button')),
//           ]),
//         ));
//   }
//
//   Future getStudent({studentUid}) async {
//     var listok = await FirebaseFirestore.instance
//         .collection('users')
//         .where('uid', isEqualTo: studentUid)
//         .get()
//         .then((snapshot) => snapshot.docs
//             .map((doc) => UserInstance.fromJson(doc.data()))
//             .toList());
//     list.add(listok);
//   }
// }
//
// class ReplyButton extends StatelessWidget {
//   const ReplyButton({Key? key, required this.ticket}) : super(key: key);
//   final Ticket ticket;
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//         onPressed: () {
//           Navigator.pushNamed(context, ReplyTicketPage.routeName,
//               arguments: {'ticket': ticket});
//         },
//         child: const Text('Answer'));
//   }
// }