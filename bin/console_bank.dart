// This program has been run successfully on VS Code and Intellij

import 'dart:io';

void main() {
  print('Dart: 2.5: Console bank');
  //Input details for an account holder
  Account('Ude Agbai James', '3062474783', 23000);
}

class Account{
  var accountName, accountNumber;
  double accountBalance, updatedBalance;

  Account(this.accountName, this.accountNumber, this.accountBalance) {
    afterConstructor(accountBalance);
    while(confirmExit()) {  // confirm whether the user wants to perform another transaction, otherwise, exit.

      afterConstructor(updatedBalance); //using the updated balance "currentBalance" for other transactions

    }
    print('exiting...');
    sleep(Duration(seconds: 1));
    exit(0);
  }

  void afterConstructor(double balance) {
    var option;
    print('\nWelcome, $accountName, with account number $accountNumber.\nWhat transaction do you want to make?');
    do {
      print('1. Deposit\n2. Withdraw\n3. Check Account Balance');
      stdout.write('enter [1, 2 0r 3]: ');
      option = stdin.readLineSync();
      switch (option) {
        case '1':
          deposit(balance); //call the deposit function with the updated balance as an argument
          break;
        case '2':
          withdraw(balance); // call the withdraw function with the updated balance as an argument
          break;
        case '3':
          availBal(balance); //call the availBal function with the updated balance as an argument
          break;
        default:
          print('\nPlease choose from 1 to 3 .\nTry Again: ');
      }
    } while((option != '1') && (option != '2') && (option != '3'));  //  the function runs in a loop until either of the options provided are entered
  }

  void deposit(double availBalance) {
    dynamic amount = double.parse(verify('deposit')); // verifying input to be figures only
    print('processing...');
    sleep(Duration(seconds: 2));
    incBal(availBalance, amount);
  }


  void withdraw(double availBalance) {
    dynamic amount = double.parse(verify('withdraw')); // verifying input to be figures only
    print('checking availability of funds...');
    sleep(Duration(seconds: 2));
    if (amount > availBalance) { // checking if the  amount to be withdrawn is more than the available or updated balance
      print('Insufficient funds!\n\n');
    } else{
      print('processing...');
      sleep(Duration(seconds: 2));
      decBal(amount, availBalance);
    }
  }

  void availBal(double balance) {
    updatedBalance = double.parse(balance.toStringAsFixed(2));
    print('Your current balance is: \$$updatedBalance\n\n');
  }

  String verify(String transactionName) {
    String amount;
    stdout.write('Please enter amount you wish to $transactionName: \$');
    amount = stdin.readLineSync();
    while(!isNumeric(amount)) { // verify input to be figures
      stdout.write('Please re-enter amount in figures [(0,1,2,3...9,.)]: \$');
      amount = stdin.readLineSync();
    }
    return amount;
  }

  void incBal(double availBalance, double amount) {
    availBalance += amount;
    updatedBalance = availBalance; //updating to the latest balance
    print('Money deposited successfully!');
  }

  void decBal(double amount, double accBalance) {
    accBalance -= amount;
    updatedBalance = accBalance; //updating to the latest balance
    print('Money withdrawn successfully');
  }

  bool isNumeric(String value) {
    if(value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  bool confirmExit() {
    stdout.write('\nenter [y] or [Y] to perform another transaction \nor enter any other button to exit: ');
    var exit;
    exit = stdin.readLineSync();
    if(exit == 'y' || exit == 'Y') {
      return true;
    }
    return false;
  }
}