import 'dart:isolate';

class IsolateRunner {
  static Future<R> run<Q, R>(
      Future<R> Function(Q message) function,
      Q message,
      ) async {
    final response = ReceivePort();
    await Isolate.spawn<_IsolateMessage<Q>>(
      _isolateEntry,
      _IsolateMessage(function, message, response.sendPort),
    );
    return await response.first as R;
  }

  static void _isolateEntry<Q, R>(_IsolateMessage<Q> msg) async {
    final result = await msg.function(msg.message);
    msg.sendPort.send(result);
  }
}

class _IsolateMessage<Q> {
  final Future<dynamic> Function(Q) function;
  final Q message;
  final SendPort sendPort;

  _IsolateMessage(this.function, this.message, this.sendPort);
}
