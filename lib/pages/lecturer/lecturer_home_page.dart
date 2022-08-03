import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/ticket_model.dart';
import '../../services/firebase_auth_methods.dart';
import 'lecturer_profile_page.dart';
import 'reply_ticket_page.dart';

class LecturerHomePage extends StatelessWidget {
  static const routeName = '/lecturer-home-page';
  const LecturerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () =>
              Navigator.popAndPushNamed(context, LecturerProfilePage.routeName),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<Ticket>>(
          stream: readTickets(user: user),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final tickets = snapshot.data!;
              return Center(
                child: SizedBox(
                  width: 600,
                  child: Column(
                    children: tickets.map(buildTicket).toList(),
                  ),
                ),
              );
            } else {
              return Center(child: Text(snapshot.toString()));
            }
          },
        ),
      ),
    );
  }

  Stream<List<Ticket>> readTickets({required user}) {
    return FirebaseFirestore.instance
        .collection('tickets')
        .where('receiver', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Ticket.fromJson(doc.data())).toList());
  }

  Widget buildTicket(Ticket ticket) {
    return Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.all(23.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.4),
            borderRadius: BorderRadius.circular(23.0)),
        child: Container(
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('From: '),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Avatar'),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[Text('Button')],
              ),
            )
          ]),
        ));
  }
}

class ReplyButton extends StatelessWidget {
  const ReplyButton({Key? key, required this.ticket}) : super(key: key);
  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, ReplyTicketPage.routeName,
              arguments: {'ticket': ticket});
        },
        child: const Text('Answer'));
  }
}

//  ListTile(
//         leading: Text(ticket.id ?? 'EMPTY'),
//         title: Column(children: [
//           Text(ticket.description ?? 'EMPTY'),
//           Text(ticket.title ?? 'EMPTY'),
//           Text(ticket.studentUid ?? 'EMPTY'),
//           Text(ticket.teacherUid ?? 'EMPTY'),
//           Text(ticket.status ?? 'EMPTY'),
//         ]),
//         trailing: ReplyButton(
//           ticket: ticket,
//         ),
//       ),