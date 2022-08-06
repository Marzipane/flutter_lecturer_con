import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lecon/pages/lecturer/lecturer_home_page.dart';
import 'package:flutter_lecon/widgets/appbars.dart';
import 'package:provider/provider.dart';
import '../../common/formatter.dart';
import '../../common/set_page_title.dart';
import '../../models/ticket_model.dart';
import '../../services/firebase_auth_methods.dart';
import 'firbase_read.dart';

class ReplyTicketPage extends StatefulWidget {
  static const routeName = '/reply-ticket-page';

  const ReplyTicketPage({Key? key}) : super(key: key);

  @override
  State<ReplyTicketPage> createState() => _ReplyTicketPageState();
}

class _ReplyTicketPageState extends State<ReplyTicketPage> {
  final formKey = GlobalKey<FormState>();
  final _replyController = TextEditingController();
  String status = 'E';
  bool isOpen = true;

  @override
  void dispose() {
    super.dispose();
    _replyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setPageTitle('Lecturer | Reply', context);
    final user = context.read<FirebaseAuthMethods>().user;
    final auth = context.read<FirebaseAuthMethods>();
    final args = (ModalRoute.of(context)?.settings.arguments) as Map;
    final Ticket ticket = args['ticket'];
    if (isOpen) {
      updateStatus(ticket: ticket);
      isOpen = false;
    }
    return Scaffold(
      appBar: AppBars()
          .user(user: user, context: context, title: 'Reply form', auth: auth),
      body: Center(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 70),
                padding: EdgeInsets.all(20),
                width: 500,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.4),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildStreamBuilder(ticket.studentUid),
                      SizedBox(
                        height: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title:',
                            style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            ticket.title!,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Descritption:',
                              style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              )),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            ticket.description!,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2.0,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Your reply:',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: _replyController,
                        decoration: const InputDecoration(
                          labelText: 'Reply',
                          hintText: 'Your reply ...',
                          isDense: true,
                          contentPadding: EdgeInsets.all(20),
                          errorStyle: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ), // Added this
                        ),
                        maxLines: null,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(200,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced)
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty || value == '') {
                            return 'Status is "Answered", you must provide a reply!';
                          }
                          return null;
                        },
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
                        items: <String>[
                          'E',
                          'A',
                          'D'
                        ].map<DropdownMenuItem<String>>((String statusValue) {
                          return DropdownMenuItem<String>(
                            value: statusValue,
                            child: Text((() {
                              return Formatters().formatStatus(statusValue);
                            }())),
                            onTap: () {
                              if (statusValue == 'A') {
                                if (formKey.currentState!.validate()) {
                                  String reply = _replyController.text;
                                  updateTicket(
                                          reply: reply,
                                          ticket: ticket,
                                          status: statusValue)
                                      .then((_) => Navigator.popAndPushNamed(
                                          context, LecturerHomePage.routeName));
                                }
                              } else if (statusValue == "D") {
                                updateTicket(
                                        ticket: ticket, status: statusValue)
                                    .then((_) => Navigator.pushNamed(
                                        context, LecturerHomePage.routeName));
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  // Form buildReplyForm(Ticket ticket, BuildContext context) {
  //   return
  // }

  Future updateTicket({reply, required ticket, required status}) async {
    final docTicket =
        FirebaseFirestore.instance.collection('tickets').doc(ticket.id);
    print(status);
    docTicket
        .update({'status': Formatters().formatStatus(status), 'reply': reply});
  }

  Future updateStatus({required ticket}) async {
    final docTicket =
        FirebaseFirestore.instance.collection('tickets').doc(ticket.id);
    docTicket.update({'status': Formatters().formatStatus('E')});
  }
}
