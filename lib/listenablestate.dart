library listenablestate;

import 'package:flutter/widgets.dart';

//Create an listenablestate instance
//final counterNotifier = listenablestate(0);

//Read the state
//counterNotifier.state

//Update the state
//counterNotifier.update(counterNotifier.state + 1);

class ListenableState<T> extends ChangeNotifier {
  ListenableState(this._state);
  T _state;

  T get state => _state;

  void update(T state) {
    this._state = state;
    notifyListeners();
  }
}

class StateBuilder<T> extends StatefulWidget {
  final ListenableState<T> listenable;
  final Widget Function(BuildContext context, T state) builder;
  final bool Function(T oldState, T newState)? buildWhen;
  final void Function(BuildContext context, T state)? listen;

  const StateBuilder({
    super.key,
    required this.listenable,
    required this.builder,
    this.listen,
    this.buildWhen,
  });

  @override
  State<StateBuilder<T>> createState() => _StateBuilderState<T>();
}

class _StateBuilderState<T> extends State<StateBuilder<T>> {
  late T state;

  @override
  void initState() {
    state = widget.listenable.state;
    widget.listenable.addListener(callback);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant StateBuilder<T> oldWidget) {
    widget.listenable.addListener(callback);
    super.didUpdateWidget(oldWidget);
  }

  void callback() {
    if (widget.buildWhen != null) {
      bool shouldRebuild = widget.buildWhen!(state, widget.listenable.state);
      if (shouldRebuild != false) {
        updateStateAndRebuild();
      }
    } else {
      updateStateAndRebuild();
    }

    if (widget.listen != null) {
      widget.listen!(context, state);
    }
  }

  void updateStateAndRebuild() {
    state = widget.listenable.state;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      state,
    );
  }

  @override
  void dispose() {
    widget.listenable.removeListener(callback);
    super.dispose();
  }
}
