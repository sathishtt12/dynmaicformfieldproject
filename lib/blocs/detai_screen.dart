import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/models/user_model.dart';

class DetailScreen extends StatelessWidget {

    final UserModel e;

  const DetailScreen({super.key, required this.e});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Center(

        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  maxRadius: 120,
                    backgroundImage: NetworkImage(e.avatar),
                ),
              ),
              Text(e.firstname+" "+e.lastname),
              Text(e.email),


            ],
          ),
        ),
      ),
    );
  }
}
