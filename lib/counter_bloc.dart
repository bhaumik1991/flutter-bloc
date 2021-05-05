import 'dart:async';

enum CounterAction{
  Increment,
  Decrement,
  Reset
}

class CounterBloc{
  int counter;
  final _stateStreamController = StreamController<int>.broadcast();
  StreamSink<int> get counterSink => _stateStreamController.sink; // input
  Stream<int> get counterStream => _stateStreamController.stream; // output

  final _eventStreamController = StreamController<CounterAction>();
  StreamSink<CounterAction> get eventSink => _eventStreamController.sink; // input
  Stream<CounterAction> get eventStream => _eventStreamController.stream; // output

  CounterBloc(){
    counter = 0;
    counterStream.listen((event) {});
    eventStream.listen((event) {

      if(event == CounterAction.Increment) counter++;
      else if(event == CounterAction.Decrement) counter--;
      else if(event == CounterAction.Reset) counter = 0;

      counterSink.add(counter);
    });
  }

  void dispose(){
    _stateStreamController.close();
    _eventStreamController.close();
  }
}