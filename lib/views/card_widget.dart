import 'package:basketball_scoreboard/controllers/scoreboard_controller.dart';
import 'package:basketball_scoreboard/models/cards_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ScoreboardController controller = Get.put(ScoreboardController());

    switch (controller.popUp.value) {
      case CardsTypes.none:
        return Container();
      case CardsTypes.teams:
        return teamsCard();
      case CardsTypes.timing:
        return timingCard();
    }
  }

  Widget teamsCard() {
    return Card(
      color: const Color.fromRGBO(48, 31, 76, 1),
      child: SizedBox(
        width: 300,
        height: 200,
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(48, 31, 76, 1),
                          borderRadius: BorderRadius.circular(
                              BorderSide.strokeAlignInside)),
                    ),
                    Container(),
                  ],
                ),
                Container(),
                Column()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget timingCard() {
    return Container();
  }
}
