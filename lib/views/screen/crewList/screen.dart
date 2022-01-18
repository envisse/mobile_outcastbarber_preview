part of 'barrel.dart';

class CrewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CrewCubit()..crewLoaded(),
      child: CrewListPage(),
    );
  }
}
