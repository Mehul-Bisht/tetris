import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tetris/my_button.dart';
import 'dart:async';
import 'package:tetris/my_object.dart';
import 'package:tetris/my_score.dart';
import 'package:tetris/start_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numberOfColumns = 10;
  static int numberOfRows = 12; // 12 for web, 15 for mobile
  int totalItems = numberOfRows * numberOfColumns;
  int pieceIndex = 0;
  int rotationState = 0;
  List<List<int>> pieces = [
    [-16, -15, -6, -5],
    [-16, -6, 4, 5],
    [-15, -5, 4, 5],
    [-26, -16, -6, 4],
    [-16, -6, -5, 5],
    [-15, -5, -6, 4],
    [-16, -15, -14, -5]
  ];

  List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.purple,
    Colors.green,
    Colors.blue,
    Colors.brown,
    Colors.pink,
  ];

  List<List<int>> landedPieces = [];
  List<Color> landedColors = [];
  List<int> landed = [];

  bool hasHitGround = false;
  bool isGameRunning = false;
  int score = 0;

  bool isTopFull() {
    bool hasReachedTop = false;

    if (landed.contains(4) || landed.contains(5)) {
      hasReachedTop = true;
    }

    return hasReachedTop;
  }

  void startGame() {

    Timer.periodic(Duration(milliseconds: 400), (timer) {
      setState(() {
        if (isTopFull()) {
          setState(() {
            isGameRunning = false;
            restartGame();
          });
        }

        if (!isGameRunning) {
          timer.cancel();
        }

        hitGround();
        checkRows();

        if (!hasHitGround && isGameRunning) {
          for (int i = 0; i < pieces[pieceIndex].length; i++) {
            pieces[pieceIndex][i] += 10;
          }
        }

        if (hasHitGround) {
          timer.cancel();
          if (pieceIndex == 6) {
            resetPieces();
          }
          pieceIndex = (pieceIndex + 1) % 7;
          hasHitGround = false;
          if (isGameRunning) {
            startGame();
          }
        }
      });
    });
  }

  void moveLeft() {
    setState(() {
      bool canMoveLeft = true;
      for (int i = 0; i < pieces[pieceIndex].length; i++) {
        if (landed.contains(pieces[pieceIndex][i] - 1)) {
          canMoveLeft = false;
          break;
        }
      }

      if (canMoveLeft) {
        for (int i = 0; i < pieces[pieceIndex].length; i++) {
          pieces[pieceIndex][i] -= 1;
        }
      }
    });
  }

  void moveRight() {
    setState(() {
      bool canMoveRight = true;
      for (int i = 0; i < pieces[pieceIndex].length; i++) {
        if (landed.contains(pieces[pieceIndex][i] + 1)) {
          canMoveRight = false;
          break;
        }
      }

      if (canMoveRight) {
        for (int i = 0; i < pieces[pieceIndex].length; i++) {
          pieces[pieceIndex][i] += 1;
        }
      }
    });
  }

  void rotate() {
    switch (pieceIndex) {
      case 0:
        break;

      case 1:
        {
          pieces[1].sort();
          if (rotationState == 0) {
            int pivot = pieces[1][1];
            pieces[1].clear();
            pieces[1].add(pivot - 1);
            pieces[1].add(pivot);
            pieces[1].add(pivot + 1);
            pieces[1].add(pivot - 9);
          } else if (rotationState == 1) {
            int pivot = pieces[1][2];
            pieces[1].clear();
            pieces[1].add(pivot - 10);
            pieces[1].add(pivot - 11);
            pieces[1].add(pivot);
            pieces[1].add(pivot + 10);
          } else if (rotationState == 2) {
            int pivot = pieces[1][2];
            pieces[1].clear();
            pieces[1].add(pivot - 1);
            pieces[1].add(pivot);
            pieces[1].add(pivot + 1);
            pieces[1].add(pivot + 9);
          } else if (rotationState == 3) {
            int pivot = pieces[1][1];
            pieces[1].clear();
            pieces[1].add(pivot - 10);
            pieces[1].add(pivot);
            pieces[1].add(pivot + 10);
            pieces[1].add(pivot + 11);
          }
        }
        break;

      case 2:
        {
          pieces[2].sort();
          if (rotationState == 0) {
            int pivot = pieces[2][1];
            pieces[2].clear();
            pieces[2].add(pivot - 1);
            pieces[2].add(pivot);
            pieces[2].add(pivot + 1);
            pieces[2].add(pivot + 11);
          } else if (rotationState == 1) {
            int pivot = pieces[2][1];
            pieces[2].clear();
            pieces[2].add(pivot - 9);
            pieces[2].add(pivot - 10);
            pieces[2].add(pivot);
            pieces[2].add(pivot + 10);
          } else if (rotationState == 2) {
            int pivot = pieces[2][2];
            pieces[2].clear();
            pieces[2].add(pivot - 11);
            pieces[2].add(pivot - 1);
            pieces[2].add(pivot);
            pieces[2].add(pivot + 1);
          } else if (rotationState == 3) {
            int pivot = pieces[2][2];
            pieces[2].clear();
            pieces[2].add(pivot - 10);
            pieces[2].add(pivot);
            pieces[2].add(pivot + 9);
            pieces[2].add(pivot + 10);
          }
        }
        break;

      case 3:
        {
          pieces[3].sort();
          if (rotationState == 0) {
            int pivot = pieces[3][1];
            pieces[3].clear();
            pieces[3].add(pivot - 1);
            pieces[3].add(pivot);
            pieces[3].add(pivot + 1);
            pieces[3].add(pivot + 2);
          } else if (rotationState == 1) {
            int pivot = pieces[3][1];
            pieces[3].clear();
            pieces[3].add(pivot - 10);
            pieces[3].add(pivot);
            pieces[3].add(pivot + 10);
            pieces[3].add(pivot + 20);
          }

          rotationState = (rotationState + 1) % 2;
        }
        break;

      case 4:
        {
          pieces[4].sort();
          if (rotationState == 0) {
            int pivot = pieces[4][1];
            pieces[4].clear();
            pieces[4].add(pivot - 10);
            pieces[4].add(pivot - 9);
            pieces[4].add(pivot - 1);
            pieces[4].add(pivot);
          } else if (rotationState == 1) {
            int pivot = pieces[4][3];
            pieces[4].clear();
            pieces[4].add(pivot - 10);
            pieces[4].add(pivot);
            pieces[4].add(pivot + 1);
            pieces[4].add(pivot + 11);
          }

          rotationState = (rotationState + 1) % 2;
        }
        break;

      case 5:
        {
          pieces[5].sort();
          if (rotationState == 0) {
            int pivot = pieces[5][1];
            pieces[5].clear();
            pieces[5].add(pivot - 11);
            pieces[5].add(pivot - 10);
            pieces[5].add(pivot);
            pieces[5].add(pivot + 1);
          } else if (rotationState == 1) {
            int pivot = pieces[5][2];
            pieces[5].clear();
            pieces[5].add(pivot - 9);
            pieces[5].add(pivot);
            pieces[5].add(pivot + 1);
            pieces[5].add(pivot + 10);
          }

          rotationState = (rotationState + 1) % 2;
        }
        break;

      case 6:
        {
          pieces[6].sort();
          if (rotationState == 0) {
            int pivot = pieces[6][1];
            pieces[6].clear();
            pieces[6].add(pivot - 10);
            pieces[6].add(pivot);
            pieces[6].add(pivot + 1);
            pieces[6].add(pivot + 10);
          } else if (rotationState == 1) {
            int pivot = pieces[6][1];
            pieces[6].clear();
            pieces[6].add(pivot - 10);
            pieces[6].add(pivot - 1);
            pieces[6].add(pivot);
            pieces[6].add(pivot + 1);
          } else if (rotationState == 2) {
            int pivot = pieces[6][2];
            pieces[6].clear();
            pieces[6].add(pivot - 10);
            pieces[6].add(pivot - 1);
            pieces[6].add(pivot);
            pieces[6].add(pivot + 10);
          } else if (rotationState == 3) {
            int pivot = pieces[6][2];
            pieces[6].clear();
            pieces[6].add(pivot - 1);
            pieces[6].add(pivot);
            pieces[6].add(pivot + 1);
            pieces[6].add(pivot + 10);
          }
        }
        break;

      default:
    }

    if (pieceIndex == 1 || pieceIndex == 2 || pieceIndex == 6) {
      rotationState = (rotationState + 1) % 4;
    }
  }

  void hitGround() {
    pieces[pieceIndex].sort();
    if (pieces[pieceIndex].last + 10 > totalItems) {
      hasHitGround = true;
      landPiece();
    } else {
      for (int i = 0; i < pieces[pieceIndex].length; i++) {
        if (landed.contains(pieces[pieceIndex][i] + 10)) {
          hasHitGround = true;
          landPiece();
          break;
        }
      }
    }
  }

  void landPiece() {
    for (int i in pieces[pieceIndex]) {
      landed.add(i);
    }
    landedPieces.add(pieces[pieceIndex]);
    landedColors.add(colors[pieceIndex]);
    rotationState = 0;
  }

  void resetPieces() {
    pieces[0] = [-16, -15, -6, -5];
    pieces[1] = [-16, -6, 4, 5];
    pieces[2] = [-15, -5, 4, 5];
    pieces[3] = [-26, -16, -6, 4];
    pieces[4] = [-16, -6, -5, 5];
    pieces[5] = [-15, -5, -6, 4];
    pieces[6] = [-16, -15, -14, -5];
  }

  void restartGame() {
    resetPieces();
    score = 0;
    landed.clear();
    landedPieces.clear();
    landedColors.clear();
    pieceIndex = 0;
    hasHitGround = false;
  }

  void checkRows(){

    for(int i = numberOfRows - 1; i > 0; i--){
      int count = 0;
      for(int j = 0; j < numberOfColumns; j++){
        if(landed.contains(i*numberOfColumns + j)){
          count++;
        }
      }
      if(count == numberOfColumns){
          clearRow(i * numberOfColumns);
      }
    }

  }

  void clearRow(int startIndex){

    setState(() {

    score++;

    for(int j = 0; j < numberOfColumns; j++) {
      landed.remove(startIndex + j);
      landedPieces.forEach((element) {
        if(element.contains(startIndex + j)){
          element.remove(startIndex + j);
          // if(element.isEmpty){
          //   int colorIndex = landedPieces.indexOf(element);
          //   colors.removeAt(colorIndex);
          // }
        }
      });
    }

    landedPieces.forEach((element) {
      element.forEach((innerElement) {
        if(innerElement < startIndex){
          landed.remove(innerElement);
          innerElement += numberOfColumns;
          landed.add(innerElement);
        }
      });
    });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: numberOfColumns,
              ),
              itemCount: totalItems,
              itemBuilder: (BuildContext context, int index) {
                if (pieces[pieceIndex].contains(index)) {
                  return MyObject(color: colors[pieceIndex]);
                } else if (landed.contains(index)) {
                  Color color = Colors.white;
                  for (int i = 0; i < landedPieces.length; i++) {
                    if (landedPieces[i].contains(index)) {
                      color = landedColors[i];
                      break;
                    }
                  }
                  return MyObject(
                    color: color,
                  );
                } else {
                  return MyObject(
                    color: Colors.black,
                  );
                }
              },
            ),
          ),
          Center(
            child: Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StartButton(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (!isGameRunning)
                                  ? Text(
                                      "START",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  : Text(
                                      "STOP",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "GAME",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ]),
                      ),
                      function: () {
                        if (!isGameRunning) {
                          isGameRunning = true;
                          startGame();
                        } else {
                          isGameRunning = false;
                          restartGame();
                        }
                      },
                    ),
                    MyScore(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(
                          "Score :",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "$score",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    MyButton(
                      child: Icon(
                        Icons.arrow_left,
                        color: Colors.white,
                        size: 40,
                      ),
                      function: () {
                        if (isGameRunning) {
                          moveLeft();
                        }
                      },
                    ),
                    MyButton(
                      child: Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                        size: 40,
                      ),
                      function: () {
                        if (isGameRunning) {
                          moveRight();
                        }
                      },
                    ),
                    MyButton(
                      child: Icon(
                        Icons.rotate_left_rounded,
                        color: Colors.white,
                      ),
                      function: () {
                        if (isGameRunning) {
                          rotate();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
      ),
      );
  }
}
