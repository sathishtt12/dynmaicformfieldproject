

import 'package:flutter/material.dart';
//import 'package:flutter_bloc_http_get/repos/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:untitled3/blocs/app_blocs.dart';
import 'package:untitled3/blocs/app_state.dart';
import 'package:untitled3/repos/respositories.dart';


import 'blocs/app_event.dart';
import 'blocs/detai_'
    'screen.dart';
import 'models/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      
      home:RepositoryProvider(
        create: (context)=> UserRepository(),
        child:  Home(),)

    );
  }
}
class Home extends StatelessWidget {
  Future _handleRefrsh () async {
    return await Future.delayed(Duration(seconds: 1));

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>UserBloc(
          RepositoryProvider.of<UserRepository>(context),
        )..add(LoadUserEvent()),
    child: Scaffold(
      appBar: AppBar(
        title: Text('the bloc app'),

      ),
      body: LiquidPullToRefresh(
        onRefresh: _handleRefrsh,
        child:BlocBuilder<UserBloc,UserState>(
            builder: (context,state){
              if(state is UserLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(state is UserLoadedState){
                List<UserModel> userList=state.users;
                return ListView.builder(
                    itemCount:userList.length,
                    itemBuilder:(_,index){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: (){

                            Future.delayed(Duration(seconds: 5));
                            Navigator.of(context).push(

                              MaterialPageRoute(
                                builder: (context)=> DetailScreen(
                                  e:userList[index],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color:Colors.white,
                            elevation: 20,
                            shadowColor: Colors.brown,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              title: Text(userList[index].firstname),
                              subtitle: Text(userList[index].email),
                              leading: CircleAvatar(
                                maxRadius: 35,
                                backgroundImage: NetworkImage (userList[index].avatar),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }
              if(state is UserErrorState){
                return Center(child: Text('Error'),);
              }
              return  Container();
            }
        )
      )




    ),
    );
  }
}


