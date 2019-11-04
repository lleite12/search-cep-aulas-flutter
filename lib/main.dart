import 'package:flutter/material.dart';
import 'package:search_cep/views/home_page.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return new DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => new ThemeData(
          primarySwatch: MaterialColor(4294924812,{50: Color( 0xffffeee5 )
                        , 100: Color( 0xffffdccc )
                        , 200: Color( 0xffffba99 )
                        , 300: Color( 0xffff9766 )
                        , 400: Color( 0xffff7433 )
                        , 500: Color( 0xffff5200 )
                        , 600: Color( 0xffcc4100 )
                        , 700: Color( 0xff993100 )
                        , 800: Color( 0xff662100 )
                        , 900: Color( 0xff331000 )
                        }),
          brightness: brightness,
        ),
        themedWidgetBuilder: (context, theme) {
          return new MaterialApp(
          debugShowCheckedModeBanner: false,          
          theme: theme,  
          home: HomePage(),                  
        );
        }
    );
  }
}