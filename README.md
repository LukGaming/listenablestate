# listenablestate

A Flutter package for state management with a customizable `listenablestate` and `StateBuilder` for building reactive UIs. The package includes features such as conditional rebuilding with `buildWhen` and state change listeners.

![Pub Version](https://img.shields.io/pub/v/listenablestate)
![License](https://img.shields.io/badge/license-MIT-blue)

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Examples](#examples)
- [API Reference](#api-reference)
- [Contributing](#contributing)
- [License](#license)

## Installation

To use this package, add `listenablestate` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  listenablestate: ^0.0.1

Then, run:
    flutter pub get

Usage
Basic Example

import 'package:flutter/material.dart';
import 'package:listenablestate/listenablestate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatelessWidget {
  final counterNotifier = listenablestate(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: Center(
        child: StateBuilder<int>(
          listenable: counterNotifier,
          builder: (context, count) {
            return Text('Count: $count');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterNotifier.update(counterNotifier.state + 1),
        child: Icon(Icons.add),
      ),
    );
  }
}

Conditional Rebuilding with buildWhen
    StateBuilder<int>(
    listenable: counterNotifier,
    buildWhen: (oldState, newState) => newState % 2 == 0,
    builder: (context, count) {
        return Text('Even Count: $count');
    },
    );

Listening to State Changes
    StateBuilder<int>(
    listenable: counterNotifier,
    listen: (context, count) {
        if (count == 10) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Reached 10!')),
        );
        }
    },
    builder: (context, count) {
        return Text('Count: $count');
    },
    );


API Reference
listenablestate: A class that holds a state and notifies listeners when the state changes.

listenablestate(T state): Creates a listenablestate with an initial state.
T get state: Returns the current state.
void update(T state): Updates the state and notifies listeners.
StateBuilder: A widget that rebuilds based on the state of a listenablestate.

StateBuilder({required listenablestate<T> listenable, required Widget Function(BuildContext, T) builder}): Creates a StateBuilder that listens to a listenablestate.


Contributing
Contributions are welcome! Please see the contributing guidelines for more details.

License
This package is licensed under the MIT License. See the LICENSE file for more details.