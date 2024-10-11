import 'package:Puredrops/bar_graph/individual_bar.dart';



class BarData {
  final double firstYears;
  final double secondYears;
  final double thirdYears;
  final double fourthYears;
  final double fiveYears;
  final double sixYears;
  final double sevenYears;
   


  BarData({
  required this.firstYears,
   required this.secondYears,
   required this.thirdYears,
   required this.fourthYears,
   required this.fiveYears,
   required this.sixYears,
   required this.sevenYears,
  

});

List<IndividualBar> barData = [] ;

//initialize bar data
void initializeBarData() {

barData =[

//2010-2012
IndividualBar(x: 1, y: firstYears),

//2012-2014
IndividualBar(x: 2, y: secondYears),

//2014-2016
IndividualBar(x: 3, y: thirdYears),

//2016-2018
IndividualBar(x: 4, y: fourthYears),

//2018-2020
IndividualBar(x: 5, y: fiveYears),

//2020-2024
IndividualBar(x: 6, y: sixYears),

//2020-2024
IndividualBar(x: 7, y: sevenYears),




];






}

}