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
AppState state;
Keyboard keyboard = new Keyboard();
void main() {
  final CanvasRenderingContext2D context =
      (querySelector("#canvas") as CanvasElement).context2D;
  context.fillStyle="blue";
  context.fillRect(0,0, 500, 600);
  ImageLoader.loadImages().then((yolo) {
    context.drawImage(ImageLoader.images['target.png'], 200, 200);
    window.animationFrame.then(gameLoop);
  });

}

num lastTime = 0;
void gameLoop(num time) {
  num delta = time - lastTime;
  lastTime = time;
  
  
  window.animationFrame.then(gameLoop);
}


