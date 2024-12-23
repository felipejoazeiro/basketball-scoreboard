import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:basketball_scoreboard/models/cards_model.dart';
import 'package:basketball_scoreboard/models/teams_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreboardController extends GetxController {
  final firstTeam = TeamModel(name: 'Camisa', points: 0).obs;
  final secondTeam = TeamModel(name: 'Colete', points: 0).obs;

  var startMinutes = 10.obs;
  var startSeconds = 10.obs;

  var minutes = 10.obs;
  var seconds = 10.obs;
  var isRunning = false.obs;

  var popUp = CardsTypes.none.obs;

  Timer? _timer;

  final AudioPlayer _audioPlayer = AudioPlayer();

  void configClock() {
    minutes.value = startMinutes.value;
    seconds.value = startSeconds.value;
  }

  void addFirstTeamPoints() {
    firstTeam.update((team) {
      team?.points++;
    });
  }

  void removeFirstTeamPoints() {
    firstTeam.update((team) {
      team?.points--;
    });
  }

  void addSecondTeamPoints() {
    secondTeam.update((team) {
      team?.points++;
    });
  }

  void removeSecondTeamPoints() {
    secondTeam.update((team) {
      team?.points--;
    });
  }

  void incrementMinutes() => minutes++;
  void decrementMinutes() {
    if (minutes > 0) minutes--;
  }

  void updateStartMinutes(int newMinute) {
    startMinutes.value = newMinute;
  }

  void updateStartSeconds(int newSeconds) {
    startSeconds.value = newSeconds;
  }

  void playCronom() {
    if (isRunning.value) {
      pauseCron();
      isRunning.value = false;
      return;
    }

    isRunning.value = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds.value == 0) {
        if (minutes > 0) {
          minutes.value--;
          seconds.value = 59;
        } else {
          // TODO tocar som final
          pauseCron();
        }
      } else {
        seconds.value--;
      }
      if (minutes.value == 1 && seconds.value == 0) {
        //TODO Tocar som de um minuto
      }
    });
  }

  void pauseCron() {
    _timer?.cancel();
    isRunning.value = false;
  }

  void resetCron() {
    _timer?.cancel();
    isRunning.value = false;
    minutes.value = startMinutes.value;
    seconds.value = startSeconds.value;
  }

  void resetGame() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(firstTeam.value.name, firstTeam.value.points);
    await prefs.setInt(secondTeam.value.name, secondTeam.value.points);

    secondTeam.update((team) {
      team?.points = 0;
    });
    firstTeam.update((team) {
      team?.points = 0;
    });
    resetCron();
    update();
  }

  String getFirstTeamName() {
    return firstTeam.value.name;
  }

  String getSecondTeamName() {
    return secondTeam.value.name;
  }

  void updateFirstTeamName(String newName) {
    firstTeam.value.name = newName;
  }

  void updateSecondTeamName(String newName) {
    secondTeam.value.name = newName;
  }

  void openPopup(CardsTypes card) {
    popUp.value = card;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
