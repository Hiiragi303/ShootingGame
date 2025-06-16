// プレイヤーや敵の船クラス
public abstract class Ship {
  protected float x,y;  // 現在座標
  protected int radius;  // 半径
  protected Coordinate c1,c2,c3;  //　座標クラス
  protected int size;  // サイズ
  protected float speed;  //　進む速さ
  protected int life;  //　体力
  protected boolean isDead; boolean isDeadByWall;  // 体力が無くなったか、壁にぶつかったか
  protected Gun gun;  // 銃
  protected int r,g,b;  // 色
  protected int type;  // 種類: プレイヤーか敵か
  
  public Ship(float x, float y) {
    this.x = x;
    this.y = y;
    isDead = false;
  }
  
  public boolean set() {
    move();
    renewCoordinate();
    if (life <= 0) isDead = true;
    return isDead;
  }
  
  public void view() {
    fill(r,g,b);
    noStroke();
    triangle(c1.getX(),c1.getY(),c2.getX(),c2.getY(),c3.getX(),c3.getY());
    if (gun != null) gun.view();
    viewLife();
  }
  
  public void viewLife() {
    fill(r,100,b);
    textSize(15);
    text(life,x,y+15);
    noStroke();
    rect(c1.getX(),c1.getY()-6,type*life/5,5);
  }
  
  // getter
  public float getX() {return x;}
  public float getY() {return y;}
  public int getR() {return radius;}
  public int getLife() {return life;}
  public boolean getIsDead() {return isDead;}
  public boolean getIsDeadByWall() {return isDeadByWall;}
  
  // setter
  public void setLife(int life) {this.life = life;}
  
  
  // abstract methods
  public abstract void move();
  public abstract void renewCoordinate();
}
