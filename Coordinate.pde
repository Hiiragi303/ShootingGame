public class Coordinate {
  private float x;
  private float y;
  
  public Coordinate(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public void renew(float x, float y) {this.x=x; this.y=y;}
  public float getX() {return x;}
  public float getY() {return y;}
}
