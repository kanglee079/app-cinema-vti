import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/utils/date_utils.dart';
import '../../../../../core/utils/int_utils.dart';
import '../../../../../core/utils/string_utils.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../domain/entities/ticket_entity.dart';

// ignore: must_be_immutable
class SeatSelectionPaymentConfirmScreen extends StatefulWidget {
  final TicketEntity ticketEntity;
  final Function(TicketEntity) onConfirm;
  const SeatSelectionPaymentConfirmScreen({
    super.key,
    required this.ticketEntity,
    required this.onConfirm,
  });

  @override
  State<SeatSelectionPaymentConfirmScreen> createState() =>
      _SeatSelectionPaymentConfirmScreenState();
}

class _SeatSelectionPaymentConfirmScreenState
    extends State<SeatSelectionPaymentConfirmScreen> {
  late ThemeData theme;

  TextTheme get _textTheme => theme.textTheme;
  ColorScheme get _colorScheme => theme.colorScheme;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: _colorScheme.background,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 24,
                ),
                Text(
                  'Pay for ticket',
                  style: _textTheme.titleMedium,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: _colorScheme.primaryContainer,
                    size: 32,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Container(
              decoration: BoxDecoration(
                color: _colorScheme.outline,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.ticketEntity.movie?.title ?? '',
                          style: _textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        _buildRowItem(
                          title: 'Cinema',
                          value: widget.ticketEntity.session?.theaterName ?? '',
                        ),
                        _buildRowItem(
                          title: 'Date',
                          value: widget.ticketEntity.session?.sessionTime
                                  ?.toLocalHHnnddmmyyyy() ??
                              '',
                        ),
                        _buildRowItem(
                          title: 'Thời lượng',
                          value: widget.ticketEntity.movie?.runtime
                                  ?.toStringAsFixed(0)
                                  .addUnitPost('phút') ??
                              '',
                        ),
                        _buildRowItem(
                          title: 'Seats',
                          value: widget.ticketEntity.seats?.join(', ') ?? '',
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Total',
                          style: _textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        _buildRowItem(
                          title: 'Số lượng vé',
                          value: widget.ticketEntity.seats?.length.toString() ??
                              '0',
                        ),
                        _buildRowItem(
                          title: 'Đơn giá',
                          value: 100000.addCommas().addUnitPost('đ'),
                        ),
                        _buildRowItem(
                          title: 'Tổng tiền',
                          value: widget.ticketEntity.totalAmount
                                  ?.toInt()
                                  .addCommas()
                                  .addUnitPost('đ') ??
                              '',
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: _colorScheme.primaryContainer,
                    size: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: CustomizedButton(
                      onTap: () {
                        final finalTicket = widget.ticketEntity.copyWith(
                          id: const Uuid().v1(),
                          createdAt: DateTime.now(),
                          userId: FirebaseAuth.instance.currentUser?.uid,
                        );
                        widget.onConfirm(finalTicket);
                      },
                      text: 'Xác nhận',
                      backgroundColor: _colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowItem({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              title,
              style: _textTheme.bodyMedium
                  ?.copyWith(color: _colorScheme.primaryContainer),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            value,
          ),
        ],
      ),
    );
  }
}
