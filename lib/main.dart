import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,

          colorScheme: ColorScheme(
            secondary: Colors.red,
            primary: Colors.grey.shade900, //primary
            brightness: Brightness.dark,//brightness
            background: Colors.black, //background
            onPrimary: Colors.red, //button text
            onSecondary: Colors.green,//idk
            onBackground: Colors.red, //calendar rows
            onError: Colors.orange, //idk
            error: Colors.blue, //idk
            surface: Colors.grey.shade900, //top title
            onSurface: Colors.amber.shade800, //maincollor
      ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.red, // button text color
          ),
        ),
      ),

      home: const MyHomePage(title: 'Diary'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedWeek = "Выберите неделю";
  @override
  void initState() {
    super.initState();
    selectedWeek = _calculateWeek(DateTime.now());
  }
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),


    );

    if (picked != null  ) {
      setState(() {
        selectedWeek = "Неделя: ${_calculateWeek(picked)}";
      });
    }
  }
  String _calculateWeek(DateTime date) {
    DateTime firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));

    // Найдем последний день текущей недели
    DateTime lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));

    // Преобразуем даты в строки
    String firstDayString =
        "${firstDayOfWeek.day}.${firstDayOfWeek.month}.${firstDayOfWeek.year}";
    String lastDayString =
        "${lastDayOfWeek.day}.${lastDayOfWeek.month}.${lastDayOfWeek.year}";

    // Возвращаем объединенную строку
    return '$firstDayString - $lastDayString';
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.title),
              SizedBox(height: 5),
              Text(selectedWeek),
           ],
          ),
    IconButton(
    icon: Icon(Icons.calendar_today),
    onPressed: () => _selectDate(context),
    ),
    ],
          ),

      ),
      body: Center(

        child: Text(selectedWeek),
      ),

       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
