//import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


    void main(){
      runApp(Calculator());
    }
    class Calculator extends StatelessWidget {
      const Calculator({Key? key}) : super(key: key);
    
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Calculator",
          theme: ThemeData(primarySwatch: Colors.blue),
          home: SimpleCalculator(), 
        );
          
        
      }
    }

     class SimpleCalculator extends StatefulWidget {
       SimpleCalculator({Key? key}) : super(key: key);
     
       @override
       _SimpleCalculatorState createState() => _SimpleCalculatorState();
     }
     
     class _SimpleCalculatorState extends State<SimpleCalculator> {

          String? expression;
          String result="0";
          String equation="0";


        buttonPressed(String text){

          setState((){
            if(text=="C")             
             { 
               equation="0";
               result="0";
             }else
             if(text=="=")
             {
               Parser p = Parser();
               expression= equation;
              expression = expression?.replaceAll("÷", "/");
              expression = expression?.replaceAll("×", "*");
               try {                 
                  print(expression);
                 Expression exp = p.parse(expression!); 
                 ContextModel cm = ContextModel();
                 result='${exp.evaluate(EvaluationType.REAL, cm)}' ;               
               } catch (exp) {
                 result="ERROR";
               }
             }else
              if(text=="⌫")
              {
                equation=equation.substring(0,equation.length-1);
                if(equation=="")
                equation="0";
              }
              else{ 
                if(equation=="0"){
                  equation=text;
                }else
                equation = equation + text;
              }
          });

        }

        Widget buildButton( String text,double height,Color color){
            return Container( 
            height: MediaQuery.of(context).size.height *.1*height,
            color: color,
            child: TextButton(onPressed: () => buttonPressed(text),
            style:TextButton.styleFrom(
                shape:RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(0.0),
                   side:BorderSide(
                     color: Colors.white,
                     width: 1,
                     style: BorderStyle.solid)
                      ),
                   padding: EdgeInsets.all(16)   
                  )
                  ,
            child:Text(text,style: TextStyle(fontSize: 30,color: Colors.black),) ,
                )
             );

        }

        
       @override
       Widget build(BuildContext context) {
         return Scaffold(
           appBar:AppBar(
             title:Center(child:Text( "Simple calculator",))
             ),
             body: Column(
               children: [
                 Container(
                   alignment: Alignment.center,
                   padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                   child: Text(equation,style: TextStyle(fontSize: 38.0,),),
                 ),
                  Container(
                   alignment: Alignment.center,
                   padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                   child: Text(result,style: TextStyle(fontSize: 38.0,),),
                 ),
                 Expanded(
                   child: Divider()
                   ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Container(
                       width: MediaQuery.of(context).size.width *.75,
                       child: Table(
                         children: [
                           TableRow(
                             children:[
                              buildButton("C",1,Colors.redAccent),
                              buildButton("⌫", 1, Colors.blueAccent),
                              buildButton("÷", 1, Colors.blueAccent)
                             ]),
                          TableRow(
                          children:[
                          buildButton("9",1,Colors.black54),
                          buildButton("8", 1, Colors.black54),
                          buildButton("7", 1, Colors.black54)
                          ]),
                          TableRow(
                          children:[
                          buildButton("6",1,Colors.black54),
                          buildButton("5", 1, Colors.black54),
                          buildButton("4", 1, Colors.black54)
                          ]),
                          TableRow(
                          children:[
                          buildButton("3",1,Colors.black54),
                          buildButton("2", 1, Colors.black54),
                          buildButton("1", 1, Colors.black54)
                          ]),
                          TableRow(
                          children:[
                          buildButton(".",1,Colors.black54),
                          buildButton("0", 1, Colors.black54),
                          buildButton("00", 1, Colors.black54)
                          ])

                         ],
                       ),
                     ),
                   Container(
                     width: MediaQuery.of(context).size.width *.25,
                     child: Table(
                       children: [
                         TableRow(
                           children:[
                             buildButton("×",1,Colors.blueAccent),
                             ]
                         ),
                         TableRow(
                           children:[
                             buildButton("-",1,Colors.blueAccent)],
                             ),
                         TableRow(
                           children:[
                             buildButton("+",1,Colors.blueAccent)],
                             ),
                         TableRow(
                           children:[
                             buildButton("=",2,Colors.redAccent)],
                             )
                       ],
                     ),
                   )
                   ]
                   ,
                 )
               ],
             ),
           );
           
       }
     }