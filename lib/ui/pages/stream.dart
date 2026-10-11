import 'package:flutter/material.dart';
import '../../models/yugiohModel.dart';
import '../../services/yugiApi.dart';
import '../atoms/atoms.dart';
import '../molecules/molecules.dart';
import '../organism/yugioh_card.dart';
import '../template/single_template.dart';
import 'dart:async';

class YugiohStream extends StatefulWidget {
  const YugiohStream({super.key});

  @override
  State<YugiohStream> createState() => _YugiohStreamState();
}

class _YugiohStreamState extends State<YugiohStream> {
  final StreamController<Yugioh> _belt = StreamController<Yugioh>();

  Timer? _timer;

  Future<void> yugiCard() async {

    try {
      final card = await YgoApi.streamFetchCard();
      if (!_belt.isClosed) _belt.add(card);
    } catch (e) {
      if (!_belt.isClosed) _belt.addError('Error: something went wrong');
    } finally {

    }
  }

  @override
  void initState() {
    super.initState();
    yugiCard();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => yugiCard());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _belt.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleTemplate(
      appbar: const BarApp(title: 'Stream Page'),
      cards: [
        StreamBuilder<Yugioh>(
          stream: _belt.stream,
          builder: (context, snap) {
            if (snap.hasError) {
              return ErrorRetry(
                message: '${snap.error}',
                onRetry: () => yugiCard(),
              );
            }
            if (!snap.hasData) {
              return const LoadingSpinner();
            }

            final card = snap.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: YugiohCard(
                    yugioh: card,
                  ),
                ),
            );
          },
        ),
      ],
    );
  }
}