public abstract class Ship {
  protected float x,y;
  protected int radius;
  protected Coordinate c1,c2,c3;
  protected int size;
  protected float speed;
  protected int life;
  protected boolean isDead; boolean isDeadByWall;
  protected Gun gun;
  protected int r,g,b;
  protected int type;
  
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
