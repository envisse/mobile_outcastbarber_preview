part of 'barrel.dart';


class ExploreScreen extends StatelessWidget {
  const ExploreScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PdfConvert();
  }
}

// class ExploreScreen extends StatefulWidget {
//   @override
//   _ExploreScreenState createState() => _ExploreScreenState();
// }

// class _ExploreScreenState extends State<ExploreScreen> {
//   DateTimeRange selectedDate =
//       DateTimeRange(start: DateTime.now(), end: DateTime.now());

//   //DATE PICKER
//   _selectDate(BuildContext context) async {
//     final pickedDateRange = await showDateRangePicker(
//         context: context,
//         firstDate: DateTime(2000),
//         lastDate: DateTime(2025),
//         initialDateRange: selectedDate);

//     if (pickedDateRange != null && pickedDateRange != selectedDate) {
//       setState(() {
//         selectedDate = pickedDateRange;
//       });
//       context.read<Recordv2Cubit>().recordServiceInitial(selectedDate);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => Recordv2Cubit(),
//         ),
//         BlocProvider(
//           create: (context) => RecaprecordCubit()..recaprecordload(),
//         ),
//       ],
//       child: Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                   '//${DateFormat('d MMM ').format(selectedDate.start)} - ${DateFormat('d MMM ').format(selectedDate.end)}'),
//               ElevatedButton(
//                   onPressed: () {
//                     _selectDate(context);
//                   },
//                   child: Text('select date')),
//               SizedBox(height: 10),
//               BlocBuilder<Recordv2Cubit, Recordv2State>(
//                 bloc: Recordv2Cubit()..recordServiceInitial(selectedDate),
//                 builder: (context, state) {
//                   if (state is Recordv2Loading) {
//                     return CircularProgressIndicator();
//                   } else if (state is Recordv2ServiceLoaded) {
//                     return Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Wrap(
//                             runSpacing: 15,
//                             children: state.services
//                                 .map((e) => Row(children: [
//                                       Text('${e.nameCostumer}     date : '),
//                                       Text(DateFormat('d MMM y').format(e.date))
//                                     ]))
//                                 .toList()),
//                           BlocBuilder<RecaprecordCubit, RecaprecordState>(
//                             builder: (context, state) {
//                               if (state is RecaprecordLoaded){
//                                 return Column(
//                                   children: [
//                                     Row(children: [Text('earn serivce today =>'),Text('${state.recordRecap.earnservice}')],),
//                                     Row(children: [Text('earn withdraw today =>'),Text('${state.recordRecap.earnwithdraw}')],),
//                                   ],
//                                 );
//                               }
//                               return Center(child: Text('Bloc recaprecord error'));
//                             },
//                           )
//                       ],
//                     );
//                   } else if (state is Recordv2Empty) {
//                     return Text('record empty');
//                   } else if (state is Recordv2Error) {
//                     return Text('record error');
//                   }
//                   return Center(child: Text('Bloc record error'));
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
