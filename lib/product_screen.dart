import 'dart:convert';

import 'package:crud_operations2/edit_user_screen.dart';
import 'package:crud_operations2/users.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

enum PopupMenuType { edit, delete }

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  List<Users> userList = [];

  @override
  void initState() {
    super.initState();
    callUsersRestAPI();
    //print('User List: $userList');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users'),),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return ListTile(
                    leading: const CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                          'https://cdn.vox-cdn.com/thumbor/LXInRMZr79bUxYyQxOGM0_EW9Og=/0x0:2000x1284/1200x800/filters:focal(840x482:1160x802)/cdn.vox-cdn.com/uploads/chorus_image/image/56473521/pizza_shoe12.0.jpg'),
                    ),
                    title: Wrap(
                      children: [
                        Text('Id:${userList[index].id}'),
                        const SizedBox(
                          width: 16,
                        ),
                        Text('Name: ${userList[index].name}'),
                      ],
                    ),
                    subtitle:  Wrap(
                      children: [
                        Text('Email: ${userList[index].email}'),
                        const SizedBox(
                          width: 16,
                        ),
                        Text('Gender: ${userList[index].gender}'),
                        const SizedBox(
                          width: 16,
                        ),
                        Text('Status: ${userList[index].status}'),
                      ],
                    ),
                    trailing: PopupMenuButton<PopupMenuType>(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: PopupMenuType.edit,
                          child: Wrap(
                            children: [
                              Icon(Icons.edit),
                              SizedBox(
                                width: 8,
                              ),
                              Text('Edit')
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: PopupMenuType.delete,
                          child: Wrap(
                            children: [
                              Icon(Icons.delete),
                              SizedBox(
                                width: 8,
                              ),
                              Text('Delete')
                            ],
                          ),
                        ),
                      ],
                      onSelected: (type){
                        switch(type){
                          case PopupMenuType.edit:
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const EditUserScreen()));
                          case PopupMenuType.delete:

                        }
                      },
                    ));
              })),
    );
  }
  void callUsersRestAPI()async{
 //Call URI
    Uri userURI = Uri.parse('https://gorest.co.in/public/v2/users');
 //Decode IRI
    Response userURIResponse = await get(userURI);
    //add data to list - read data
    print(userURIResponse.body);
    if(userURIResponse == 200) {
      var decodedRespose = jsonDecode(userURIResponse.body);
      for(var item in decodedRespose){
        Users users = Users(
          id: item['id'],
          name: item['name'],
          email: item['email'],
          gender: item['gender'],
          status: item['status'],
        );
        userList.add(users);
        setState(() {});
      }


    }

  }
}
