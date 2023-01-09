import 'package:flutter/material.dart';
import '../../blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    ///!temporary
    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }
}

Widget buildList(StoriesBloc bloc) {
  return StreamBuilder(
    stream: bloc.topIds,
    builder: ((context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
        itemCount: snapshot.data?.length,
        itemBuilder: (context, int index) {
          return Text(
            snapshot.data![index].toString(),
          );
        },
      );
    }),
  );
}
