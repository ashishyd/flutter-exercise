import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;

  TransactionList(this.userTransactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: userTransactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover))
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (item, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: FittedBox(
                                child: Text(
                                    '\$${userTransactions[index].amount}')))),
                    title: Text(
                      userTransactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(DateFormat.yMMMd()
                        .format(userTransactions[index].date)),
                    trailing: MediaQuery.of(context).size.width > 450
                        ? FlatButton.icon(
                            onPressed: () =>
                                deleteTransaction(userTransactions[index].id),
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),
                            textColor: Theme.of(context).errorColor)
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () =>
                                deleteTransaction(userTransactions[index].id)),
                  ),
                );
              },
              itemCount: userTransactions.length),
    );
  }
}
