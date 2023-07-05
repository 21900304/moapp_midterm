import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'more.dart';

class myPage extends StatefulWidget {
  const myPage({Key? key}) : super(key: key);
  @override
  State<myPage> createState() => _myPageState();
}
class _myPageState extends State<myPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyPage'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: appState.favorites.length+2,
        itemBuilder: (context, index) {
          if(index == 0){
            return ClipOval(
              clipper: MyClipper(),
              child :  Lottie.network(
                  'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json',
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover),
            );
          }
          if(index == 1){
            return Container(
                child: Column(
                    children: const [
                      Text(
                        'Jeoug Hoon Park',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        '21900304',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'My Favorite Hotel List',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      )]));
          }
          index -= 2;

          final name = appState.favorites[index];
          final id = appState.ids[index];
          final address = appState.addresss[index];
          final star = appState.stars[index];
          final phone = appState.phones[index];
          final des = appState.dess[index];
          return Card(
              child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 10 / 4,
                      child: Hero(
                        tag: "hero",
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap : (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MorePage( id, name, address, star, phone, des)));},
                            child: Image.asset(
                              'assets/images/$id-0.jfif',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                            ),
                            Text(
                              address,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
              )
          );
        },
      )
    );
  }
}

class MyClipper extends CustomClipper<Rect> {

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }

}
