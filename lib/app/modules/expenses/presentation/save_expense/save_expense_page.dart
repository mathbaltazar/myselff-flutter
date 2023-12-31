import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:myselff_flutter/app/core/utils/mask_util.dart';
import 'package:myselff_flutter/app/core/theme/color_schemes.g.dart';

import 'save_expense_controller.dart';

class SaveExpensePage extends StatefulWidget {
  const SaveExpensePage(
      {super.key, required this.controller, required this.expenseId});

  final SaveExpenseController controller;
  final int? expenseId;

  @override
  State<SaveExpensePage> createState() => _SaveExpensePageState();
}

class _SaveExpensePageState extends State<SaveExpensePage> {
  @override
  void initState() {
    super.initState();
    widget.controller.editExpense(widget.expenseId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Observer(
            builder: (_) =>
                Text(widget.controller.isEdit ? 'Editar' : 'Despesa'),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25),
              const Icon(
                Icons.assignment_rounded,
                size: 128,
              ),
              const SizedBox(height: 25),
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    border: Border.all(color: MyselffTheme.outlineColor),
                    borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      'Preencha os campos:',
                      style: TextStyle(
                          color: MyselffTheme.colorPrimary, fontSize: 16),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: widget.controller.dateTimeTextController,
                      onTap: () async {
                        var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1970),
                          lastDate: DateTime(2100),
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          initialDatePickerMode: DatePickerMode.day,
                        );
                        widget.controller.setDate(date);
                      },
                      readOnly: true,
                      keyboardType: TextInputType.none,
                      decoration: const InputDecoration(
                        labelText: 'Quando ?',
                        icon: Icon(Icons.calendar_month),
                      ),
                    ),
                    Observer(
                      builder: (_) => TextField(
                        controller: widget.controller.descriptionTextController,
                        decoration: InputDecoration(
                          labelText: 'Descrição',
                          icon: const Icon(Icons.text_snippet),
                          errorText: widget.controller.descriptionError,
                        ),
                      ),
                    ),
                    Observer(
                      builder:(_) => TextField(
                        controller: widget.controller.valueTextController,
                        inputFormatters: [MaskUtil.currency()],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Valor',
                          icon: const Icon(Icons.attach_money),
                          errorText: widget.controller.amountError,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Icon(Icons.check_circle_outline_rounded),
                        const SizedBox(width: 15),
                        const Text('Está pago?'),
                        const Spacer(),
                        Observer(
                          builder:(_) => Switch(
                            value: widget.controller.paid,
                            onChanged: widget.controller.setPaid,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: widget.controller.saveExpense,
          label: const Text('Salvar'),
          icon: const Icon(Icons.done_rounded),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.dateTimeTextController.dispose();
    widget.controller.valueTextController.dispose();
    widget.controller.descriptionTextController.dispose();
    super.dispose();
  }
}
