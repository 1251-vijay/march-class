void main() {
//   print("h");

//   //single comment =>
//   /**
//    *
//    * dbn
//    * fgb l
//    *  vl
//    *
//    */

//   //int.double,bool,String
//   // int => number or neg or post => 49
//   //double => decimal values => 10.45
//   //bool true or false;
//   //String any text vijay  "" or '';

//   // datatype variable = value;
  int a = 10;
  print(a.toString());

//   // datatype variable = value;
  double b = 10.5837843346;
  print(b);

//   // datatype variable = value;

  bool male = false;
  print(male);

  String name = "vijay";
  print(name.contains("s"));

  String ca = "something";
  print(ca.length);

  String names = "vijay";
  print(names.endsWith("y"));

  // variables  => _vijay

//   //

// }void main() {
  int x = 10, y = 10;
  int c = x + y;
  print(c);
  if (c == 20) {
    print("the number is 20");
  } else {
    print("the number is  not equal to 20");
  }
}

void main() {
  print("Hello World");

  //comments => there two types of comments
  //single  line comment
  //multiline comment
  // single line write like this =>  //
  // multli lines write like this => /* */
  //block of code write anything here...

  // 1 .  data types
  // there are so many data types are there =>  int , bool, double, string => this are basic types
  // 1. int
  // int is nothing any number or value either negative or postive what ever
  // double is nothing any decimal value   either negative or postive what ever?
  //String is nothing any text like vijay something else
  //bool is a true or false

  // Datatype variable = value;
  //int =>
  int a = 10;
  print(a);

  //double =>
  double b = 10.33;
  print(b);

  //bool =>
  bool age = false;
  print(age);

  //String =>
  String name = "vijay";
  print(name);
  print(name.length);

  String n = "kumar";
  print(n.length);
  if (n.length == 5) {
    print("yes");
  } else {
    print("no");
  }

// if else syntax =>
// if(condition){
// block of code => this is true blocl
// }else {
// block of code  this is false block
// }
}

oid main() {
  // bool isLogin = false;
  // if (!isLogin) {
  //   print("hello world");
  // } else {
  //   print("hello");
  // }

  // for (int i = 0; i <= 10; i++){

  // }
  // int i = 1;
  // while (i <= 10) {
  //   print(i);
  //   i++;
  //   //block of code
  // }

  // while(condition){
  //   incre/drecement
  //   block of code
  // }

  // int a = 0;
  // do {
  //   print(a);
  //   a++;
  // } while (a <= 10);

/**1
 * 2
 * 3
 * 4
 * continue
 * 5
 * 6
 * 8
 * 9
 * 10
 */
  // do {
  //   increment/decre
  // } while (conditon);

  // String name = "vijay";

  for (int i = 1; i <= 10; i++) {
    if (i == 5) {
      break;
    }
    print(i);
  }
  // String
  // void
  // int
  //camel case => vijayKumar
  // bool
  // void vijayKumar() {
  //   // return "vijay";
  // }

  String n = name();
  print(n);
  print(name());

  int additon = addNumber();
  print(additon);

  int add = addNumbers(2, 3);
  print(add);

  // ignore: unused_element
}

({int numberInt, String name, bool isLogin, double b, int c, bool wifi})
    sendPassword() {
  return (numberInt: 2, name: "vijay", isLogin: true, b: 2.4, c: 2, wifi: true);
}

String name() {
  return "vijay kumar";
}

int addNumber({int a = 10, int b = 20}) {
  return a + b;
}

int addNumbers(int x, int y) {
  return x + y;
}
