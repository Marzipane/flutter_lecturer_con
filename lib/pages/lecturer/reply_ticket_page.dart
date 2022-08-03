import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/formatter.dart';
import '../../models/ticket_model.dart';
import '../../services/firebase_auth_methods.dart';


class ReplyTicketPage extends StatefulWidget {
  static const routeName = '/reply-ticket-page';
  const ReplyTicketPage({Key? key}) : super(key: key);

  @override
  State<ReplyTicketPage> createState() => _ReplyTicketPageState();
}

class _ReplyTicketPageState extends State<ReplyTicketPage> {
  final _replyController = TextEditingController();
  String status = 'E';
  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    final args = (ModalRoute.of(context)?.settings.arguments) as Map;
    final Ticket ticket = args['ticket'];
    updateStatus(ticket: ticket);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Ticket'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 70),
          width: 500,
          child: Form(
            child: Column(
              children: [
                Text('Title: ${ticket.title!}'),
                Text('Description: ${ticket.description!}'),
                TextFormField(
                  controller: _replyController,
                  decoration: InputDecoration(
                    labelText: 'Reply',
                    hintText: 'Your reply ...',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton<String>(
                  value: status,
                  // icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  onChanged: (String? newStatusValue) {
                    setState(() {
                      status = newStatusValue!;
                    });
                  },
                  items: <String>['E', 'A', 'D']
                      .map<DropdownMenuItem<String>>((String statusValue) {
                    return DropdownMenuItem<String>(
                      value: statusValue,
                      child: Text((() {
                        return Formatters().formatStatus(statusValue);
                      }())),
                    );
                  }).toList(),
                ),
                ElevatedButton(
                    onPressed: () {
                      String reply = _replyController.text;
                      updateTicket(
                          reply: reply, ticket: ticket, status: status);
                    },
                    child: Text(user.uid))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future updateTicket(
      {required reply, required ticket, required status}) async {
    final docTicket =
        FirebaseFirestore.instance.collection('tickets').doc(ticket.id);
    docTicket
        .update({'status': Formatters().formatStatus(status), 'reply': reply});
  }

  Future updateStatus({required ticket}) async {
    final docTicket =
        FirebaseFirestore.instance.collection('tickets').doc(ticket.id);
    docTicket.update({'status': Formatters().formatStatus('E')});
  }
}
