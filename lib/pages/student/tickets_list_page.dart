import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lecon/common/set_page_title.dart';
import 'package:flutter_lecon/widgets/appbars.dart';
import 'package:provider/provider.dart';
import '../../common/app_theme.dart';
import '../../models/ticket_model.dart';
import '../../services/firebase_auth_methods.dart';
import 'read_lecturer.dart';

class TicketsListPage extends StatelessWidget {
  static const routeName = '/tickets-list-page';

  TicketsListPage({Key? key}) : super(key: key);
  List list = [];

  @override
  Widget build(BuildContext context) {
    setPageTitle('Student | History', context);
    final user = context.read<FirebaseAuthMethods>().user;
    final auth = context.read<FirebaseAuthMethods>();
    return Scaffold(
      appBar: AppBars().builtStudentAppBar(
          user: user, context: context, title: 'History', auth: auth),
      body: SingleChildScrollView(
        child: StreamBuilder<List<Ticket>>(
          stream: readStudentTickets(user: user),
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
                              buildStudecnticket(ticket, ticket.studentUid))
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

  Stream<List<Ticket>> readStudentTickets({required user}) {
    return FirebaseFirestore.instance
        .collection('tickets')
        .where('creator', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Ticket.fromJson(doc.data())).toList());
  }

  Widget buildStudecnticket(Ticket ticket, studentUid) {
    return Container(
      width: 350,
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(20.0),
      decoration: AppBoxDecoration().all(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        buildLecturerStreamBuilder(ticket.teacherUid),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text(
              'Title: ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              ticket.title ?? 'Null',
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description: ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              ticket.description ?? 'Null',
              style: TextStyle(fontSize: 14),
              // TODO: THIS IS TEXT WRAP
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Reply: ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 3,
            ),
            ticket.status == "Answered" ?
            Text(
              ticket.reply ?? 'Null',
              style: TextStyle(fontSize: 14),
            ): Text('No reply yet')
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          thickness: 2,
        ),
        Center(
            child: Text(
          '${ticket.status}',
          style: TextStyle(
              color: ticket.status == 'Answered'
                  ? AppColors.Green
                  : ticket.status == 'Not read yet'
                      ? Color.fromRGBO(215, 213, 213, 1.0)
                      : ticket.status == 'Evaluated'
                          ? AppColors.Gold
                          : AppColors.LightRed),
        )),
        SizedBox(
          height: 5,
        ),
      ]),
    );
  }
}
