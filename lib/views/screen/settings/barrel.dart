import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_outcastbarber/business_logic/cubit/settings/settings_cubit.dart';
import 'package:mobile_outcastbarber/localization/locale_logic/locale_cubit.dart';
import 'package:mobile_outcastbarber/models/settingsdata.dart';
import 'package:mobile_outcastbarber/views/components/Dialog/BottomModal.dart';
import 'package:mobile_outcastbarber/views/components/button/barrel.dart';
import 'package:mobile_outcastbarber/views/components/snackbar/snackbar.dart';
import 'package:mobile_outcastbarber/views/components/text/text.dart';
import 'package:mobile_outcastbarber/views/shared/colors.dart';
import 'package:mobile_outcastbarber/views/shared/dimens.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//List of pages
part 'screen.dart';
part 'pages/settingsPage.dart';
