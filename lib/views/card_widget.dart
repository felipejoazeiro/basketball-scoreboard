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
        return teamsCard(controller);
      case CardsTypes.timing:
        return timingCard(controller);
    }
  }

  Widget timingCard(ScoreboardController controller) {
    return Obx(() {
      return Card(
          color: const Color.fromRGBO(48, 31, 76, 1),
          child: Container(
            width: 350,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 6),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 8),
                      child: InkWell(
                        onTap: () => controller.openPopup(CardsTypes.none),
                        child: Icon(
                          Icons.close_sharp,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () => controller.configMinutes++,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '+1',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        controller.configMinutes.value > 0
                                            ? controller.configMinutes--
                                            : null,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '-1',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${controller.configMinutes} : ${controller.configSeconds}',
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (controller.configSeconds.value ==
                                          55) {
                                        controller.configMinutes++;
                                        controller.configSeconds.value = 0;
                                      } else {
                                        controller.configSeconds + 5;
                                      }
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '+5',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        controller.configSeconds.value == 0
                                            ? null
                                            : controller.configSeconds - 5,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '-5',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                      child: Image.asset(
                        'assets/images/config_logo.png',
                        width: 150,
                      ),
                    ),
                    InkWell(
                      onTap: () => controller.changeTiming(),
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            'SALVAR',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ));
    });
  }

  Widget teamsCard(ScoreboardController controller) {
    final TextEditingController firstTeamController = TextEditingController();
    final TextEditingController secondTeamController = TextEditingController();
    return Obx(() {
      return Card(
        color: const Color.fromRGBO(48, 31, 76, 1),
        child: SingleChildScrollView(
          child: Container(
            width: 350,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 6,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 8),
                      child: InkWell(
                        onTap: () => controller.openPopup(CardsTypes.none),
                        child: Icon(
                          Icons.close_sharp,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: firstTeamController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: controller.firstTeam.value.name,
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: secondTeamController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: controller.secondTeam.value.name,
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                      child: Image.asset(
                        'assets/images/config_logo.png',
                        width: 150,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        String firstName = firstTeamController.text;
                        String secondName = secondTeamController.text;

                        controller.changeTeamsNames(firstName, secondName);
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            'SALVAR',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
