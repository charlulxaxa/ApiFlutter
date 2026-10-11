import 'package:flutter/material.dart';
import '../atoms/app_text.dart';

class StatsBarWidget extends StatelessWidget {
  final String name;
  final String type;
  final int? atk;
  final int? def;
  final int? level;
  final String race;
  final String? attribute;
  const StatsBarWidget({super.key,
    required this.name,
    required this.type,
    this.atk,
    this.def,
    this.level,
    required this.race,
    this.attribute,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
                  children: [
                    AppText(name, style: AppTextStyle.name),
                    AppText('Type: $type'),
                    AppText('ATK: ${atk ?? 'N/A'}', style: AppTextStyle.atk),
                    AppText('DEF: ${def ?? 'N/A'}', style: AppTextStyle.category),
                    AppText('Level: ${level ?? 'N/A'}', style: AppTextStyle.category),
                    AppText('Race: $race', style: AppTextStyle.category),
                    AppText('Attribute: ${attribute ?? 'N/A'}', style: AppTextStyle.category),
                  ],
                );
  }
}