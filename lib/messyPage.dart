import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'models/yugiohModel.dart';
import 'services/yugiApi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
List<Yugioh> cards = [];

class _HomePageState extends State<HomePage> {
  late Future<List<Yugioh>> _cards;

  @override
  void initState() {
    super.initState();
    _cards = YgoApi.fetchCards({'archetype': 'Blue-Eyes'});
  }
  void AddCard(Yugioh card) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
      content: Text('${card.name} added to the Card Collection!'),
      duration: const Duration(seconds: 2),
    ));
    setState(() {
      cards.add(card);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Yugioh>>(
        future: _cards,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('${snap.error}'));
          }
          final cards = snap.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.60,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemCount: cards.length,
            itemBuilder: (_, i) => 
            Column(
              children: [
                GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(cards[i].name),
                      content: Text('${cards[i].type}\n\n${cards[i].desc}'),
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: cards[i].imageSmall,
                    placeholder: (_, __) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (_, url, error) {
                      debugPrint('IMAGE ERROR: $url -> $error');
                      return const Icon(Icons.broken_image);
                    },
                  ),
                ),
                Column(
                  children: [
                    Text(cards[i].name),
                    Text('Type: ${cards[i].type}'),
                    Text('ATK: ${cards[i].atk ?? 'N/A'}'),
                    Text('DEF: ${cards[i].def ?? 'N/A'}'),
                    Text('Level: ${cards[i].level ?? 'N/A'}'),
                    Text('Race: ${cards[i].race}'),
                    Text('Attribute: ${cards[i].attribute ?? 'N/A'}'),
                  ],
                ),
                SizedBox(height: 20,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    onPressed: () {
                      AddCard(cards[i]);
                    },
                    child: const Text('Add Card'),
                  ),
                ),
              ],
            ),
            
          );
        },
      ),
    );
  }
}
