import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:mobile_outcastbarber/business_logic/cubit/crew/crew_cubit.dart';
import 'package:mobile_outcastbarber/business_logic/cubit/offering_cubit/offeringlist_cubit.dart';
import 'package:mobile_outcastbarber/models/crew.dart';
import 'package:mobile_outcastbarber/models/product.dart';
import 'package:mobile_outcastbarber/models/record/recordServices.dart';
import 'package:mobile_outcastbarber/models/record/recordWithdraws.dart';
import 'package:mobile_outcastbarber/models/service.dart';
import 'package:mobile_outcastbarber/models/withdraw.dart';
import 'package:mobile_outcastbarber/services/repository/firebase/recordv2.dart';
import 'package:mobile_outcastbarber/utils/currency.dart';
import 'package:mobile_outcastbarber/views/components/Dialog/BottomModal.dart';
import 'package:mobile_outcastbarber/views/components/Dialog/Dialogs.dart';
import 'package:mobile_outcastbarber/views/components/button/barrel.dart';
import 'package:mobile_outcastbarber/views/components/snackbar/snackbar.dart';
import 'package:mobile_outcastbarber/views/components/text/text.dart';
import 'package:mobile_outcastbarber/views/components/textfield/textfield.dart';
import 'package:mobile_outcastbarber/views/shared/colors.dart';
import 'package:mobile_outcastbarber/views/shared/dimens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


//This Screen contain this :
part 'screen.dart';
part 'pages/RecordService.dart';
part 'pages/RecordWithdraw.dart';

