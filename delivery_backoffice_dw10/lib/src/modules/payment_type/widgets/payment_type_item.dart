import 'package:flutter/material.dart';

import '../../../core/ui/styles/text_styles.dart';
import '../../../models/payment_type_model.dart';

class PaymentTypeItem extends StatelessWidget {
  final PaymentTypeModel payment;
  const PaymentTypeItem({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image.asset(
              'assets/images/icons/payment_${payment.acronym}_icon.png',
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset('assets/images/icons/payment_notfound_icon.png'),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Forma de Pagamento',
                  style: context.textStyles.textRegular,
                ),
                const SizedBox(height: 10),
                Text(
                  payment.name,
                  style: context.textStyles.textTitle,
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: TextButton(onPressed: () {}, child: const Text('Editar')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
