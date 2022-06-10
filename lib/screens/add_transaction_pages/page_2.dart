import 'package:finance_tracker/widgets/small_action_button.dart';
import 'package:flutter/material.dart';
import '../../widgets/text_input_field.dart';

class Page2 extends StatefulWidget {
  Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  bool isExpense = true;
  // TEMP value
  TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFieldInput(
            controller: _amountController,
            hintText: 'Enter amount...',
            labelText: 'Amount',
            textInputType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 100),
        GestureDetector(
          child: SmallActionButton(),
        ),
      ],
    );
  }
}
