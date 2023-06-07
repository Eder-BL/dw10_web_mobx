import 'package:flutter/material.dart';

import '../../../../core/ui/helpers/size_extensions.dart';
import '../../../../core/ui/styles/text_styles.dart';
import '../../../../models/payment_type_model.dart';
import '../../payment_type_controller.dart';

class PaymentTypeFormModal extends StatefulWidget {
  final PaymentTypeController controller;
  final PaymentTypeModel? model;
  const PaymentTypeFormModal({super.key, required this.model, required this.controller});

  @override
  State<PaymentTypeFormModal> createState() => _PaymentTypeFormModalState();
}

class _PaymentTypeFormModalState extends State<PaymentTypeFormModal> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final acronymEC = TextEditingController();
  var enabled = false;

  void _closeModal() => Navigator.of(context).pop();

  @override
  void initState() {
    final paymentModel = widget.model;
    if (paymentModel != null) {
      nameEC.text = paymentModel.name;
      acronymEC.text = paymentModel.acronym;
      enabled = paymentModel.enabled;
    }
    super.initState();
  }

  @override
  void dispose() {
    nameEC.dispose();
    acronymEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    return SingleChildScrollView(
      child: Container(
        width: screenWidth * (screenWidth > 1200 ? 0.5 : 0.7),
        padding: const EdgeInsets.all(30),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${widget.model == null ? 'Adicionar' : 'Editar'} Forma de Pagamento',
                      textAlign: TextAlign.center,
                      style: context.textStyles.textTitle,
                    ),
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
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameEC,
                // initialValue: widget.model?.name ?? '',
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: acronymEC,
                // initialValue: widget.model?.acronym ?? '',
                decoration: const InputDecoration(
                  labelText: 'Sigla',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Sigla é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Ativo:',
                    style: context.textStyles.textRegular,
                  ),
                  Switch(
                    value: enabled,
                    onChanged: (value) {
                      setState(() {
                        enabled = value;
                      });
                    },
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: 60,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                      ),
                      onPressed: _closeModal,
                      child: Text(
                        'Cancelar',
                        style: context.textStyles.textExtraBold.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final valid = formKey.currentState?.validate() ?? false;

                        if (valid) {
                          widget.controller.savePayment(
                            id: widget.model?.id,
                            name: nameEC.text,
                            acronym: acronymEC.text,
                            enabled: enabled,
                          );
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Salvar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
