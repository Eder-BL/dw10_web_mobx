import 'package:flutter/material.dart';

import '../../../../core/ui/helpers/size_extensions.dart';
import '../../../../core/ui/styles/text_styles.dart';
import '../../../../models/payment_type_model.dart';

class PaymentTypeFormModal extends StatefulWidget {
  final PaymentTypeModel? model;
  const PaymentTypeFormModal({super.key, required this.model});

  @override
  State<PaymentTypeFormModal> createState() => _PaymentTypeFormModalState();
}

class _PaymentTypeFormModalState extends State<PaymentTypeFormModal> {
  void _closeModal() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    return SingleChildScrollView(
      child: Container(
        width: screenWidth * (screenWidth > 1200 ? 0.5 : 0.7),
        padding: const EdgeInsets.all(30),
        child: Form(
          child: Column(
            children: [
              Stack(
                children: [
                  Text(
                    '${widget.model == null ? 'Adicionar' : 'Editar'} Forma de Pagamento',
                    textAlign: TextAlign.center,
                    style: context.textStyles.textTitle,
                  ),
                  InkWell(
                    onTap: _closeModal,
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
