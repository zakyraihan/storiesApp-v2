import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app_api/controller/story_controller.dart';
import 'package:story_app_api/utils/result_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Consumer<StoriesProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (state.state == ResultState.hasData) {
              return ListView.builder(
                itemCount: state.result.listStory.length,
                itemBuilder: (context, index) {
                  var stories = state.result.listStory[index];
                  return ListTile(
                    title: Text(stories.name),
                  );
                },
              );
            } else if (state.state == ResultState.noData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error),
                    Text(state.message),
                  ],
                ),
              );
            } else {
              return const Scaffold();
            }
          }
        },
      ),
    );
  }
}
