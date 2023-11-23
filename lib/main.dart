// ignore_for_file: avoid_print

void main() {
  test();
}

class Person {
  final String name;
  final String surname;
  final int age;
  Person(this.name, this.surname, this.age);
}

extension FullName on Person {
  String get fullName => '$name $surname';
}

void test() {
  final admin = Person('Kostya', 'Vinnik', 20);
  print(admin.fullName);
  print(admin.age);
}
