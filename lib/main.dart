import 'package:airline_chellenge/fligth_form.dart';
import 'package:airline_chellenge/fligth_timeline.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
enum FlightView {
  form,timeline
}

class _MyHomePageState extends State<MyHomePage> {
FlightView flightView = FlightView.form;

  void onFligthPressed() {
    setState(() {
      flightView = FlightView.timeline;
    });
  }

  @override
  Widget build(BuildContext context) {
    var headerHeigth = MediaQuery.of(context).size.height * 0.32;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            height: headerHeigth,
            left: 0,
            right: 0,
            child: DecoratedBox(
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
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Air Asia',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        HeaderButton(title: 'One way'),
                        HeaderButton(title: 'Rounded'),
                        HeaderButton(
                          title: 'Multicity',
                          selected: true,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            left: 10,
            top: headerHeigth / 2,
            bottom: 0,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    Expanded(
                      child: TabButton(
                        title: 'Fligth',
                        selected: true,
                      ),
                    ),
                    Expanded(
                      child: TabButton(title: 'Train'),
                    ),
                    Expanded(
                      child: TabButton(title: 'Bus'),
                    ),
                  ]),
                  Expanded(
                      child:flightView == FlightView.form ? FligthForm(
                    onTap: onFligthPressed,
                  ):FlightTimeline(),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderButton extends StatelessWidget {
  final String title;
  final bool selected;

  const HeaderButton({Key key, this.title, this.selected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: selected ? Colors.white : null,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            border: Border.all(color: Colors.white)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          child: Center(
            child: Text(title.toUpperCase(),
                style: TextStyle(color: selected ? Colors.red : Colors.white)),
          ),
        ));
  }
}

class TabButton extends StatelessWidget {
  final String title;
  final bool selected;

  const TabButton({Key key, this.title, this.selected = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(title,
                style: TextStyle(color: selected ? Colors.black : Colors.grey)),
          ),
          if (selected)
            Divider(
              color: Colors.red,
              thickness: 2,
            )
        ],
      ),
    );
  }
}
