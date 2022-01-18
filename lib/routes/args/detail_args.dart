import 'package:mobile_outcastbarber/models/record/recordServices.dart';
import 'package:mobile_outcastbarber/models/record/recordWithdraws.dart';

class DetailsArgs {
  final RecordServices? recordServices;
  final RecordWithdraws? recordWithdraws;
  DetailsArgs({this.recordServices, this.recordWithdraws});
}
