public class CollisionCheck {
  private int up, down, right, left;  // for rectangle
  private float x,y;  // for circle
  private int r;  // for circle
  private float deltaX;
  private float deltaY;
  private float deltaR;
  
  // constructor for rectangle
  public CollisionCheck(int up, int down, int right, int left) {
    this.up = up; this.down = down; this.right = right; this.left = left;
  }
  // constructor for circle
  public CollisionCheck(float x,float y,int r) {
    this.x = x; this.y = y; this.r = r;
  }
  
  // collision check for rectangle
  public boolean inRect(float x, float y) {
    if (x>=left && x<=right && y>= up && y<= down) return true;
    else return false;
  }
  
  // collision check for circle
  public boolean inCircle(float opponentX, float opponentY, int opponentR) {
    deltaX = opponentX-x;
    deltaY = opponentY-y;
    deltaR = opponentR+r;
    if (deltaX*deltaX * deltaY*deltaY <= deltaR*deltaR) {
      return true;
    }
    else return false;
  }
  
  /*
  public void setCoordinate(float x, float y) {
    this.x=x; this.y=y;
  }
  */
}
