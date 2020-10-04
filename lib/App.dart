
import 'package:housepital/src/routes/route_const.dart';
import 'package:flutter/material.dart';
import 'package:housepital/src/config/theme_config.dart';
import 'package:housepital/src/screen/screens.dart';
import 'src/routes/routes.dart' as route;
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  final ThemeData appColorTheme = buildAppTheme();

  @override
  Widget build(BuildContext context) {
    return 
    // MultiProvider(
    //   providers: [
    //     //ChangeNotifierProvider<FirebaseNotifications>(create: (_) => FirebaseNotifications()),
    //   ],
    //   child: 
      MaterialApp(
        title: 'Housepital',
        debugShowCheckedModeBanner: false,
        //theme: appColorTheme,
        theme: ThemeData(
          fontFamily: 'Open Sans'
        ),
        onGenerateRoute: route.generateRoute,
        initialRoute: splash,
        //home: Category(),
        //home: DispatchPlan(),
        //home: Screens({"screenid":0}),
      //),
    );
  }
}

//DATA='{"notification": {"body": "this is a body","title": "this is a title"}, "priority": "high", "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "id": "1", "status": "done"}, "to": "edYUAPiEMWI:APA91bEVCp4AJ2K2Qg1EWW1aIMce-G0oWcieakqVItl6hO6InmLEs8QRAFeTEk__Z57Y7v2KZhLrpMYrJHKAF1LYeozxWZRKdcjoKG6ohLq-izvwXxbQWPJwjM6TE33I5Y2hp3QJsnI6"}'
//curl https://fcm.googleapis.com/fcm/send -H "Content-Type:application/json" -X POST -d "$DATA" -H "Authorization: key=<AAAA0XToVag:APA91bGZCoIYbDWAGr7R_MmK0adjE8pY77NR3GDSohHfIhLGY1exNBm1UAv1sykdBxEoDlRjKbZhqOAQaKKSnrglF10rcn03quVIY1qrc048uCfDLXkObwTXEZf9cqqOc8YIaCdTYvnL>"
