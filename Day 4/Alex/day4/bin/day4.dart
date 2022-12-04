import 'package:day4/day4.dart' as day4;

import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:math';

bool equals(List<int> a, List<int> b){
  if(a.length != b.length) return false;
  for(int i = 0; i < a.length; i++){
    if(a[i] != b[i]) return false;
  }
  return true;
}

bool fullyOverlapped(List<int> a, List<int> b) {
  var overlapped_interval = List<int>.filled(2, 0);
  overlapped_interval[0] = max(a[0], b[0]);
  overlapped_interval[1] = min(a[1], b[1]);
  //print("The overlapped interval is: $overlapped_interval");

  return equals(overlapped_interval, a) || equals(overlapped_interval, b);
}

bool partiallyOverlapped(List<int> a, List<int> b) {
  var overlapped_interval = List<int>.filled(2, 0);
  overlapped_interval[0] = max(a[0], b[0]);
  overlapped_interval[1] = min(a[1], b[1]);
  // print("The overlapped interval is: $overlapped_interval");

  return overlapped_interval[0] <= overlapped_interval[1];
}

void main(){

  var fully_overlapped_intervals = 0;
  var partially_overlapped_intervals = 0;

  // Read input from the user
  String? input = stdin.readLineSync(encoding: utf8);
  while (input != null){
    var intervals = input.split(",").map((e) => e.split("-")).map((e) => e.map((e) => int.parse(e)).toList()).toList();
    //print("The intervals are: $intervals");
    
    // Count the intervals that are fully overlapping
    fully_overlapped_intervals += fullyOverlapped(intervals[0], intervals[1]) ? 1 : 0;

    // Count the intervals that are partially overlapping
    partially_overlapped_intervals += partiallyOverlapped(intervals[0], intervals[1]) ? 1 : 0;

    input = stdin.readLineSync(encoding: utf8);
  }

  print("The number of fully overlapped intervals is: $fully_overlapped_intervals");
  print("The number of partially overlapped intervals is: $partially_overlapped_intervals");

}