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
  String _selectedColor = 'White';
  String _selectedDifficulty = 'Beginner';
  final List<String> _colors = ['White', 'Black'];
  final List<String> _difficulties = ['Beginner', 'Intermediate', 'Difficult'];

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
            const SizedBox(height: 24),
            const Text('Choose Your Color:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            ToggleButtons(
              isSelected: _colors.map((c) => c == _selectedColor).toList(),
              onPressed: (index) {
                setState(() {
                  _selectedColor = _colors[index];
                });
              },
              children: _colors.map((c) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(c),
              )).toList(),
            ),
            const SizedBox(height: 24),
            const Text('Select Difficulty:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            ToggleButtons(
              isSelected: _difficulties.map((d) => d == _selectedDifficulty).toList(),
              onPressed: (index) {
                setState(() {
                  _selectedDifficulty = _difficulties[index];
                });
              },
              children: _difficulties.map((d) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(d),
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
                      playerColor: _selectedColor,
                      difficulty: _selectedDifficulty,
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
  final String? playerColor;
  final String? difficulty;
  const ChessBoardScreen({super.key, required this.modeMinutes, required this.isSinglePlayer, this.playerColor, this.difficulty});

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
  late String _playerColor;
  late String _difficulty;
  List<chess_lib.Piece> _capturedWhite = [];
  List<chess_lib.Piece> _capturedBlack = [];
  String _checkMessage = '';

  @override
  void initState() {
    super.initState();
    _controller = ChessBoardController();
    _chess = chess_lib.Chess();
    _whiteTime = widget.modeMinutes * 60;
    _blackTime = widget.modeMinutes * 60;
    _isWhiteTurn = true;
    _gameOver = false;
    _playerColor = widget.playerColor ?? 'White';
    _difficulty = widget.difficulty ?? 'Beginner';
    _capturedWhite = [];
    _capturedBlack = [];
    _checkMessage = '';
    _startTimer();
    // If player chose Black, let AI play first
    if (widget.isSinglePlayer && _playerColor == 'Black') {
      Future.delayed(const Duration(milliseconds: 500), _makeAIMove);
    }
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

  void _onMove() {
    // Get the last move from the controller's game
    final moves = _controller.game.getHistory({'verbose': true});
    if (moves.isNotEmpty) {
      final lastMove = moves.last;
      // Update _chess model with the move
      _chess.move({
        'from': lastMove['from'],
        'to': lastMove['to'],
        'promotion': lastMove['promotion']
      });
      // Track captured pieces
      if (lastMove['captured'] != null) {
        final capturedPiece = chess_lib.Piece(
          _pieceTypeFromString(lastMove['captured']),
          lastMove['color'] == 'w' ? chess_lib.Color.BLACK : chess_lib.Color.WHITE,
        );
        if (lastMove['color'] == 'w') {
          _capturedBlack.add(capturedPiece);
        } else {
          _capturedWhite.add(capturedPiece);
        }
      }
    }
    setState(() {
      _isWhiteTurn = !_isWhiteTurn;
      _checkMessage = '';
      if (_chess.in_check) {
        _checkMessage = _isWhiteTurn ? 'White is in Check!' : 'Black is in Check!';
      }
      if (_chess.in_checkmate) {
        _gameOver = true;
        _result = _isWhiteTurn ? 'Black wins by checkmate!' : 'White wins by checkmate!';
      } else if (_chess.in_stalemate || _chess.in_draw) {
        _gameOver = true;
        _result = 'Draw!';
      }
    });
    // If single player and it's now the computer's turn, make AI move
    if (widget.isSinglePlayer && !_gameOver) {
      bool isPlayerTurn = (_playerColor == 'White' && _isWhiteTurn) || (_playerColor == 'Black' && !_isWhiteTurn);
      if (!isPlayerTurn) {
        _makeAIMove();
      }
    }
  }

  void _makeAIMove() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final moves = _chess.generate_moves();
    if (moves.isNotEmpty) {
      final move = _pickAIMove(moves);
      // Update both models
      _chess.move(move);
      _controller.makeMove(from: move.fromAlgebraic, to: move.toAlgebraic);
      // Track captured pieces
      if (move.captured != null) {
        final capturedPiece = chess_lib.Piece(move.captured!, _isWhiteTurn ? chess_lib.Color.BLACK : chess_lib.Color.WHITE);
        if (_isWhiteTurn) {
          _capturedBlack.add(capturedPiece);
        } else {
          _capturedWhite.add(capturedPiece);
        }
      }
      setState(() {
        _isWhiteTurn = !_isWhiteTurn;
        _checkMessage = '';
        if (_chess.in_check) {
          _checkMessage = _isWhiteTurn ? 'White is in Check!' : 'Black is in Check!';
        }
        if (_chess.in_checkmate) {
          _gameOver = true;
          _result = (_playerColor == 'White') ? 'Black wins by checkmate!' : 'White wins by checkmate!';
        } else if (_chess.in_stalemate || _chess.in_draw) {
          _gameOver = true;
          _result = 'Draw!';
        }
      });
    }
  }

  chess_lib.Move _pickAIMove(List moves) {
    if (_difficulty == 'Beginner') {
      moves.shuffle();
      return moves.first;
    } else if (_difficulty == 'Intermediate') {
      // Pick move with highest material gain
      int bestScore = -9999;
      chess_lib.Move? bestMove;
      for (var move in moves) {
        var score = _materialGain(move);
        if (score > bestScore) {
          bestScore = score;
          bestMove = move;
        }
      }
      return bestMove ?? moves.first;
    } else {
      // Difficult: simple minimax 1-ply (AI looks ahead one move)
      int bestScore = -9999;
      chess_lib.Move? bestMove;
      for (var move in moves) {
        _chess.move(move);
        int score = -_evaluateBoard();
        _chess.undo();
        if (score > bestScore) {
          bestScore = score;
          bestMove = move;
        }
      }
      return bestMove ?? moves.first;
    }
  }

  int _materialGain(chess_lib.Move move) {
    // Assign values: pawn=1, knight/bishop=3, rook=5, queen=9
    if (move.captured == null) return 0;
    switch (move.captured.toString()) {
      case 'p': return 1;
      case 'n':
      case 'b': return 3;
      case 'r': return 5;
      case 'q': return 9;
      default: return 0;
    }
  }

  int _evaluateBoard() {
    // Simple material evaluation
    int score = 0;
    for (var row in _chess.board) {
      if (row == null) continue;
      switch (row.type.toString()) {
        case 'p': score += (row.color == chess_lib.Color.WHITE) ? 1 : -1; break;
        case 'n':
        case 'b': score += (row.color == chess_lib.Color.WHITE) ? 3 : -3; break;
        case 'r': score += (row.color == chess_lib.Color.WHITE) ? 5 : -5; break;
        case 'q': score += (row.color == chess_lib.Color.WHITE) ? 9 : -9; break;
        case 'k': break;
      }
    }
    return (_playerColor == 'White') ? score : -score;
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
          // Captured pieces display
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('White captured: '),
              ..._capturedWhite.map((p) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(_pieceSymbol(p)),
              )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Black captured: '),
              ..._capturedBlack.map((p) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(_pieceSymbol(p)),
              )),
            ],
          ),
          const SizedBox(height: 8),
          if (_checkMessage.isNotEmpty)
            Text(_checkMessage, style: const TextStyle(fontSize: 18, color: Colors.orange, fontWeight: FontWeight.bold)),
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

  String _pieceSymbol(chess_lib.Piece p) {
    switch (p.type.toString()) {
      case 'p': return p.color == chess_lib.Color.WHITE ? '♙' : '♟';
      case 'n': return p.color == chess_lib.Color.WHITE ? '♘' : '♞';
      case 'b': return p.color == chess_lib.Color.WHITE ? '♗' : '♝';
      case 'r': return p.color == chess_lib.Color.WHITE ? '♖' : '♜';
      case 'q': return p.color == chess_lib.Color.WHITE ? '♕' : '♛';
      case 'k': return p.color == chess_lib.Color.WHITE ? '♔' : '♚';
      default: return '';
    }
  }

  chess_lib.PieceType _pieceTypeFromString(String s) {
    switch (s) {
      case 'p': return chess_lib.PieceType.PAWN;
      case 'n': return chess_lib.PieceType.KNIGHT;
      case 'b': return chess_lib.PieceType.BISHOP;
      case 'r': return chess_lib.PieceType.ROOK;
      case 'q': return chess_lib.PieceType.QUEEN;
      case 'k': return chess_lib.PieceType.KING;
      default: throw Exception('Unknown piece type: $s');
    }
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
