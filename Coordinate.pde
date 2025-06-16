// 座標クラス
public class Coordinate {
  private float x;
  private float y;
  
  public Coordinate(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  // 座標の更新
  public void renew(float x, float y) {this.x=x; this.y=y;}
  public float getX() {return x;}
  public float getY() {return y;}
}
