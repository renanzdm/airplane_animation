import 'package:flutter/material.dart';

class FlightRoutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFE04148),
                    Color(0xFFd85774),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 20,
            child: BackButton(
              color: Colors.white,
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            top: MediaQuery.of(context).size.height * 0.20,
            child: Column(
              children: <Widget>[
                RouteItem(duration: Duration(milliseconds: 400)),
                RouteItem(duration: Duration(milliseconds: 600)),
                RouteItem(duration: Duration(milliseconds: 800)),
                RouteItem(duration: Duration(milliseconds: 1000)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RouteItem extends StatelessWidget {
  final Duration duration;

  const RouteItem({Key key, this.duration}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.decelerate,
      duration: duration,
      tween:Tween(
        begin: 1.0,end:0.0
      ),

      builder: (context,value,child){
        return Transform.translate(child: child,offset: Offset(0.0, MediaQuery.of(context).size.height * value),);
      },
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      'TESTE',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      "TESTE",
                      style: TextStyle(fontSize: 28, color: Colors.grey),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.flight,
                      color: Colors.red,
                      size: 30,
                    ),
                    Text(
                      "TESTE",
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      'TESTE',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      "TESTE",
                      style: TextStyle(fontSize: 28, color: Colors.grey),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
