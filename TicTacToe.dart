import 'dart:io';
import 'dart:math';

class TicTacToe {
  List<String> values = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];
  List<String> combinations = [
    "012",
    "048",
    "036",
    "147",
    "246",
    "258",
    "345",
    "678"
  ];
  bool winner = false;
  bool isXturn = true;
  int moveCount = 0;
  String mode = "";
  String computerLevel = "";
  Random random = Random();

  // Player's move
  void playerMove() {
    if (!winner) {
      print("Player ${isXturn ? "X" : "O"}: Choose Your Number (1-9):");
      int? num = getValidInput(1, 9);
      // invaild move error handling
      if (num == null || values[num - 1] == "X" || values[num - 1] == "O") {
        print("Invalid move, try again.");
        playerMove();
        return;
      }

      values[num - 1] = isXturn ? "X" : "O";
      isXturn = !isXturn;
      moveCount++;

      displayBoard();
      checkWinner("X");
      checkWinner("O");

      if (moveCount == 9 && !winner) {
        print("DRAW .....");
        PlayAgain();
      } else if (!winner) {
        if (mode == "PvC") robotMove(); // Robot plays
        if (!winner) playerMove(); // Continue game if no winner
      }
    }
  }

  // Function for Robot's move ( Level )
  void robotMove() {
    if (computerLevel == "easy") {
      easyModeMove();
    } else if (computerLevel == "hard") {
      hardModeMove();
    }
  }

  // Function for  Easy mode: Randomly selects an available move
  void easyModeMove() {
    int move;
    do {
      move = random.nextInt(9);
    } while (values[move] == "X" || values[move] == "O");

    values[move] = "O";
    print("Computer (Easy) placed O in position ${move + 1}");
    isXturn = !isXturn;
    moveCount++;
    displayBoard();
    checkWinner("X");
    checkWinner("O");
  }

  // Function for Hard mode: Uses the Minimax algorithm for optimal play
  void hardModeMove() {
    int bestScore = -1000;
    int bestMove = -1;

    for (int i = 0; i < 9; i++) {
      if (values[i] != "X" && values[i] != "O") {
        String previousValue = values[i];
        values[i] = "O";
        int score = minimax(0, false, moveCount + 1); // Pass moveCount here
        values[i] = previousValue;
        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }

    values[bestMove] = "O";
    print("Computer (Hard) placed O in position ${bestMove + 1}");
    isXturn = !isXturn;
    moveCount++;
    displayBoard();
    checkWinner("X");
    checkWinner("O");
  }

  // Function of Minimax algorithm for hard mode
  int minimax(int depth, bool isMaximizing, int simulatedMoveCount) {
    if (checkWinnerMinimax("O")) return 10 - depth;
    if (checkWinnerMinimax("X")) return depth - 10;
    if (simulatedMoveCount == 9) return 0; // Use simulated move count here

    int bestScore = isMaximizing ? -1000 : 1000;
    for (int i = 0; i < 9; i++) {
      if (values[i] != "X" && values[i] != "O") {
        String previousValue = values[i];
        values[i] = isMaximizing ? "O" : "X";
        int score = minimax(depth + 1, !isMaximizing,
            simulatedMoveCount + 1); // Increase simulatedMoveCount
        values[i] = previousValue;
        bestScore =
            isMaximizing ? max(score, bestScore) : min(score, bestScore);
      }
    }
    return bestScore;
  }

  // Function to Check combinations for Minimax algorithm
  bool checkWinnerMinimax(String player) {
    for (var item in combinations) {
      if (values[int.parse(item[0])] == player &&
          values[int.parse(item[1])] == player &&
          values[int.parse(item[2])] == player) {
        return true;
      }
    }
    return false;
  }

  // Function to  Check if there's a winner
  void checkWinner(String player) {
    for (var item in combinations) {
      bool combinationValidate = check_combination(item, player);
      if (combinationValidate) {
        print("Congratulations! The $player is the Winner....");
        winner = true;
        PlayAgain();
        break;
      }
    }
  }

  // Function to Ask if the players want to play again
  void PlayAgain() {
    print("Do you want to play again? (y/n)");
    String? input = stdin.readLineSync()?.toLowerCase();
    if (input == 'y') {
      resetGame();
      startGame(); // Restart the game
    } else if (input == 'n') {
      print("Thanks for playing!");
      exit(0);
    } else {
      print("Invalid input, please choose 'y' for yes or 'n' for no.");
      PlayAgain(); // Repeat if invaild input
    }
  }

  // Reset the game state for a new round
  void resetGame() {
    values = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];
    winner = false;
    isXturn = true;
    moveCount = 0;
  }

  // ANSI escape codes
  String reset = '\x1B[0m'; // Default Color
  String red = '\x1B[31m'; // Red Color for 'X'
  String blue = '\x1B[34m'; // Blue Color for 'O'

  // Function to display the board ( Colored 'X' AND 'O')
  void displayBoard() {
    print("=============");
    print(
        "| ${coloredValue(values[0])} | ${coloredValue(values[1])} | ${coloredValue(values[2])} |");
    print("-------------");
    print(
        "| ${coloredValue(values[3])} | ${coloredValue(values[4])} | ${coloredValue(values[5])} |");
    print("-------------");
    print(
        "| ${coloredValue(values[6])} | ${coloredValue(values[7])} | ${coloredValue(values[8])} |");
    print("=============");
  }

  // Function to apply colors to X and O
  String coloredValue(String value) {
    if (value == "X") {
      return "$red$value$reset";
    } else if (value == "O") {
      return "$blue$value$reset";
    } else {
      return value; // No color for (numbers)
    }
  }

  // Function to Check if a combination is met
  bool check_combination(String combination, String player) {
    List<int> numbers = combination.split('').map((item) {
      return int.parse(item);
    }).toList();
    bool match = true;
    for (var item in numbers) {
      if (values[item] != player) {
        match = false;
        break;
      }
    }
    return match;
  }

  // Start the game and choose mode
  void startGame() {
    print("Choose Mode:");
    print("1. Player vs Player (PvP)");
    print("2. Player vs Computer (PvC)");
    int? choice = getValidInput(1, 2);

    if (choice == null) {
      print("Invalid choice. Try again.");
      startGame();
      return;
    }

    if (choice == 1) {
      mode = "PvP";
    } else if (choice == 2) {
      mode = "PvC";
      chooseComputerLevel();
    }

    displayBoard();
    playerMove();
  }

  // Function to Choose computer difficulty level
  void chooseComputerLevel() {
    print("Choose Computer Difficulty Level:");
    print("1. Easy");
    print("2. Hard");
    int? levelChoice = getValidInput(1, 2);

    if (levelChoice == null) {
      print("Invalid choice. Try again.");
      chooseComputerLevel();
      return;
    }

    computerLevel = (levelChoice == 1) ? "easy" : "hard";
  }

  // Function to Get valid input from user with error handling
  int? getValidInput(int min, int max) {
    try {
      String? input = stdin.readLineSync();
      if (input == null) return null;
      int value = int.parse(input);
      if (value < min || value > max) throw FormatException();
      return value;
    } catch (e) {
      return null; // Return null if input is invalid
    }
  }
}
