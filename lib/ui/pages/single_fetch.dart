import 'package:flutter/material.dart';
import '../../models/yugiohModel.dart';
import '../../services/yugiApi.dart';
import '../atoms/atoms.dart';
import '../molecules/molecules.dart';
import '../organism/yugioh_card.dart';
import '../template/single_template.dart';
import 'Stream.dart';

class SingleFetch extends StatefulWidget {
  const SingleFetch({super.key});

  @override
  State<SingleFetch> createState() => _SingleFetchState();
}

class _SingleFetchState extends State<SingleFetch> {
  late Future<List<Yugioh>> _cards;
  final List<Yugioh> myCards = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
  _cards = YgoApi.fetchCards({'archetype': 'Blue-Eyes'});
  }

  void addCard(Yugioh card) {
    final already = myCards.any((c) => c.id == card.id);
    if (!already) setState(() => myCards.add(card));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(already
          ? '${card.name} is already in the collection'
          : '${card.name} added to the Card Collection!'),
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleTemplate(
      appbar:BarApp(title: 'Single Fetch',actions: [
          AppButton(
            label:"Stream",
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => YugiohStream()),
            ),
          ),
        ],),
      cards: [
        FutureBuilder<List<Yugioh>>(
          future: _cards,
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const LoadingSpinner();
            }
            if (snap.hasError) {
              return ErrorRetry(
                message: '${snap.error}',
                onRetry: () => setState(_load),
              );
            }
            final cards = snap.data ?? [];
            if (cards.isEmpty) return const MessageText('No items to show');
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: cards.length,
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Center(
                  child: Container(
                    child: YugiohCard(
                      yugioh: cards[i],
                      onAdd: () => addCard(cards[i]),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}