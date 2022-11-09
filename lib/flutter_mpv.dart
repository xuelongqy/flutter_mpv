library flutter_mpv;

import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mpv/mpv_bindings.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

part 'src/plugin/flutter_mpv.dart';
part 'src/plugin/flutter_mpv_method_channel.dart';
part 'src/plugin/flutter_mpv_platform_interface.dart';
part 'src/widget/mpv_player.dart';
part 'src/entity/mpv_holder_entity.dart';