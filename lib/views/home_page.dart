import 'package:basketball_scoreboard/controllers/scoreboard_controller.dart';
import 'package:basketball_scoreboard/models/cards_model.dart';
import 'package:basketball_scoreboard/views/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scoreController = Get.put(ScoreboardController());

    scoreController.configClock();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => scoreController.resetGame(),
            icon: Icon(Icons.refresh),
            tooltip: 'Reiniciar o jogo',
            color: Colors.white,
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu, color: Colors.white),
            onSelected: (value) {
              if (value == 'teams') {
                scoreController.openPopup(CardsTypes.teams);
              } else if (value == 'time') {
                scoreController.openPopup(CardsTypes.timing);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'teams',
                child: Text('TIMES'),
              ),
              const PopupMenuItem(
                value: 'time',
                child: Text('TEMPO'),
              ),
            ],
          ),
        ],
      ),
      body: Obx(
        () {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/background.png',
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            scoreController.firstTeam.value.name.toUpperCase(),
                            style: TextStyle(color: Colors.white, fontSize: 48),
                          ),
                          InkWell(
                            onTap: () => scoreController.addFirstTeamPoints(),
                            onLongPress: () =>
                                scoreController.removeFirstTeamPoints(),
                            child: Container(
                              width: 250,
                              height: 155,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  scoreController.firstTeam.value.points
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 130,
                                    fontFamily: 'LEDDotMatrix',
                                    height: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: scoreController.tradeTeams,
                            child: Icon(
                              Icons.compare_arrows,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'TEMPO',
                            style: TextStyle(color: Colors.white, fontSize: 32),
                          ),
                          InkWell(
                            onTap: () => scoreController.playCronom(),
                            onLongPress: () =>
                                scoreController.removeSecondTeamPoints(),
                            child: Container(
                              width: 280,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  "${scoreController.minutes.value < 10 ? '0${scoreController.minutes.value}' : '${scoreController.minutes.value}'}:${scoreController.seconds.value < 10 ? '0${scoreController.seconds.value}' : '${scoreController.seconds.value}'}",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 80,
                                    fontFamily: 'LEDDotMatrix',
                                    height: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            scoreController.secondTeam.value.name.toUpperCase(),
                            style: TextStyle(color: Colors.white, fontSize: 48),
                          ),
                          InkWell(
                            onTap: () => scoreController.addSecondTeamPoints(),
                            onLongPress: () =>
                                scoreController.removeSecondTeamPoints(),
                            child: Container(
                              width: 250,
                              height: 155,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  scoreController.secondTeam.value.points
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 130,
                                    fontFamily: 'LEDDotMatrix',
                                    height: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: scoreController.popUp.value != CardsTypes.none
                    ? CardWidget()
                    : Container(),
              )
            ],
          );
        },
      ),
    );
  }
}
