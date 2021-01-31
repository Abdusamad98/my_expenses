import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // sanani format qilib beradigan kutubxona
import 'package:my_expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final deleteTx;
  TransactionList(this._userTransactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: _userTransactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'Hali harajat qo\'shilmadi!',
                  style: TextStyle(color: Colors.red, fontFamily: 'Open Sans'),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemCount: _userTransactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 6,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '\$${_userTransactions[index].amount}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      _userTransactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(_userTransactions[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTx(_userTransactions[index].id),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
