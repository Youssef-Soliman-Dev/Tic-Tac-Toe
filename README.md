# 🎮 Tic-Tac-Toe Game
A **console-based Tic-Tac-Toe game** built with Dart! Play against a friend or test your skills against a computer on Easy or Hard difficulty.

# 📜 How to Play
Tic-Tac-Toe is a two-player game where each player alternates marking a square on a 3x3 grid. The objective is to align three of your symbols (either **"X"** or **"O"**) in a row—**vertically, horizontally, or diagonally**—before your opponent.

# 🎮 Game Modes
* **👥 Player vs Player (PvP)**: Two players take turns on the same device. 
* **🤖 Player vs Computer (PvC)**: Challenge the computer on one of two difficulty levels: 
    * **Easy**: The computer selects moves randomly. 
    * **Hard**: The computer plays optimally with the Minimax algorithm.

# 🛠 Installation
1. Ensure you have **Dart** installed.
2. Clone this repository: `git clone https://github.com/Youssef-Soliman-Dev/Tic-Tac-Toe/.git` 
3. Navigate to the directory and run the game with: `dart run tic_tac_toe.dart`

# 🎲 Instructions 
1. **Choose Game Mode**: 
* After launching, select either **PvP** or **PvC** mode. 
2. **Choose Difficulty (PvC only)**: 
* In **PvC mode**, you’ll select the computer's difficulty level: Easy or Hard. 
3. **Make Your Move**:
* The game displays a 3x3 grid numbered from 1 to 9. 
* On your turn, enter the number that corresponds to your desired position. 
* If the position is already occupied, you'll be prompted to choose another. 
4. **Computer’s Turn**: 
* In **PvC mode**, the computer will make its move after yours. 
5. **Winning the Game**: 
* The game checks for a winner after each move. 
* The first player to align three symbols in a row wins! 
* If all positions are filled without a winner, the game declares a **draw**. 
6. **Play Again**: 
* After each game, choose to start a new round or exit.”

# 🎛 Game Controls
* **Grid Positions**:
 `1 | 2 | 3

  ---------
  
  4 | 5 | 6
  ---------
  
  7 | 8 | 9`
  
* **Symbol Colors**: 
  * "X" is displayed in **red**. 
  * "O" is displayed in **blue**.

# 👀 Example Gameplay  
Choose Mode: 
1. Player vs Player (PvP)
2. Player vs Computer (PvC) 
Player X: Choose Your Number (1-9):
 5 
=============
| 1 | 2 | 3 |
-------------
| 4 | X | 6 | 
-------------
| 7 | 8 | 9 | 
=============
