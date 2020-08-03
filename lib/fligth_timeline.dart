import 'package:airline_chellenge/flight_routes.dart';
import 'package:flutter/material.dart';

const _airplaneSize = 30.0;
const _dotSize = 15.0;

class FlightTimeline extends StatefulWidget {
  @override
  _FlightTimelineState createState() => _FlightTimelineState();
}

class _FlightTimelineState extends State<FlightTimeline> {
  bool animated = false;
  bool animatedCards = false;
  bool animatedButton = false;

  initAnimation() async {
    setState(() {
      animated = !animated;
    });
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      animatedCards = true;
    });
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      animatedButton = true;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initAnimation();
    });
    super.initState();
  }

  void _onRoutesPush() {
    Navigator.of(context).push(
      PageRouteBuilder(

        pageBuilder: (context, animation1, animation2) {
          return FadeTransition(opacity:animation1 ,child: FlightRoutes(),);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final centerDot = constraints.maxWidth / 2 - _dotSize / 2;
        return Stack(
          children: <Widget>[
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              left: constraints.maxWidth / 2 - _airplaneSize / 2,
              top: animated ? 20 : constraints.maxHeight - _airplaneSize - 10,
              bottom: 0.0,
              child: AircraftAndLine(),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: animated ? 80 : constraints.maxHeight,
              left: centerDot,
              child: TimelineDot(
                delay: const Duration(milliseconds: 600),
                pointsTimeline: true,
                displayCard: animatedCards,
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 600),
              top: animated ? 160 : constraints.maxHeight,
              right: centerDot,
              child: TimelineDot(
                delay: const Duration(milliseconds: 700),
                left: true,
                displayCard: animatedCards,
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 800),
              top: animated ? 240 : constraints.maxHeight,
              left: centerDot,
              child: TimelineDot(
                displayCard: animatedCards,
                delay: const Duration(milliseconds: 900),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1000),
              top: animated ? 320 : constraints.maxHeight,
              right: centerDot,
              child: TimelineDot(
                pointsTimeline: true,
                left: true,
                displayCard: animatedCards,
                delay: const Duration(milliseconds: 1100),
              ),
            ),
            if (animatedButton)
              Align(
                alignment: Alignment.bottomCenter,
                child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    child: FloatingActionButton(
                      backgroundColor: Colors.red,
                      onPressed: _onRoutesPush,
                      child: Icon(
                        Icons.check,
                      ),
                    ),
                    duration: const Duration(milliseconds: 400),
                    builder: (context, value, child) {
                      return Transform.scale(
                        child: child,
                        scale: value,
                      );
                    }),
              ),
          ],
        );
      },
    );
  }
}

class AircraftAndLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _airplaneSize,
      child: Column(
        children: <Widget>[
          Icon(Icons.flight, color: Colors.red, size: _airplaneSize),
          Expanded(
            child: Container(width: 2, color: Colors.grey.shade300),
          )
        ],
      ),
    );
  }
}

class TimelineDot extends StatefulWidget {
  final bool pointsTimeline;
  final bool displayCard;
  final bool left;
  final Duration delay;

  const TimelineDot({Key key,
    this.pointsTimeline = false,
    this.displayCard = false,
    this.left = false,
    this.delay})
      : super(key: key);

  @override
  _TimelineDotState createState() => _TimelineDotState();
}

class _TimelineDotState extends State<TimelineDot> {
  bool animated = false;

  @override
  void didUpdateWidget(TimelineDot oldWidget) {
    _animatedWithDelay();
    super.didUpdateWidget(oldWidget);
  }

  void _animatedWithDelay() async {
    if (widget.displayCard) {
      await Future.delayed(widget.delay);
      setState(() {
        animated = true;
      });
    }
  }

  _buildCard() =>
      TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 300),
          tween: Tween(begin: 0.0, end: 1.0),
          child: Card(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Jfk + Or'),
              ),
            ),
          ),
          builder: (context, value, child) {
            return Transform.scale(
                scale: value,
                child: child,
                alignment:
                widget.left ? Alignment.centerRight : Alignment.centerLeft);
          });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (animated && widget.left) ...[
          _buildCard(),
          Container(
            height: 1,
            width: 10,
            color: Colors.black54,
          ),
        ],
        Container(
          height: _dotSize,
          width: _dotSize,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade400),
              shape: BoxShape.circle),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
              backgroundColor:
              widget.pointsTimeline ? Colors.red : Colors.green,
            ),
          ),
        ),
        if (animated && !widget.left) ...[
          Container(
            height: 1,
            width: 10,
            color: Colors.black54,
          ),
          _buildCard(),
        ]
      ],
    );
  }
}
