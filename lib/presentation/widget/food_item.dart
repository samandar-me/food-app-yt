import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app_yt/data/model/food_response.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodItem extends StatelessWidget {
  const FoodItem({super.key, required this.results, required this.onClick});
  final Results results;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 180, /// 1
        child: InkWell(
          onTap: onClick,
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.tertiaryContainer /// 2
            ),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                      child: Image.network(results.image ?? "", fit: BoxFit.cover, height: 200,)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(results.title ?? "", style: GoogleFonts.baloo2(fontSize: 20,color: Colors.black), maxLines: 2,overflow: TextOverflow.ellipsis,),
                          Text(results.summary ?? "", style: GoogleFonts.baloo2(fontSize: 14,color: Colors.black87), maxLines: 3,overflow: TextOverflow.ellipsis,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment:CrossAxisAlignment.center,
                            children: [
                                _textIcon(results.aggregateLikes.toString(), CupertinoIcons.heart_fill, Colors.red),
                              _textIcon(results.cookingMinutes.toString(), CupertinoIcons.time, Colors.orangeAccent),
                              _textIcon("Vegan", Icons.eco, results.vegan == true ? Colors.green : CupertinoColors.systemGrey2),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _textIcon(String text, IconData iconData, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData,color: color),
        Text(text, style: TextStyle(color: color))
      ],
    );
  }
}
