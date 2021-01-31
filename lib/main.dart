import 'package:flutter/material.dart';
import 'package:my_expenses/models/transaction.dart';
import 'package:my_expenses/widgets/chart.dart';
import 'package:my_expenses/widgets/new_transaction.dart';
import 'package:my_expenses/widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shaxsiy harajatlar',
      theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.white,
          errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final List<Transaction> _userTransaction = [
    Transaction(id: 't1', title: 'Tufli', amount: 66.99, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Oylik yo\'l chiptasi',
        amount: 16,
        date: DateTime.now()),
    Transaction(
        id: 't3', title: 'USB cabel', amount: 35, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addingNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    setState(() {
      _userTransaction.add(Transaction(
          title: txTitle,
          amount: txAmount,
          date: chosenDate,
          id: DateTime.now().toString()));
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addingNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((test) => test.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  backgroundColor: Colors.red,
        title: Text('Shaxsiy harajatlar'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //child deganda faqat bitta view children deganda multiple  views
            Chart(_recentTransactions),
            TransactionList(_userTransaction,_deleteTransaction)
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
