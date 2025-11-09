

import 'package:flutter/cupertino.dart';

Widget setHeight(double height){
  return SizedBox(height: height,);
}

Widget setWidth(double width){
  return SizedBox(width: width,);
}


double deviceHeight (context)=>  MediaQuery.of(context).size.height;
double deviceWidth (context)=>  MediaQuery.of(context).size.width;




class SliverHeight extends StatelessWidget {
  final double height ;
  const SliverHeight({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return  SliverToBoxAdapter(child: SizedBox(height:height ,),);
  }
}



class SliverWidth extends StatelessWidget {
  final double width;
  const SliverWidth({super.key,required this.width});

  @override
  Widget build(BuildContext context) {
    return  SliverToBoxAdapter(child: SizedBox(width: width,),);
  }
}
