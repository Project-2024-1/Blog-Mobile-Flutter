import 'dart:async';
import 'dart:collection';

class TaskRunner<A, B> {
  final Queue<A> _input = Queue();
  final StreamController<B> _streamController = StreamController();
  final Future<B> Function(A) task;

  final int maxConcurrentTasks;
  int runningTasks = 0;

  TaskRunner(this.task, {this.maxConcurrentTasks = 5});

  Stream<B> get stream => _streamController.stream;

  void add(A value) {
    _input.add(value);
    _startExecution();
  }

  void addAll(Iterable<A> iterable) {
    _input.addAll(iterable);
    _startExecution();
  }

  void _startExecution() {
    if (runningTasks == maxConcurrentTasks || _input.isEmpty) {
      return;
    }

    while (_input.isNotEmpty && runningTasks < maxConcurrentTasks) {
      runningTasks++;
      print('Concurrent workers: $runningTasks');

      task(_input.removeFirst()).then((value) async {
        _streamController.add(value);

        while (_input.isNotEmpty) {
          _streamController.add(await task(_input.removeFirst()));
        }

        runningTasks--;
        print('Concurrent workers: $runningTasks');
      });
    }
  }
}

// Random _rnd = Random();
// Future<List<String>> crawl(String x) =>
//     Future.delayed(Duration(seconds: _rnd.nextInt(5)), () => x.split('-'));

// void main() {
//   final runner = TaskRunner(crawl, maxConcurrentTasks: 3);

//   runner.stream.forEach((listOfString) {
//     if (listOfString.length == 1) {
//       print('DONE: ${listOfString.first}');
//     } else {
//       print('PUTTING STRINGS ON QUEUE: $listOfString');
//       runner.addAll(listOfString);
//     }
//   });

//   runner.addAll(['1-2-3-4-5-6-7-8-9', '10-20-30-40-50-60-70-80-90']);
// }