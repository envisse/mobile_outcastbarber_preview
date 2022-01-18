import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_outcastbarber/business_logic/cubit/pdfexport/pdfexport_cubit.dart';
import 'package:mobile_outcastbarber/business_logic/cubit/recaprecord_cubit.dart/recaprecord_cubit.dart';
import 'package:mobile_outcastbarber/business_logic/cubit/recordv2/recordv2_cubit.dart';
import 'package:mobile_outcastbarber/business_logic/cubit/user_cubit/user_cubit.dart';
import 'package:mobile_outcastbarber/routes/args/detail_args.dart';
import 'package:mobile_outcastbarber/services/repository/firebase/userProfile.dart';
import 'package:mobile_outcastbarber/views/components/card/card.dart';
import 'package:mobile_outcastbarber/views/components/navigationbar/bottomNavigationBar.dart';
import 'package:mobile_outcastbarber/views/components/navigationbar/sideNavigationBar.dart';
import 'package:mobile_outcastbarber/views/components/text/text.dart';
import 'package:mobile_outcastbarber/views/shared/colors.dart';
import 'package:mobile_outcastbarber/views/shared/dimens.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//This Screen contain this :
part 'pages/homePage.dart';
part 'pages/servicePage.dart';
part 'pages/withdrawPage.dart';
part 'pages/stockPage.dart';
part 'screen.dart';
