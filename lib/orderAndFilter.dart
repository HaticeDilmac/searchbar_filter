import 'package:flutter/material.dart';

class Lesson {
  final String name;
  final int lessonCount;
  final int capacity;
  final int duration;
  int price;

  Lesson(
      {required this.name,
      required this.lessonCount,
      required this.capacity,
      required this.duration,
      required this.price});
}

class FilteredLessonListApp extends StatefulWidget {
  const FilteredLessonListApp({super.key});

  @override
  _FilteredLessonListAppState createState() => _FilteredLessonListAppState();
}

class _FilteredLessonListAppState extends State<FilteredLessonListApp> {
  final List<Lesson> _allLessons = [
    Lesson(
        name: 'Lesson 1',
        lessonCount: 8,
        capacity: 10,
        duration: 60,
        price: 1000),
    Lesson(
        name: 'Lesson 2',
        lessonCount: 4,
        capacity: 10,
        duration: 45,
        price: 200),
    Lesson(
        name: 'Lesson 4',
        lessonCount: 12,
        capacity: 10,
        duration: 45,
        price: 400),
    Lesson(
        name: 'Lesson 5',
        lessonCount: 4,
        capacity: 15,
        duration: 60,
        price: 300),
    Lesson(
        name: 'Lesson 6',
        lessonCount: 8,
        capacity: 15,
        duration: 90,
        price: 500),
    Lesson(
        name: 'Lesson 3',
        lessonCount: 12,
        capacity: 15,
        duration: 90,
        price: 250),
    // Diğer dersler...
  ];

//listede tutulan değişkenlerin aktarılacağı değişkenler,
  List<Lesson> _filteredLessons = [];
  int? _selectedLessonCount;
  int? _selectedCapacity;
  int? _selectedDuration;

  final List<int?> _lessonCountOptions = [
    null,
    4,
    8,
    12
  ]; //Ders sayılarının tutulduğu liste
  final List<int?> _capacityOptions = [
    null,
    10,
    15,
    20
  ]; //Ders kapasitesinin tutulduğu liste
  final List<int?> _durationOptions = [
    null,
    45,
    60,
    90,
    120
  ]; //Des süresinin tutuldğu liste
  bool _isDescending = false; // Sıralama düzenini izlemek için bir bayrak

  void _sortLessonsByPrice() {
    setState(() {
      if (_isDescending) {
        //isDescending false ise fiyatı artan şekilde sırala
        _filteredLessons
            .sort((a, b) => a.price.compareTo(b.price)); // Artan sıralama
      } else {
        //isDescending true ise azalanfiyattan artan fiyata doğru sırala
        _filteredLessons
            .sort((a, b) => b.price.compareTo(a.price)); // Azalan sıralama
      }
      _isDescending =
          !_isDescending; // Sıralama düzenini tersine çevir.Eğer koymazsak tek bir sıralama seçme hakkımız olur.
    });
  }

  @override
  void initState() {
    super.initState();
    //Tüm listeyi filtremele için oluşturudğumuz listeye aktarırız- her sayfa yenilendiğinde
    _filteredLessons = _allLessons;
  }

  void _applyFilters() {
    setState(() {
      _filteredLessons = _allLessons.where((lesson) {
        // Ders adedi filtresini kontrol eder. Seçili ders adedi boş veya ders adedi ile eşleşiyorsa true döner.
        bool lessonCountMatch = _selectedLessonCount == null ||
            lesson.lessonCount == _selectedLessonCount;

        // Kapasite filtresini kontrol eder.Seçili ders kapasitesi boş veya ders kapasitesi ile eşleşiyorsa true döner.
        bool capacityMatch =
            _selectedCapacity == null || lesson.capacity == _selectedCapacity;

        // Süre filtresini kontrol eder.Seçili ders süresi boş veya ders süresi ile eşleşiyorsa true döner.
        bool durationMatch =
            _selectedDuration == null || lesson.duration == _selectedDuration;

        // Tüm filtrelerin uyumlu olması durumunda true döndürür, aksi takdirde false döndürür.
        return lessonCountMatch && capacityMatch && durationMatch;
      }).toList();
    });
  }

  void _openFilterOptions(String filterName, List<int?> options) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((option) {
            if (option == null) {
              return ListTile(
                title: const Text('All'),
                onTap: () {
                  setState(() {
                    if (filterName == 'Lesson Count') {
                      _selectedLessonCount = option;
                    } else if (filterName == 'Capacity') {
                      _selectedCapacity = option;
                    } else if (filterName == 'Duration') {
                      _selectedDuration = option;
                    }
                  });
                  Navigator.pop(context);
                  _applyFilters();
                },
              );
            } else {
              bool isOptionValid =
                  _allLessons.any((lesson) => lesson.lessonCount == option);
              bool isOptionValidDuration =
                  _allLessons.any((lesson) => lesson.duration == option);
              bool isOptionValidCapacity =
                  _allLessons.any((lesson) => lesson.capacity == option);
              if (isOptionValid ||
                  isOptionValidDuration ||
                  isOptionValidCapacity) {
                return ListTile(
                  title: Text(option.toString()),
                  onTap: () {
                    setState(() {
                      if (filterName == 'Lesson Count') {
                        _selectedLessonCount = option;
                      } else if (filterName == 'Capacity') {
                        _selectedCapacity = option;
                      } else if (filterName == 'Duration') {
                        _selectedDuration = option;
                      }
                    });
                    Navigator.pop(context);
                    _applyFilters();
                  },
                );
              } else {
                return Container();
              }
            }
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtered Lesson List'),
        actions: [
          IconButton(
            onPressed: () => _sortLessonsByPrice(),
            icon: Icon(
              _isDescending ? Icons.arrow_downward : Icons.arrow_upward,
            ),
          ),
          IconButton(
            onPressed: () =>
                _openFilterOptions('Lesson Count', _lessonCountOptions),
            icon: const Icon(Icons.book),
          ),
          IconButton(
            onPressed: () => _openFilterOptions('Capacity', _capacityOptions),
            icon: const Icon(Icons.group),
          ),
          IconButton(
            onPressed: () => _openFilterOptions('Duration', _durationOptions),
            icon: const Icon(Icons.timer),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 700,
            child: ListView.builder(
              itemCount: _filteredLessons.length,
              itemBuilder: (context, index) {
                final lesson = _filteredLessons[index];
                return ListTile(
                  title: Text(lesson.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lesson Count: ${lesson.lessonCount}'),
                      Text('Capacity: ${lesson.capacity}'),
                      Text('Duration: ${lesson.duration} minutes'),
                      Text('Price: ${lesson.price} ₺'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
