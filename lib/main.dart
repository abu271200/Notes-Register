import 'package:flutter/material.dart';
import './models/trasaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expansive',
      theme:ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.lime,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(headline6: TextStyle(fontFamily: 'OpenSans',fontWeight: FontWeight.bold,fontSize: 16)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSana',
              fontSize: 20,
              fontWeight: FontWeight.bold,),
              button: TextStyle(color: Colors.white),
              )
              ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePage();
}
class _MyHomePage extends State<MyHomePage> {
  final List<Transaction> _userTransactions=[
   // Transaction(id: 't1', title: 'Loafer', amount: 25.6, date:DateTime.now(),),
    //Transaction(id: 't2', title: 'Belt', amount: 12.6, date:DateTime.now(),),
  ];
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx){
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }
  void _addNewTransaction(String txTitle, double txAmount,DateTime chosenDate){
    final newTx = Transaction(
    title: txTitle,
    amount: txAmount,
    date: DateTime.now(),
    id: DateTime.now().toString(), 
    );
    setState(() {
       _userTransactions.add(newTx);
            });
  }
  //String title = 'titleInput';
      void _startAddNewTransaction(BuildContext ctx){
        showModalBottomSheet(
          context: ctx,
          builder:(_){
          return GestureDetector(
            onTap:() {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      }
    );
}
// this transaction for delete the string id;
void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

@override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
          backgroundColor: Colors.indigo,
          title:Text('Personal Expensive'),
          actions: [
            IconButton(icon: Icon(Icons.add),
            onPressed: () =>
              _startAddNewTransaction(context),
            ),
          ],
          ),
        body:SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Chart(_recentTransactions),
               TransactionList(_userTransactions, _deleteTransaction),
              ],
            ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () =>
            _startAddNewTransaction(context),
        ),
        );
  }
}