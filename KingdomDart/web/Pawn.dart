part of Kingdom;
class King extends Unit{
  King(int PlayerNumber, int TileX, int TileY) : super(PlayerNumber, TileX, TileY){
    myImagePlayerPrefix = "Pawn";
    tilesPerTurn = 2;
  }
}