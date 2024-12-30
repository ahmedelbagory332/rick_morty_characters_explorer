
import 'package:flutter/material.dart';

import '../../../../domain/Characters/entity/status.dart';

Color getStatusColor(String status){
  final normalizedStatus = status.toLowerCase();
  if(normalizedStatus == Status.alive.name) {
    return Colors.green;
  }else if(normalizedStatus == Status.dead.name) {
    return Colors.red;
  }else {
    return Colors.blueGrey;
  }
}