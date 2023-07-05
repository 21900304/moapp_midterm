import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';

class MorePage extends StatefulWidget {
  var name;
  var address;
  var star;
  var id;
  var phone;
  var des;

  MorePage(this.id, this.name,this.address ,this.star, this.phone, this.des,{Key? key}) : super(key: key);

  @override
  _MorePage createState() => _MorePage();
}

class _MorePage extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    IconData icon;
    if (appState.favorites.contains(widget.name)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: List<Widget>.generate(widget.star, (idx) {
                      return const Icon(Icons.star, color: Colors.yellow, size: 15);
                    }).toList(),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 25),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          widget.name,
                          textStyle: const TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                          speed: const Duration(milliseconds: 2000),
                        ),
                      ],
                      totalRepeatCount: 4,
                      pause: const Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    )
                ),
                Container(
                  child: Row(
                    children: [
                      const Icon(Icons.pin_drop, color: Colors.lightBlue,),
                      SizedBox(width: 5,),
                      Text(
                        widget.address,
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.lightBlue,),
                      const SizedBox(width: 5,),
                      Text(
                        widget.phone,
                        //widget.phone, // widget.number
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
    Widget textSection = Padding(
      padding: EdgeInsets.all(32),
      child: Text(
        widget.des,
        softWrap: true,
        style: const TextStyle(
          color: Colors.blueAccent,
          height: 1.6,
        ),
      ),
    );

    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    child: GestureDetector(
                        onDoubleTap: (){appState.toggleFavorite(widget.id, widget.name, widget.address ,widget.star, widget.phone, widget.des);},
                        child: Card(
                            clipBehavior: Clip.antiAlias,
                            // TODO: Adjust card heights (103)
                            child: Column(
                              // TODO: Center items on the card (103)
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AspectRatio(
                                    aspectRatio: 10 / 4,
                                    child: Hero(
                                      tag: "hero",
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap : (){
                                            //_toggleFavorite;
                                            appState.toggleFavorite(widget.id, widget.name, widget.address ,widget.star, widget.phone, widget.des);
                                          },
                                          child: Image.asset(
                                            'assets/images/${widget.id}-0.jfif',
                                            fit: BoxFit.fitWidth,

                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ]
                            )
                        )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(350, 0, 0, 0),
                    child: ElevatedButton.icon(
                      onPressed: () {appState.toggleFavorite(widget.id, widget.name, widget.address ,widget.star, widget.phone, widget.des);}, icon: Icon(icon), label: Text(''),
                    ),
                  ),
                ],
              ),
            ),
            titleSection,
            textSection,
          ],
        ),
      ),
    );
  }
}




