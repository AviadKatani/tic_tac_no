import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_no/game/bloc/game_bloc.dart';
import 'package:tic_tac_no/game/data/models/player.dart';
import 'package:tic_tac_no/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class PlayerColumn extends StatelessWidget {
  const PlayerColumn({this.player, this.isPlayerTurn});

  final Player player;
  final bool isPlayerTurn;

  @override
  Widget build(BuildContext context) {
    // Opacity to handle the overall player info opacity depending on if it's their turn
    return Opacity(
      opacity: isPlayerTurn ? 1.0 : 0.5,
      // Column to align contents vertically
      child: LayoutBuilder(
        builder: (context, constraints) {
          // print('Max Width: ${constraints.maxWidth}');
          // print('Max Height: ${constraints.maxHeight}');
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(
                flex: 1,
              ),
              // Player name with set height due to font size
              Text(
                player.name.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // Expanded so the shape is the thing that scales in size
              Flexible(
                flex: 3,
                // flex: constraints.maxHeight > 160 ? 2 : 3,
                child: Align(
                  alignment: Alignment.center,
                  // Aspect ratio of 1 because the shape has to be on a square canvas
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: FractionallySizedBox(
                      widthFactor: 0.65,
                      heightFactor: 0.65,
                      child: CustomPaint(
                        painter: player.symbol,
                      ),
                    ),
                  ),
                ),
              ),
              // Player turn info
              // Coloured bar if player and 'thinking...' if AI
              // This has a set height
              Opacity(
                opacity: isPlayerTurn ? 1.0 : 0.0,
                child: BlocBuilder<GameBloc, GameState>(
                  builder: (context, state) {
                    if (state is AIThinking) {
                      return Container(
                        height: 16,
                        child: Text(
                          LocaleKeys.game_thinking.tr(),
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 6.0),
                        child: FractionallySizedBox(
                          widthFactor: 0.65,
                          child: Container(
                            width: constraints.maxWidth,
                            height: 8,
                            color: player.color,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              Spacer(),
            ],
          );
        },
      ),
    );
  }
}
