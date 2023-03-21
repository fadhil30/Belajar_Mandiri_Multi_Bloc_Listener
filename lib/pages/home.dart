import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_bloc/bloc/counter.dart';

import '../bloc/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    CounterBloc myCounter = context.read<CounterBloc>();
    ThemeBloc myTheme = context.read<ThemeBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MultiBlocListener(
              listeners: [
                BlocListener<ThemeBloc, bool >(
                  listener: (context, state) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('TEMA GELAP AKTIF'),
                      duration: Duration(seconds: 1),
                    ));
                  },
                  listenWhen: (previous, current) {
                    if (current == false) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                ),
                BlocListener<CounterBloc, int>(
                  listener: (context, state) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('DIATAS 10'),
                      duration: Duration(seconds: 1),
                    ));
                  },
                  listenWhen: (previous, current) {
                    if (current > 10) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                ),
              ],
              child: BlocBuilder<CounterBloc, int>(
                bloc: myCounter,
                builder: (context, state) {
                  return Text(
                    '$state',
                    style: const TextStyle(fontSize: 50),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    myCounter.remove();
                  },
                  icon: Icon(Icons.remove_circle_outline),
                ),
                IconButton(
                  onPressed: () {
                    myCounter.add();
                  },
                  icon: Icon(Icons.add_circle_outline),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        myTheme.changeTheme();
      }),
    );
  }
}
