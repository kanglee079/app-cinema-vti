// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cinema/core/utils/int_utils.dart';
import 'package:app_cinema/core/utils/string_utils.dart';
import 'package:app_cinema/features/movie_detail/data/models/session_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_function.dart';
import '../../../../widgets/custom_button.dart';
import '../../../movie_detail/domain/entities/movie_detail_entity.dart';
import '../../domain/entities/seat_theater_entity.dart';
import '../../domain/entities/ticket_entity.dart';

class SeatMapWidget extends StatefulWidget {
  MovieDetailEntity? movieDetail;
  MovieSession? session;
  Function(TicketEntity) onBookTicket;
  SeatMapWidget({
    super.key,
    required this.onBookTicket,
    this.movieDetail,
    this.session,
  });

  @override
  State<SeatMapWidget> createState() => _SeatMapWidgetState();
}

class _SeatMapWidgetState extends State<SeatMapWidget> {
  late ThemeData theme;

  TextTheme get _textTheme => theme.textTheme;
  ColorScheme get _colorScheme => theme.colorScheme;
  final TransformationController _controller = TransformationController();
  bool isShowSeat = false;
  bool isCanScrollParent = true;
  List<SeatTheaterEntity> seatData = <SeatTheaterEntity>[];
  List<SeatTheaterEntity> get selectedSeat => seatData
      .where((element) => element.status == SeatTheaterStatus.chosen)
      .toList();

  @override
  void initState() {
    super.initState();
    seatData = generateSeatTheater();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: isCanScrollParent
                ? const ScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: InteractiveViewer(
              maxScale: 4,
              onInteractionUpdate: (details) {
                final double correctScaleValue =
                    _controller.value.getMaxScaleOnAxis();
                setState(() {
                  isShowSeat = correctScaleValue > 1.8;
                  isCanScrollParent = correctScaleValue == 1;
                });
              },
              transformationController: _controller,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Column(
                  children: [
                    Text(
                      'Screen',
                      style: _textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Icon(
                      Icons.screen_lock_landscape,
                      size: 32,
                      color: _colorScheme.primary,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: seatData.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 12,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (seatData[index].status !=
                                  SeatTheaterStatus.occupied) {
                                setState(() {
                                  seatData[index].status =
                                      seatData[index].status.toggle();
                                });
                              }
                            },
                            child: Container(
                              width: 12,
                              height: 12,
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: seatData[index].status ==
                                        SeatTheaterStatus.chosen
                                    ? _colorScheme.primary
                                    : seatData[index].status ==
                                            SeatTheaterStatus.available
                                        ? _colorScheme.outline
                                        : Colors.grey,
                              ),
                              child: isShowSeat
                                  ? FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        seatData[index].position,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  'Danh sách ghế đã chọn: ${selectedSeat.map((e) => e.position).join(', ')}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  'Tổng tiền: ${selectedSeat.length} x ${100000.addCommas().addUnitPost('đ')} = ${(selectedSeat.length * 100000).addCommas().addUnitPost('đ')}',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomizedButton(
                onTap: () {
                  widget.onBookTicket(
                    TicketEntity(
                      movie: widget.movieDetail,
                      session: widget.session,
                      seats: selectedSeat.map((e) => e.position).toList(),
                      totalAmount: selectedSeat.length * 100000,
                    ),
                  );
                },
                text: 'Đặt ${selectedSeat.length} vé',
                backgroundColor: _colorScheme.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
