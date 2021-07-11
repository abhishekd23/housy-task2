import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import '../post_model.dart';

List<String> months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sept",
  "Oct",
  "Nov",
  "Dec"
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showSpinner = true;
  PostModel? _posts;

  void createPosts() async {
    // showSpinner = true;
    setState(() {
      showSpinner = true;
    });
    final response = await http.post(
      Uri.parse('https://hoblist.com/movieList'),
      body: {
        "category": "movies",
        "language": "hindi",
        "genre": "all",
        "sort": "voting"
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      final String responseString = response.body;
      print(PostModel.fromJson(jsonDecode(responseString)));
      setState(() {
        _posts = PostModel.fromJson(jsonDecode(responseString));
        // showSpinner = false;
        showSpinner = false;
      });
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create post album.');
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    createPosts();
  }

  @override
  Widget build(BuildContext context) {
    return showSpinner
        ? Scaffold(
            backgroundColor: Color(0xFFF1C085),
            appBar: AppBar(
              title: Text("Home Page"),
              backgroundColor: Color(0xFFF1C085).withOpacity(0.5),
            ),
            body: Center(
              child: SpinKitRotatingCircle(
                color: Colors.white,
                size: 50.0,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Color(0xFFF1C085),
            appBar: AppBar(
              title: Text("Home Page"),
              backgroundColor: Color(0xFFF1C085).withOpacity(0.5),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Color(0xFFF1C085),
                        content: Text(
                          "Company: Housy \n Address: Pune, India \n Phone: XXXXXXXXX09 \n Email: XXXXXX@housy.com",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              setState(() {});
                              Navigator.pop(context, 'OK');
                            },
                            child: const Text(
                              'OK',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: _posts!.result!.length,
              itemBuilder: (context, index) {
                return MovieCard(
                  movieName: _posts!.result![index]['title'],
                  genre: _posts!.result![index]['genre'],
                  starring: _posts!.result![index]['stars'],
                  director: _posts!.result![index]['director'],
                  image: _posts!.result![index]['poster'],
                  pageViews: _posts!.result![index]['pageViews'],
                  votedBy: _posts!.result![index]['totalVoted'],
                  language: _posts!.result![index]['language'],
                  voting: _posts!.result![index]['voting'],
                  runtime: _posts!.result![index]['runTime'],
                  time: _posts!.result![index]['releasedDate'],
                );
              },
            ),
          );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard(
      {this.movieName,
      this.genre,
      this.starring,
      this.director,
      this.image,
      this.pageViews,
      this.votedBy,
      this.language,
      this.voting,
      this.runtime,
      this.time});
  final String? movieName;
  final String? genre;
  final List? starring;
  final List? director;
  final String? image;
  final int? pageViews;
  final int? votedBy;
  final String? language;
  final int? voting;
  final int? runtime;
  final int? time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF1C085),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.white, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: const Offset(
                5.0,
                5.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.arrow_drop_up_outlined,
                        size: 30.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "$voting",
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Icon(
                        Icons.arrow_drop_down_outlined,
                        size: 30.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Votes",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    //height: 160,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      // image: DecorationImage(
                      //   fit: BoxFit.fill,
                      //   image: NetworkImage("${image!}"),
                      // ),
                    ),
                    child: Image.network(image!),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$movieName",
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "Genre: $genre",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          "Director: ${director!.join(' , ')}",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          "Starring: ${starring!.join(', ')}",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          "$runtime Mins  |  $language  |  ${DateTime.fromMicrosecondsSinceEpoch(time!).day} ${months[DateTime.fromMicrosecondsSinceEpoch(time!).month]}",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          "$pageViews views | Voted by $votedBy people",
                          style: TextStyle(fontSize: 15, color: Colors.blue),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              InkWell(
                onTap: () {},
                child: new Container(
                  width: double.infinity,
                  height: 50.0,
                  decoration: new BoxDecoration(
                    color: Colors.blue,
                    border: new Border.all(color: Colors.white, width: 2.0),
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                  child: new Center(
                    child: new Text(
                      'Watch Trailer',
                      style: new TextStyle(
                          fontSize: 25.0,
                          color: Color(0xFFF1C085),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
