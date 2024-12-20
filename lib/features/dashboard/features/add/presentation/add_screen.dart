import 'package:expense_tracker/common/widgets/custombutton.dart';
import 'package:expense_tracker/common/widgets/customtextfield.dart';
import 'package:expense_tracker/features/dashboard/features/add/logics/add_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../logics/add_bloc.dart';
import '../logics/add_state.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  // Set the initial value of _selectedType to null
  String? _selectedType;
  final List<String> _addType = ['Income', 'Expense'];

  @override
  Widget build(BuildContext context) {
    // Get theme
    final theme = Theme.of(context).colorScheme;

    return BlocListener<AddBloc, AddState>(
      listener: (context, state) {
        if (state is AddLoading) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.loading,
            title: 'Adding Income/Expense',
            barrierDismissible: false,
          );
        }

        if (state is AddSuccess) {
          Navigator.of(context).pop(); // Close the loading dialog

          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Success',
            text: state.message,
            barrierDismissible: true,
          );

          // Clear the text fields
          _incomeAmountController.clear();
          _descriptionController.clear();
          _expenseAmountController.clear();
          _expenseDescriptionController.clear();
        }

        if (state is AddFailure) {
          Navigator.of(context).pop(); // Close the loading dialog

          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Error',
            text: state.message,
            barrierDismissible: true,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Income/Expense',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: theme.primary,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Type',
              style: TextStyle(
                  color: theme.onSurface, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),

            // Dropdown
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: theme.onSurface.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text(
                    'Select Type',
                    style: TextStyle(color: theme.onSurface.withOpacity(0.6)),
                  ),
                  value: _selectedType,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: theme.onSurface),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedType = newValue;
                    });
                  },
                  items: _addType.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: GoogleFonts.poppins(color: theme.onSurface)),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 20.0),

            // Display different content based on the selected type
            if (_selectedType == null)
              const Expanded(
                  child: Center(child: Text('Select a category to continue'))),

            if (_selectedType == 'Income')
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: theme.primary.withOpacity(.1),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Add Income Details',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text('Income Amount',
                            style: TextStyle(
                              color: theme.onSurface,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _incomeAmountController,
                          hintText: "E.g. 15000 BDT",
                          isPassword: false,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: false,
                          ),
                          borderColor: theme.onSurface.withOpacity(.15),
                          width: double.infinity,
                          height: 50,
                          isBordered: false,
                          backgroundColor: theme.onSurface.withOpacity(.15),
                          textColor: theme.onSurface,
                          hintColor: theme.onSurface.withOpacity(.5),
                          leadingIcon: Icon(CupertinoIcons.money_dollar,
                              color: theme.primary),
                        ),
                        const SizedBox(height: 20),
                        Text('Description',
                            style: TextStyle(
                              color: theme.onSurface,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _descriptionController,
                          hintText: "E.g. Salary",
                          isPassword: false,
                          keyboardType: TextInputType.text,
                          borderColor: theme.onSurface.withOpacity(.15),
                          width: double.infinity,
                          height: 50,
                          isBordered: false,
                          backgroundColor: theme.onSurface.withOpacity(.15),
                          textColor: theme.onSurface,
                          hintColor: theme.onSurface.withOpacity(.5),
                          leadingIcon:
                              Icon(Icons.description, color: theme.primary),
                        ),

                        const SizedBox(height: 20),

                        // Add button

                        CustomButton(
                            width: double.infinity,
                            height: 50,
                            text: "Add Income",
                            onPressed: () async {
                              final pref =
                                  await SharedPreferences.getInstance();
                              final uid = pref.getString('uid');

                              if (_incomeAmountController.text.trim().isEmpty ||
                                  double.parse(_incomeAmountController.text) <=
                                      0) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  title: 'Error',
                                  text: 'Income amount must be greater than 0!',
                                  barrierDismissible: false,
                                );
                              } else {
                                final double incomeAmount =
                                    double.parse(_incomeAmountController.text);
                                final String description =
                                    _descriptionController.text;
                                BlocProvider.of<AddBloc>(context).add(
                                  AddIncomeSubmitted(
                                    uid: uid!,
                                    income: incomeAmount,
                                    description: description,
                                  ),
                                );
                              }
                            },
                            color: theme.primary,
                            textColor: theme.onPrimary,
                            isBordered: false)
                      ],
                    ),
                  ),
                ),
              )
            else if (_selectedType == 'Expense')
              Expanded(
                  child: SingleChildScrollView(
                      child: Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: theme.primary.withOpacity(.1),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Add Expense Details',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Text('Expense Amount',
                                    style: TextStyle(
                                      color: theme.onSurface,
                                      fontWeight: FontWeight.bold,
                                    )),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  controller: _expenseAmountController,
                                  hintText: "E.g. 1500 BDT",
                                  isPassword: false,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    decimal: true,
                                    signed: false,
                                  ),
                                  borderColor: theme.onSurface.withOpacity(.15),
                                  width: double.infinity,
                                  height: 50,
                                  isBordered: false,
                                  backgroundColor:
                                      theme.onSurface.withOpacity(.15),
                                  textColor: theme.onSurface,
                                  hintColor: theme.onSurface.withOpacity(.5),
                                  leadingIcon: Icon(CupertinoIcons.money_dollar,
                                      color: theme.primary),
                                ),
                                const SizedBox(height: 20),
                                Text('Description',
                                    style: TextStyle(
                                      color: theme.onSurface,
                                      fontWeight: FontWeight.bold,
                                    )),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  controller: _expenseDescriptionController,
                                  hintText: "E.g. Grocery",
                                  isPassword: false,
                                  keyboardType: TextInputType.text,
                                  borderColor: theme.onSurface.withOpacity(.15),
                                  width: double.infinity,
                                  height: 50,
                                  isBordered: false,
                                  backgroundColor:
                                      theme.onSurface.withOpacity(.15),
                                  textColor: theme.onSurface,
                                  hintColor: theme.onSurface.withOpacity(.5),
                                  leadingIcon: Icon(Icons.description,
                                      color: theme.primary),
                                ),

                                const SizedBox(height: 20),

                                // Add button

                                CustomButton(
                                    width: double.infinity,
                                    height: 50,
                                    text: "Add Expense",
                                    onPressed: () async {
                                      final pref =
                                          await SharedPreferences.getInstance();
                                      final uid = pref.getString('uid');

                                      if (_expenseAmountController.text
                                              .trim()
                                              .isEmpty ||
                                          double.parse(_expenseAmountController
                                                  .text) <=
                                              0) {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.error,
                                          title: 'Error',
                                          text:
                                              'Expense amount must be greater than 0!',
                                          barrierDismissible: false,
                                        );
                                      } else {
                                        final double expenseAmount =
                                            double.parse(
                                                _expenseAmountController.text);
                                        final String description =
                                            _expenseDescriptionController.text;
                                        BlocProvider.of<AddBloc>(context).add(
                                          AddExpenseSubmitted(
                                            uid: uid!,
                                            expense: expenseAmount,
                                            description: description,
                                          ),
                                        );
                                      }
                                    },
                                    color: theme.primary,
                                    textColor: theme.onPrimary,
                                    isBordered: false)
                              ]))))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _selectedType = null;
    _incomeAmountController.dispose();
    _descriptionController.dispose();
    _expenseAmountController.dispose();
    _expenseDescriptionController.dispose();
  }

  final _incomeAmountController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _expenseAmountController = TextEditingController();
  final _expenseDescriptionController = TextEditingController();
}
