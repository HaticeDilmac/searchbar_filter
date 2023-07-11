// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:searchbar_filter/orderAndFilter.dart';

void main() {
  runApp(const MyApp());
}

class Item {
  final String name;
  final String lessonCount;
  final String instructor;
  final String duration;
  List<String> keywords;

  Item(this.name, this.lessonCount, this.instructor, this.duration,
      this.keywords);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filtered List Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Item> _allItems = [
    Item('Pro Aqua', '8 Ders', 'Yaner  ', '1 Saat', ["yüzme", "paket"]),
    Item('Yoga', '8 Ders', 'Ayşe Hanım', '1 Saat',
        ["yoga", "normal", "bel ağrısı", "sırt ağrısı", "hamak yoga"]),
    Item('Dans', '8 Ders', 'Yaner  ', '1 Saat',
        ["dans", "k-pop Dans", "geleneksel", "Popüler"]),
    Item('Dövüş', '8 Ders', 'Yaner  ', '1 Saat', [
      "bilek gücü",
      "dövüş sanatı",
      "kavga",
    ]),
  ];
//Tüm listenin elemanlarını attığımız liste
  List<Item> _foundItems = [];

  @override
  void initState() {
    //Her sayfa yenilendiği zaman _foundItems listesine atama yapılır.
    _foundItems = _allItems;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Item> results = []; //Sonucu döndürdüğümüz listemiz.
    if (enteredKeyword.isEmpty) {
      //girilen ifade boşsa tüm listeyi sonuca aktar yani tüm listeyi göster.
      results = _allItems;
    } else {
      results = _allItems.where((item) {
        // Elemanın adında veya keywords listesinde arama yapılıyor
        bool nameMatch =
            item.name.toLowerCase().contains(enteredKeyword.toLowerCase());
        bool keywordMatch = item.keywords.any((keyword) =>
            keyword.toLowerCase().contains(enteredKeyword.toLowerCase()));
        //any fonksiyonu listeden en az bir kelimenin true döndüremesi durumunda true yanıtını verir.

        return nameMatch || keywordMatch;
      }).toList();
    }

    setState(() {
      _foundItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtered List Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _foundItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_foundItems[index].name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Lesson Count: ${_foundItems[index].lessonCount}'),
                          Text('Instructor: ${_foundItems[index].instructor}'),
                          Text('Duration: ${_foundItems[index].duration}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FilteredLessonListApp()),
                  );
                },
                child: const Text("Order And Filter Page"))
          ],
        ),
      ),
    );
  }
}

// // import 'package:flutter/material.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         // This is the theme of your application.
// //         //
// //         // TRY THIS: Try running your application with "flutter run". You'll see
// //         // the application has a blue toolbar. Then, without quitting the app,
// //         // try changing the seedColor in the colorScheme below to Colors.green
// //         // and then invoke "hot reload" (save your changes or press the "hot
// //         // reload" button in a Flutter-supported IDE, or press "r" if you used
// //         // the command line to start the app).
// //         //
// //         // Notice that the counter didn't reset back to zero; the application
// //         // state is not lost during the reload. To reset the state, use hot
// //         // restart instead.
// //         //
// //         // This works for code too, not just values: Most code changes can be
// //         // tested with just a hot reload.
// //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// //         useMaterial3: true,
// //       ),
// //       home: const MyListPage(),
// //     );
// //   }
// // }

// // class MyListPage extends StatefulWidget {
// //   const MyListPage({Key? key}) : super(key: key);

// //   @override
// //   _MyListPageState createState() => _MyListPageState();
// // }

// // class _MyListPageState extends State<MyListPage> {
// //   final List<Map<String, dynamic>> _myItems = [
// //     //Elemanların olduğu listemiz
// //     {"id": 1, "name": "Item 1"},
// //     {"id": 2, "name": "Item 2"},
// //     {"id": 3, "name": "Item 3"},
// //     {"id": 4, "name": "Item 4"},
// //     {"id": 5, "name": "Item 5"},
// //     {"id": 6, "name": "Item 6"},
// //     {"id": 7, "name": "Item 7"},
// //     {"id": 8, "name": "Item 8"},
// //     {"id": 9, "name": "Item 9"},
// //     {"id": 10, "name": "Item 10"},
// //   ];

// //   List<Map<String, dynamic>> _filteredItems =
// //       []; //search edilen liste elemanınının altarıldığı liste

// //   @override
// //   void initState() {
// //     _filteredItems =
// //         _myItems; //uygulamayı açar açmaz tüm liste elemanlarımız boş listeye geçeer
// //     super.initState();
// //   }

// //   bool visible = true;

// //   void _runFilter(String enteredKeyword) {
// //     List<Map<String, dynamic>> results = [];
// //     if (enteredKeyword.isEmpty) {
// //       // Eğer giriş metni boşsa, tüm öğeleri göstermek için orijinal liste kullanılır.
// //     } else {
// //       // Giriş metnine göre filtreleme yapılır ve eşleşen öğeler yeni bir listeye eklenir.
// //       results = _myItems
// //           .where((item) =>
// //               item["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
// //           .toList();
// //     }
// //     setState(() {
// //       visible = false;
// //       // Sonuçları güncellemek için state yeniden oluşturulur.
// //       _filteredItems = results;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('My List Page'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(10),
// //         child: Column(
// //           children: [
// //             const SizedBox(height: 20),
// //             TextField(
// //               onChanged: (value) => _runFilter(value),
// //               decoration: const InputDecoration(
// //                 labelText: 'Search',
// //                 suffixIcon: Icon(Icons.search),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             Visibility(
// //                 visible: visible,
// //                 child: Container(height: 50, color: Colors.blue)),
// //             Expanded(
// //               child: _filteredItems.isNotEmpty
// //                   ? ListView.builder(
// //                       itemCount: _filteredItems.length,
// //                       itemBuilder: (context, index) => Card(
// //                         key: ValueKey(_filteredItems[index]["id"]),
// //                         color: Colors.yellowAccent,
// //                         elevation: 4,
// //                         margin: const EdgeInsets.symmetric(vertical: 10),
// //                         child: ListTile(
// //                           title: Text(_filteredItems[index]['name']),
// //                         ),
// //                       ),
// //                     )
// //                   : const Text(
// //                       'No results found',
// //                       style: TextStyle(fontSize: 24),
// //                     ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
