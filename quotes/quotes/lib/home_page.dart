import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quotes/quote_model.dart';
import 'package:share/share.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  final List<Quote> quotes = [];

  Future<List<Quote>> fetchData() async {
    final url = Uri.https('www.type.fit', '/api/quotes');
    var res = await http.get(url);
    final data = jsonDecode(res.body);
    quotes.add(Quote.fromJson(data as Map<String, dynamic>));
    return quotes; //  return jsonDecode(res.body)["quotes"];
  }

  @override
  Widget build(BuildContext context) {
    final colors = [
      Vx.gray800,
      Vx.red800,
      Vx.blue800,
      Vx.green800,
      Vx.teal800,
      Vx.purple800,
      Vx.pink800,
      Vx.orange800
    ];
    return Material(
      child: FutureBuilder(
          future: fetchData(),
          builder: (context, AsyncSnapshot<List<Quote>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return StatefulBuilder(builder: (context, setState) {
                  final color = colors[Random().nextInt(8)];
                  return VxSwiper(
                      scrollDirection: Axis.vertical,
                      height: context.screenHeight,
                      viewportFraction: 1.0,
                      onPageChanged: (index) {
                        setState(() {});
                      },
                      items: snapshot.data!
                          .map<Widget>((el) => VStack(
                                [
                                  "Quotes".text.white.xl3.make(),
                                  "${el.title}"
                                      .text
                                      .white
                                      .italic
                                      .bold
                                      .xl4
                                      .make()
                                      .shimmer()
                                      .box
                                      .shadow2xl
                                      .make(),
                                  "${el.author}"
                                      .text
                                      .white
                                      .italic
                                      .bold
                                      .make()
                                      .shimmer()
                                      .box
                                      .shadow2xl
                                      .make(),
                                  IconButton(
                                      icon: Icon(
                                        Icons.share,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        Share.share("${el.title}");
                                      })
                                ],
                                crossAlignment: CrossAxisAlignment.center,
                                alignment: MainAxisAlignment.spaceAround,
                              )
                                  .animatedBox
                                  .p16
                                  .color(color)
                                  .make()
                                  .h(context.screenHeight))
                          .toList());
                });
                // return Offstage();
              }
              return "Nothing Found".text.makeCentered();
            } else if (snapshot.connectionState == ConnectionState.none) {
              return "Something went wrong".text.makeCentered();
            }
            return CircularProgressIndicator().centered();
          }),
    );
  }
}
