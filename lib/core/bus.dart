import 'package:event_bus/event_bus.dart';

import 'log.dart';

class BusKey {
  final EventBus? event;
  final String? key;

  BusKey(this.event, this.key);

  String get getKey => (key ?? "");
}

class Bus {
  Map<Type, List<BusKey>> _factory = Map();

  Bus(List<Type> events) {
    events.forEach((f) => _factory[f] = []);
  }

  void listen<T extends BusData>(
      {required Map<String, Function(T)>? listen, String? key}) {
    if (_factory.containsKey(T)) {
      Log().info(T);
      var bus = EventBus();
      bus.on<T>().listen((T data) {
        listen![data.method]!(data);
      });
      BusKey busKey = BusKey(bus, key);
      _factory[T]?.add(busKey);
    } else {
      Log().warning("Not found: $T");
    }
  }

  //key == null => fire all
  void fire<T extends BusData>(T fire, {String? key}) {
    if (_factory[T] != null) {
      Log().info(T);
      _factory[T]?.forEach((bus) {
        BusKey _private = BusKey(bus.event, key ?? "null");
        if (_private.getKey == bus.getKey || key == null) {
          Log().info("fire: " + bus.getKey);
          bus.event?.fire(fire);
        }
      });
    } else {
      Log().warning("Not found: $T");
    }
  }

//key == null => remove all
  void destroy<T extends BusData>({String? key}) {
    if (_factory[T] != null) {
      Log().info(T);
      _factory[T] = _factory[T]!.where((bus) {
        BusKey _private = BusKey(bus.event, key ?? "null");
        if (_private.getKey == bus.getKey || key == null) {
          Log().info("destroy: " + bus.getKey);
          return false;
        }
        return true;
      }).toList();
    } else {
      Log().warning("Not found: $T");
    }
  }
}

class BusData {
  final String? method;
  final dynamic data;

  BusData(this.method, {this.data});
}
