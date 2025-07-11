import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:chess/chess.dart' as chess_lib;

void main() {
  runApp(const InnochessApp());
}

class InnochessApp extends StatelessWidget {
  const InnochessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'innochess',
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          secondary: Colors.white,
          background: Colors.white,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('innochess'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Placeholder for logo
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.sports_esports, size: 60, color: Colors.blue),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SinglePlayerScreen()),
                  );
                },
                child: const Text('Single Player (vs Computer)'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(220, 48),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MultiplayerLocalScreen()),
                  );
                },
                child: const Text('Multiplayer (Same Device)'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(220, 48),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MultiplayerOnlineScreen()),
                  );
                },
                child: const Text('Multiplayer (Online)'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(220, 48),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GoogleSignInScreen()),
                  );
                },
                icon: const Icon(Icons.login, color: Colors.blue),
                label: const Text('Sign in with Google', style: TextStyle(color: Colors.blue)),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(220, 48),
                  side: const BorderSide(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Update SinglePlayerScreen to include game mode selection and navigation to ChessBoardScreen
class SinglePlayerScreen extends StatefulWidget {
  const SinglePlayerScreen({super.key});

  @override
  State<SinglePlayerScreen> createState() => _SinglePlayerScreenState();
}

class _SinglePlayerScreenState extends State<SinglePlayerScreen> {
  int _selectedMinutes = 3;
  final List<int> _modes = [3, 5, 10];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Single Player (vs Computer)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Select Game Mode:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            ToggleButtons(
              isSelected: _modes.map((m) => m == _selectedMinutes).toList(),
              onPressed: (index) {
                setState(() {
                  _selectedMinutes = _modes[index];
                });
              },
              children: _modes.map((m) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('$m min'),
              )).toList(),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChessBoardScreen(
                      modeMinutes: _selectedMinutes,
                      isSinglePlayer: true,
                    ),
                  ),
                );
              },
              child: const Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}

// Update MultiplayerLocalScreen to include game mode selection and navigation to ChessBoardScreen
class MultiplayerLocalScreen extends StatefulWidget {
  const MultiplayerLocalScreen({super.key});

  @override
  State<MultiplayerLocalScreen> createState() => _MultiplayerLocalScreenState();
}

class _MultiplayerLocalScreenState extends State<MultiplayerLocalScreen> {
  int _selectedMinutes = 3;
  final List<int> _modes = [3, 5, 10];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multiplayer (Same Device)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Select Game Mode:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            ToggleButtons(
              isSelected: _modes.map((m) => m == _selectedMinutes).toList(),
              onPressed: (index) {
                setState(() {
                  _selectedMinutes = _modes[index];
                });
              },
              children: _modes.map((m) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('$m min'),
              )).toList(),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChessBoardScreen(
                      modeMinutes: _selectedMinutes,
                      isSinglePlayer: false,
                    ),
                  ),
                );
              },
              child: const Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}

// Scaffold ChessBoardScreen
class ChessBoardScreen extends StatefulWidget {
  final int modeMinutes;
  final bool isSinglePlayer;
  const ChessBoardScreen({super.key, required this.modeMinutes, required this.isSinglePlayer});

  @override
  State<ChessBoardScreen> createState() => _ChessBoardScreenState();
}

class _ChessBoardScreenState extends State<ChessBoardScreen> {
  late ChessBoardController _controller;
  late chess_lib.Chess _chess;
  late int _whiteTime;
  late int _blackTime;
  late bool _isWhiteTurn;
  late bool _gameOver;
  String _result = '';

  @override
  void initState() {
    super.initState();
    _controller = ChessBoardController();
    _chess = chess_lib.Chess();
    _whiteTime = widget.modeMinutes * 60;
    _blackTime = widget.modeMinutes * 60;
    _isWhiteTurn = true;
    _gameOver = false;
    _startTimer();
  }

  void _startTimer() {
    Future.doWhile(() async {
      if (_gameOver) return false;
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        if (_isWhiteTurn) {
          _whiteTime = (_whiteTime > 0) ? _whiteTime - 1 : 0;
        } else {
          _blackTime = (_blackTime > 0) ? _blackTime - 1 : 0;
        }
        if (_whiteTime == 0 || _blackTime == 0) {
          _gameOver = true;
          _result = _whiteTime == 0 ? 'Black wins on time!' : 'White wins on time!';
        }
      });
      return !_gameOver;
    });
  }

  void _onMove(String move) {
    setState(() {
      _isWhiteTurn = !_isWhiteTurn;
      _chess.move(_controller.getLastMove()!);
      if (_chess.in_checkmate) {
        _gameOver = true;
        _result = _isWhiteTurn ? 'Black wins by checkmate!' : 'White wins by checkmate!';
      } else if (_chess.in_stalemate || _chess.in_draw) {
        _gameOver = true;
        _result = 'Draw!';
      }
    });
    if (widget.isSinglePlayer && !_gameOver && !_isWhiteTurn) {
      _makeAIMove();
    }
  }

  void _makeAIMove() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final moves = _chess.generate_moves();
    if (moves.isNotEmpty) {
      moves.shuffle();
      _chess.move(moves.first);
      _controller.makeMove(moves.first.san);
      setState(() {
        _isWhiteTurn = !_isWhiteTurn;
        if (_chess.in_checkmate) {
          _gameOver = true;
          _result = 'Black wins by checkmate!';
        } else if (_chess.in_stalemate || _chess.in_draw) {
          _gameOver = true;
          _result = 'Draw!';
        }
      });
    }
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.isSinglePlayer ? 'Single Player' : 'Multiplayer'} - ${widget.modeMinutes} min'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text('White', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(_formatTime(_whiteTime)),
                ],
              ),
              Column(
                children: [
                  const Text('Black', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(_formatTime(_blackTime)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ChessBoard(
            controller: _controller,
            boardColor: BoardColor.brown,
            arrows: [],
            onMove: _onMove,
            enableUserMoves: !_gameOver,
          ),
          const SizedBox(height: 16),
          if (_gameOver)
            Text(_result, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}

class MultiplayerOnlineScreen extends StatelessWidget {
  const MultiplayerOnlineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multiplayer (Online)')),
      body: const Center(child: Text('Online Multiplayer Chess Coming Soon!')),
    );
  }
}

class GoogleSignInScreen extends StatelessWidget {
  const GoogleSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in with Google')),
      body: const Center(child: Text('Google Sign-In Coming Soon!')),
    );
  }
}
