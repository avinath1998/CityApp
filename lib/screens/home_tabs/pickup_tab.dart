import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';

class PickupTab extends StatefulWidget {
  @override
  _PickupTabState createState() => _PickupTabState();
}

class _PickupTabState extends State<PickupTab> {
  final Logger logger = Logger("PickupTabState");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "Your Pickups",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20.0))
            ]),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("PickupStops")
              .where("customerId",
                  isEqualTo: BlocProvider.of<AuthBloc>(context).currentUser.id)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
            switch (snap.connectionState) {
              case ConnectionState.none:
                return Center(
                    child:
                        Text("Whoops, an error has occured, try again later."));
                break;
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
                break;
              case ConnectionState.active:
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          "${snap.data.documents[index]["pickupDay"]} at ${snap.data.documents[index]["pickupTime"]}"),
                      trailing: Text(
                          "Status: " + snap.data.documents[index]["status"]),
                    );
                  },
                  itemCount: snap.data.documents.length,
                );
                break;
              case ConnectionState.done:
                return Center(
                    child:
                        Text("Whoops, an error has occured, try again later."));
                break;
            }
          },
        ),
      ],
    ));
  }
}
