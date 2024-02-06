import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:story_app_api/controller/story_controller.dart';
import 'package:story_app_api/utils/result_state.dart';
import 'package:story_app_api/widget/platform_widget.dart';

class StoriesListPage extends StatefulWidget {
  const StoriesListPage({super.key});

  @override
  State<StoriesListPage> createState() => _StoriesListPageState();
}

class _StoriesListPageState extends State<StoriesListPage> {
  Future<String> _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') ?? 'Guest';
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: _getUserName(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text('Welcome, ${snapshot.data}');
            } else {
              return const Text('Welcome'); // Default or loading state
            }
          },
        ),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: FutureBuilder<String>(
          future: _getUserName(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text('Welcome, ${snapshot.data}');
            } else {
              return const Text('Welcome'); // Default or loading state
            }
          },
        ),
        transitionBetweenRoutes: false,
        // trailing: IconButton(
        //     onPressed: () => Navigator.pushNamed(context, '/addstories'),
        //     icon: const Icon(CupertinoIcons.add_circled)),
      ),
      child: Material(
        child: _buildList(context),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          context.read<StoriesProvider>().fetchAllData();
        });
      },
      child: Consumer<StoriesProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return _buildShimmerList();
          } else {
            if (state.state == ResultState.hasData) {
              return ListView.builder(
                itemCount: state.result.listStory.length,
                itemBuilder: (context, index) {
                  var stories = state.result.listStory[index];
                  return Container(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(),
                                  const SizedBox(width: 5),
                                  Text(
                                    stories.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.more_horiz_sharp))
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        CupertinoContextMenu(
                          actions: [
                            CupertinoContextMenuAction(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              trailingIcon: CupertinoIcons.share,
                              child: const Text('Share'),
                            ),
                            CupertinoContextMenuAction(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              trailingIcon: CupertinoIcons.heart,
                              child: const Text('Favorite'),
                            ),
                          ],
                          child: Image.network(
                            stories.photoUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                stories.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(width: 5),
                              SizedBox(
                                child: Text(
                                  stories.description,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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
                    OutlinedButton(
                      onPressed: () {
                        context.read<StoriesProvider>().fetchAllData();
                      },
                      child: const Text('Refresh'),
                    )
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

  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(),
                          const SizedBox(width: 5),
                          Container(
                            width: 100,
                            height: 20,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz_sharp),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                AspectRatio(
                  aspectRatio: 1.7 / 2,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 20,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 200,
                        height: 20,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FloatingAction extends StatelessWidget {
  const FloatingAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 70),
          child: FloatingActionButton(
            onPressed: () {
              print('click en botton');
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (context) =>NewMarket()),
              // );
            },
            backgroundColor: Colors.red,
            child: const Icon(Icons.queue),
          ),
        ),
      ],
    );
  }
}
