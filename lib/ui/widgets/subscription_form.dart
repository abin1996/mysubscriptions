import 'package:flutter/material.dart';
import 'package:my_subscriptions/models/models.dart';
import 'package:my_subscriptions/repos/firebase_subs_repository.dart';

class SubscriptionForm extends StatefulWidget {
  final formKey;
  final FirebaseSubscriptionRepository subscriptionRepository;
  const SubscriptionForm({Key key, this.formKey, this.subscriptionRepository})
      : super(key: key);

  @override
  SubscriptionFormState createState() {
    return SubscriptionFormState();
  }
}

class SubscriptionFormState extends State<SubscriptionForm> {
  String _currencyValue;
  String _name;
  double _price;
  int _renewalFrequency = 1;
  String _renewalTimeFrame;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
          TextFormField(
            autofocus: true,
            decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: Theme.of(context).textTheme.bodyText1),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter name of Subscription';
              }
              return null;
            },
            onChanged: (text) {
              _name = text;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: 'Price',
                labelStyle: Theme.of(context).textTheme.bodyText1),
            onChanged: (text) {
              _price = double.parse(text);
            },
          ),
          DropdownButtonFormField<String>(
              hint: Text("Currency"),
              onChanged: (value) => {_currencyValue = value},
              items: [
                DropdownMenuItem<String>(
                  value: "INR",
                  child: Text("INR"),
                ),
                DropdownMenuItem<String>(
                  value: "Dollar",
                  child: Text("Dollar"),
                ),
                DropdownMenuItem<String>(
                  value: "Euro",
                  child: Text("Euro"),
                ),
              ]),
          DropdownButtonFormField<String>(
            hint: Text("Renews every"),
            onChanged: (value) => {_renewalTimeFrame = value},
            items: [
              DropdownMenuItem<String>(
                value: "WEEK",
                child: Text("Weekly"),
              ),
              DropdownMenuItem<String>(
                value: "FORTNIGHT",
                child: Text("Biweekly"),
              ),
              DropdownMenuItem<String>(
                value: "MONTH",
                child: Text("Monthly"),
              ),
              DropdownMenuItem<String>(
                value: "YEAR",
                child: Text("Yearly"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  autofocus: false,
                  child: Text("Close"),
                ),
                ElevatedButton(
                  child: Text("Add"),
                  onPressed: () {
                    Subscription subscription = Subscription(
                        "",
                        _name,
                        DateTime.now(),
                        _price,
                        _currencyValue,
                        _renewalFrequency,
                        _renewalTimeFrame);
                    widget.subscriptionRepository
                        .addNewSubscription(subscription);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
