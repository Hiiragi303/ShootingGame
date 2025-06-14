public class Enemy extends Ship {
  protected int type;
  protected AudioPlayer ap2;
  
  protected CollisionCheck cc;
  
  public Enemy(float x, float y, int size) {
    super(x,y);
    this.size = size;
    radius = size/4;
    c1 = new Coordinate(x+size,y-size/2);
    c2 = new Coordinate(x+size,y+size/2);
    c3 = new Coordinate(x-size,y);
    
    cc = new CollisionCheck(0,height,width+300,0);
    super.type=-1;
    ap2 = minim.loadFile("explosion2.mp3");
  }
  
  public boolean set(Ship player) {
    boolean retv = super.set();
    if (gun != null) gun.set(c3,player);
    if (isDead) ap2.play();
    return retv;
  }
  
  public void move() {
    if (!cc.inRect(c1.getX(), y)) isDeadByWall = true;
    x -= speed;
  }
  
  public void renewCoordinate() {
    c1.renew(x+size,y-size/2);
    c2.renew(x+size,y+size/2);
    c3.renew(x-size,y);
  }
  
  public void setTargetCoordinate(float x, float y) {
    if (gun != null) gun.setTargetCoordinate(x,y);
  }
}
