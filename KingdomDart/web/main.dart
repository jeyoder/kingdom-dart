library Kingdom;
import 'dart:html';
import 'dart:math';
import 'dart:async';
part 'app_state.dart';
part 'in_game_state.dart';
part 'TileMap.dart';
part 'Unit.dart';
part 'WayPoint.dart';
part 'Order.dart';
part 'PlayerAsset.dart';
part 'Frame.dart';
part 'ImageLoader.dart';
part 'Keyboard.dart';
part 'MapLoader.dart';
part 'FileMapGenerator.dart';
part 'King.dart';
AppState state;
Keyboard keyboard = new Keyboard();
int width;
int height;
CanvasRenderingContext2D context;
void main() {
  context = (querySelector("#canvas") as CanvasElement).context2D;
  width = context.canvas.width;
  height = context.canvas.height;
  context.fillStyle="blue";
  context.fillRect(0,0, width, height);
  ImageLoader.loadImages().then((yolo) {
    context.drawImage(ImageLoader.images['target.png'], 200, 200);
    state = new InGameState(keyboard);
    window.animationFrame.then(gameLoop);
  });
}

num lastTime = 0;
void gameLoop(num time) {
  num delta = time - lastTime;
  lastTime = time;
  
  context.fillStyle="black";
  context.fillRect(0,0, width, height);
  
  state.render(context, delta);
  window.animationFrame.then(gameLoop);
}


