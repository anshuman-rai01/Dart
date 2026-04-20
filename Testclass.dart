
// class Swimmer {
//   void swim() => print("Swimming");
// }

// class Runner {
//   void run() => print("Running");
// }

// class Athlete implements Swimmer, Runner {
//   @override
//   void run() => print("Running like an athlete");

//   @override
//   void swim() => print("Swimming like an athlete");
// }
// void main() {
//   var athlete = Athlete();
//   athlete.swim();
//   athlete.run();
// }

Future<String> fetchData() async {
  return Future.delayed(
    Duration(seconds: 2),
    () => "Data Loaded",
  );
}
void main() async {
  print("Fetching data...");
  String data = await fetchData();
  print(data);
}