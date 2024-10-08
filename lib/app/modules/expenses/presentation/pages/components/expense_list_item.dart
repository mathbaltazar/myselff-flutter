part of '../expenses_list_page.dart';

class _ExpenseListItem extends StatelessWidget {
  const _ExpenseListItem(
    this.expense, {
    required this.onItemClick,
  });

  final Function() onItemClick;
  final ExpenseEntity expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onItemClick,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                Icons.paid,
                color: expense.paid
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.error,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense.description,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      expense.paymentDate.format(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(.70),
                      ),
                    ),
                    Text(
                      expense.paymentType?.name ?? 'Não definido.',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: expense.paymentType != null ? FontWeight.bold : null,
                          color: expense.paymentType == null
                              ? Theme.of(context).colorScheme.onSurface.withOpacity(.42)
                              : null),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '\$ ${expense.amount.formatCurrency()}',
                style:
                    const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
