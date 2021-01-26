import 'dart:convert';

  import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override

  List users = [];
  bool isLoading =false;
    void initState(){
      super.initState();
      this.fetchUser();
    }
  fetchUser() async{

      var url="https://randomuser.me/api/?results=100";
      var response= await http.get(url);
      if(response.statusCode==200){
        var items= json.decode(response.body)['results'];
        setState(() {
          users= items;
        });
      }
      else{
        setState(() {
          users=[];
        });
      }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("api fatch app"),
      ),

      body: getBody(),
    );
  }

  Widget getBody() {
    List items =[
      "1",
      "2"
    ];
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index)
    {
      return getCard(users[index]);

    });
  }
   Widget  getCard(item)
   {
     var fullname =item['name']['title']+""+item['name']['first']+""+item['name']['last'];
      var email =item ['email'];
      var pic =item['picture']['large'];
          return Padding(
        padding:  const EdgeInsets.all(10.0),
          child:Card(


        child:ListTile(
           title:
           Row(
        children: <Widget> [
          Container(
            width : 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(60/2),
              image: DecorationImage(
                  fit:BoxFit.cover,
                  image:
                  NetworkImage(pic.toString())
              )
              ),


          ),

              SizedBox(width: 20,),
              Column(
                children:<Widget>[
                Text(fullname.toString(),style: TextStyle(fontSize: 17),),

          SizedBox(height: 20,),

          Text(email.toString(),style: TextStyle(color: Colors.grey ),)



      ],
      )
        ],
      ),
      ),
     )
          );
  }
}