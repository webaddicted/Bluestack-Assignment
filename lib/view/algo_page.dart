import 'package:flutter/material.dart';
import 'package:tournament/utils/constant/assets_const.dart';
import 'package:tournament/utils/constant/color_const.dart';

class AlgoPage extends StatefulWidget {
  const AlgoPage({Key? key}) : super(key: key);

  @override
  _AlgoPageState createState() => _AlgoPageState();
}

class _AlgoPageState extends State<AlgoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.whiteColor,
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  // getPrimeNumber();
                },
                child: SizedBox(
                    width: 250,
                    height: 250, //Adapt.px(500),
                    child: Image.asset(AssetsConst.logoImg)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkPrimeNumber() {
    int number = 13;
    if (number == 0 || number == 1) {
      print("$number is not prime number");
      return;
    }
    var isPrime = true;
    for (int i = 2; i < number / 2; i++) {
      if (number % i == 0) {
        isPrime = false;
        break;
      }
    }
    if (isPrime) {
      print("$number is prime number");
    } else {
      print("$number is not prime number");
    }
  }

  void checkPalindrome() {
    // O(N)
    int number = 131;
    int temp = number;
    int sum = 0;
    while (temp > 0) {
      sum = (sum * 10) + temp % 10;
      temp = temp ~/ 10;
    }
    if (sum == number) {
      print("$number is palindrome number");
    } else {
      print("$number is not palindrome number");
    }
  }

  // void checkPalindrome() {
  //   // O(N)
  //   String ipString = "TAT";
  //   String opString = "";
  //   for (int i = 0; i < ipString.length; i++) {
  //     opString = ipString[i] + opString;
  //   }
  //   if (opString == ipString) {
  //     print("$ipString is palindrome number");
  //   } else {
  //     print("$ipString is not palindrome number");
  //   }
  // }

  void getStringPalindrome2() {
    // O(1)
    String ipString = "TAT";
    int n = ipString.length;
    int halfLength = (n / 2).toInt();
    String secondHalf = "";
    String firstHalf = "";
    if (n % 2 == 0) {
      secondHalf = ipString.substring(halfLength, n);
      firstHalf = ipString.substring(0, halfLength);
    } else {
      secondHalf = ipString.substring(halfLength + 1, n);
      firstHalf = ipString.substring(0, halfLength);
    }
    if (secondHalf == firstHalf) {
      print("Palindrome");
    } else {
      print("Not Palindrome");
    }
  }

  void armstrongNumber() {
    int number = 153;
    int temp = number;
    int sum = 0;
    while (temp > 0) {
      int cube = temp % 10;
      cube = cube * cube * cube;
      sum = sum + cube;
      temp = (temp / 10).toInt();
    }
    if (number == sum) {
      print("Armstrong Number");
    } else {
      print("Not Armstrong Number");
    }
  }

  void checkArmstrongNumber() {
    int number = 153;
    int temp = number;
    int sum = 0;
    while (temp > 0) {
      int cube = temp % 10;
      cube = cube * cube * cube;
      sum = sum + cube;
      temp = (temp / 10).toInt();
    }
    if (number == sum) {
      print("$number is armstrong number");
    } else {
      print("$number is not armstrong number");
    }
  }

  void factorialNumber() {
    int number = 5;
    int sum = 1;
    for (int i = 1; i <= number; i++) {
      sum = i * sum;
    }
    print("$number Factorial Number - $sum");
  }



  void fibonacciSeries() {
    int number = 5;
    int n3 = 0;
    int n2 = 1;
    int n1 = 0;
    print("$n1, $n2");
    for (int i = 1; i <= number; i++) {
      n3 = n1 + n2;
      print("$n3");
      n1 = n2;
      n2 = n3;
    }
  }

  void anagramString() {
    String s1 = "TAB";
    String s2 = "BAT";
    if (s1.length != s2.length) {
      print("Not Anagram String");
      return;
    }
    var s1Characters = s1.characters;
    var s2Characters = s2.characters;
    stringSort(s1Characters);
    for (int i = 0; i < s1.length; i++) {

    }
  }

  void stringSort(Characters s1characters) {


  }
}
