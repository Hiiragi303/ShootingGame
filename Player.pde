// プレイヤークラス
public class Player extends Ship {
  private CollisionCheck frameCC;  // フレームとの衝突判定用
  private Gun gun1;  // 銃1
  private Gun gun2;  // 銃2
  
  public Player() {
    super(width/8,height/2);
    life = 100;
    size = 10;
    radius = size/4;
    speed = 3;
    gun1 = new SimpleGun(1);
    gun2 = new Beam(1);
    gun = gun1;
    c1 = new Coordinate(x-size,y-size/2);
    c2 = new Coordinate(x-size,y+size/2);
    c3 = new Coordinate(x+size,y);
    r=0; g=0; b=255;
    frameCC = new CollisionCheck(0,height,width,0);
    type=1;
  }
  
  public boolean set() {
    boolean retv = super.set();
    changeGun();
    gun.set(c3,null);
    return retv;
  }

  // 移動
  public void move() {
    if (upPressed && frameCC.inRect(c1.getX(),c1.getY()-speed)) y -= speed;
    if (downPressed && frameCC.inRect(c2.getX(),c2.getY()+speed)) y += speed;
    if (rightPressed && frameCC.inRect(c3.getX()+speed,y)) x += speed;
    if (leftPressed && frameCC.inRect(c1.getX()-speed,y)) x -= speed;
  }
  
  // 座標を更新
  public void renewCoordinate() {
    c1.renew(x-size,y-size/2);
    c2.renew(x-size,y+size/2);
    c3.renew(x+size,y);
  }
  
  // 銃を変える
  public void changeGun() {
    if (enterPressed) {
      gun = gun2;
    } else {
      gun = gun1;
    }
  }
}
