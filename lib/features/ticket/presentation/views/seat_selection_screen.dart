// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cinema/core/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../movie_detail/data/models/session_model.dart';
import '../../../movie_detail/domain/entities/movie_detail_entity.dart';
import '../../domain/entities/ticket_entity.dart';
import '../bloc/seat_selection_bloc.dart';
import '../bloc/seat_selection_event.dart';
import '../bloc/seat_selection_state.dart';
import 'screens/seat_selection_confirm_payment_screen.dart';
import 'widget/seat_map_widget.dart';

// part 'seat_selection_screen.action.dart';

class SeatSelectionScreenArg {
  final MovieSession sessionModel;
  final MovieDetailEntity movieDetailEntity;
  SeatSelectionScreenArg({
    required this.sessionModel,
    required this.movieDetailEntity,
  });
}

// ignore: must_be_immutable
class SeatSelectionScreen extends StatefulWidget {
  final MovieSession sessionModel;
  final MovieDetailEntity movieDetailEntity;

  const SeatSelectionScreen({
    super.key,
    required this.sessionModel,
    required this.movieDetailEntity,
  });

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  late TextTheme _textTheme;
  late ColorScheme _colorScheme;

  @override
  void dispose() {
    EasyLoading.removeCallback;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    _textTheme = theme.textTheme;
    _colorScheme = theme.colorScheme;
    return BlocConsumer<TicketBloc, TicketState>(
      listener: (context, state) {
        print(state);
        if (state is TicketsLoading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state is TicketOperationSuccess) {
          EasyLoading.showSuccess('Operation successful!');
        } else if (state is TicketOperationFailure) {
          if (mounted) {
            EasyLoading.showError(state.error);
          }
        } else {
          if (mounted) {
            EasyLoading.dismiss();
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      // titleSpacing: 50,
      title: Column(
        children: [
          Text(
            widget.sessionModel.theaterName ?? '',
            style: _textTheme.titleMedium,
          ),
          Text(
            widget.movieDetailEntity.title ?? '',
            style: _textTheme.bodyMedium
                ?.copyWith(color: _colorScheme.primaryContainer),
          ),
        ],
      ),
      leading: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 64),
        child: Container(
          padding: const EdgeInsets.all(16),
          color: _colorScheme.surface,
          child: Row(
            children: [
              _buildAppbarBottomItem(
                Icon(
                  Icons.calendar_today,
                  color: _colorScheme.primaryContainer,
                ),
                widget.sessionModel.sessionTime?.toMonthNameWithDate() ?? '',
              ),
              const SizedBox(
                width: 16,
              ),
              _buildAppbarBottomItem(
                Icon(
                  Icons.access_time,
                  color: _colorScheme.primaryContainer,
                ),
                widget.sessionModel.sessionTime?.toTimeFormat() ?? '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildBody() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAnnotationItem(
                color: _colorScheme.outline,
                text: 'Available',
              ),
              _buildAnnotationItem(
                color: Colors.grey,
                text: 'Occupied',
              ),
              _buildAnnotationItem(
                color: _colorScheme.primary,
                text: 'Chosen',
              ),
            ],
          ),
        ),
        Expanded(
          child: SeatMapWidget(
            movieDetail: widget.movieDetailEntity,
            session: widget.sessionModel,
            onBookTicket: _onBookTicket,
          ),
        ),
        // Other widgets
      ],
    );
  }

  void _onBookTicket(TicketEntity ticket) {
    final TicketBloc ticketBloc = BlocProvider.of<TicketBloc>(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (bottomSheetContext) {
        return SeatSelectionPaymentConfirmScreen(
          ticketEntity: ticket,
          ticketBloc: ticketBloc,
          onConfirm: (finalTicket) {
            ticketBloc.add(
              CreateTicketEvent(
                userId: finalTicket.userId!,
                ticket: finalTicket,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAnnotationItem({
    required Color color,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: color,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            text,
            style: _textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Expanded _buildAppbarBottomItem(Icon icon, String value) {
    return Expanded(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: _colorScheme.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(
              width: 6,
            ),
            Text(
              value,
              style: _textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
