import 'package:flutter/material.dart';
import 'package:myclassmates/models/newsInfo.dart';
import 'package:myclassmates/services/api_manager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<NewsModel> _newsModel;

  @override
  void initState() {
    _newsModel = API_Manager().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('My Classmates')),
      ),
      body: Container(
        child: FutureBuilder<NewsModel>(
          future: _newsModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.users.length,
                  itemBuilder: (context, index) {
                    var user= snapshot.data.users[index];
                    print(user.name[0]);
                    return Container(
                      height: 70,
                      color: Colors.red,
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        children: <Widget>[
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0)),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                              user.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          SizedBox(width: 30.0),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10.0,),
                                Text(user.name,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                                Text(user.id,style: TextStyle( fontSize: 18.0),),


                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
