import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lecon/common/set_page_title.dart';
import 'package:flutter_lecon/widgets/appbars.dart';
import 'package:provider/provider.dart';
import '../../common/app_theme.dart';
import '../../models/ticket_model.dart';
import '../../services/firebase_auth_methods.dart';
import 'firbase_read.dart';

class TicketHistoryPage extends StatelessWidget {
  static const routeName = '/ticket-history-page';

  TicketHistoryPage({Key? key}) : super(key: key);
  List list = [];

  @override
  Widget build(BuildContext context) {
    setPageTitle('Lecturer | History', context);
    final user = context.read<FirebaseAuthMethods>().user;
    final auth = context.read<FirebaseAuthMethods>();
    return Scaffold(
      appBar: AppBars().builtLecturerAppBar(
          user: user, context: context, title: 'History', auth: auth),
      body: SingleChildScrollView(
        child: StreamBuilder<List<Ticket>>(
          stream: readLecturerTickets(user: user),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final tickets = snapshot.data!;
              return Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.spaceAround,
                      runAlignment: WrapAlignment.center,
                      children: tickets
                          .map((ticket) =>
                          buildLecturerTicket(ticket, ticket.studentUid))
                          .toList()),
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

  Stream<List<Ticket>> readLecturerTickets({required user}) {
    return FirebaseFirestore.instance
        .collection('tickets')
        .where('receiver', isEqualTo: user.uid)
        .where('status' , whereIn: ['Answered', 'Discarded'])
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Ticket.fromJson(doc.data())).toList());
  }

  Widget buildLecturerTicket(Ticket ticket, studentUid) {
    return Container(
      width: 350,
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(20.0),
      decoration: AppBoxDecoration().all(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        buildStreamBuilder(ticket.studentUid),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const Text(
              'Title: ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              ticket.title ?? 'Null',
              style: const TextStyle(fontSize: 14),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Description: ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              ticket.description ?? 'Null',
              style: const TextStyle(fontSize: 14),
            ),
            ticket.status == "Answered" ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reply: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 3,
                ),

                Text(
                  ticket.reply ?? 'Null',
                  style: const TextStyle(fontSize: 14),
                )
              ],
            ): const SizedBox.shrink(),

          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 2,
        ),
        Center(child: Text('${ticket.status}', style: TextStyle(color: ticket.status == 'Discarded' ? AppColors.LightRed: AppColors.Green, fontWeight: FontWeight.bold))),
        const SizedBox(
          height: 5,
        ),
      ]),
    );
  }
}
