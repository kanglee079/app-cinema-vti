import 'package:app_cinema/core/utils/int_utils.dart';
import 'package:app_cinema/core/utils/string_utils.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../widgets/custom_button2.dart';
import '../../../../ticket/domain/entities/ticket_entity.dart';

class TicketDetailScreenInProfile extends StatefulWidget {
  final TicketEntity ticket;

  const TicketDetailScreenInProfile({
    super.key,
    required this.ticket,
  });

  @override
  _TicketDetailScreenInProfileState createState() =>
      _TicketDetailScreenInProfileState();
}

class _TicketDetailScreenInProfileState
    extends State<TicketDetailScreenInProfile> {
  late ThemeData theme;
  late TextTheme textTheme;
  late ColorScheme colorScheme;
  String qrCodeData = "Example Data to Encode in QR";

  @override
  void initState() {
    super.initState();
    qrCodeData = widget.ticket.id ?? "N/A";
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    textTheme = theme.textTheme;
    colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticket Detail"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            QrImageView(
              data: qrCodeData,
              version: QrVersions.auto,
              size: 200.0,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 24),
            Text(
              "Show this QR code at the entrance",
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            ticketDetails(),
            const SizedBox(height: 24),
            CustomizeButton(
              onTap: () {
                // Handle your onTap here
              },
              text: 'Download Ticket',
              backgroundColor: colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget ticketDetails() {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            detailRow("Movie", widget.ticket.movie?.title ?? "N/A"),
            detailRow(
              "Session Time",
              formatDate(
                    widget.ticket.session?.sessionTime ?? DateTime.now(),
                    [dd, ' ', M, ' ', yyyy],
                  ) ??
                  "N/A",
            ),
            detailRow("Cinema", widget.ticket.session?.theaterName ?? "N/A"),
            detailRow("Seats", widget.ticket.seats?.join(", ") ?? "N/A"),
            detailRow(
                "Total Price",
                widget.ticket.totalAmount
                        ?.toInt()
                        .addCommas()
                        .addUnitPost('đ') ??
                    'N/A'),
          ],
        ),
      ),
    );
  }

  Widget detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: textTheme.titleMedium),
          ),
          Expanded(
            child: Text(value, style: textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
