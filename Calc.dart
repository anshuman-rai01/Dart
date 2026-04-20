import 'dart:io';

double add(double a,double b){
  return a+b;
}
double sub(double a,double b){
  return a-b;
}
double mult(double a,double b){
  return a*b;
}
double div(double a,double b){
  return a/b;
}

void main(){
  stdout.write("Enter 1st number : ");
  double n1 = double.parse(stdin.readLineSync()!);

  stdout.write("Enter 2nd nubmer : ");
  double n2 = double.parse(stdin.readLineSync()!);

  print("Choose your choice : ");
  print("1. Addition");
  print("2. Subtraction");
  print("3. Multiplication");
  print("4. Divide");

  stdout.write("Enter your choice : ");
  int choice = int.parse(stdin.readLineSync()!);

  double result ;
  switch(choice){
    case 1:
      result = add(n1,n2);
      print("Sum of $n1 and $n2 is : , $result");
      break;
    case 2:
      result = sub(n1,n2);
      print("Subtraction of $n1 and $n2 is : , $result");
      break;
    case 3:
      result = mult(n1,n2);
      print("Multiply of $n1 and $n2 is : , $result");
      break;
    case 4:
      result = div(n1,n2);
      print("Division of $n1 and $n2 is : , $result");
      break;
    default:
      print("Invalid choice :");
  }

}