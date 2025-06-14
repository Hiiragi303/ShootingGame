public class Bullet {
  private int type;
  private float x, y, targetX, targetY;
  private float deltaX, deltaY;
  private double theta;
  private int size;
  private int speed;
  private int life;
  private boolean isDead;
  private float damage;
  private boolean judge;
  private CollisionCheck frameCC;
  private CollisionCheck playerCC;
  private int r, g, b;
  


  public Bullet(int type, float x, float y, float targetX, float targetY, int size, int speed, int life, float damage) {
    this.type = type;
    this.x = x; this.y=y;
    this.targetX = targetX; this.targetY = targetY;
    this.size = size; this.speed = speed; this.life = life; this.damage = damage;
    isDead = false;
    
    deltaX = targetX-x; deltaY = targetY-y;
    if (deltaX==0) judge=false;
    if (type*deltaX<0) judge=false;
    else judge = true;
    theta = Math.atan2(deltaY, deltaX);
    
    if (type == 1) {
      r=100; g=200; b=255;
    }
    if (type == -1) {
      r=255; g=100; b=0;
    }
    
    frameCC = new CollisionCheck(0,height,width,0);
  }
  
  public boolean set(Ship player) {
    if ((type==-1) && (player != null)) {
      playerCC = new CollisionCheck(player.getX(),player.getY(),player.getR());
    }
    collisionCheck();
    move();
    return isDead;
  }

  public void view() {
    noStroke();
    fill(r, g, b);
    ellipse(x, y, size, size);
  }

  public void move() {
    if (!frameCC.inRect(x, y)) isDead = true;
    x += (speed*Math.cos(theta));
    y += (speed*Math.sin(theta));
  }

  public boolean collisionCheck() {
    CollisionCheck cc;
    if (type==1) {
      for (Enemy enemy : em.getList()) {
        cc = new CollisionCheck(enemy.getX(), enemy.getY(), enemy.getR());
        if (cc.inCircle(x,y,size/4)) {
          enemy.setLife((int)(enemy.getLife()-damage));
          life = 0;
          isDead = true;
          return true;
        }
      }
      cc = null;
    } else if (type==-1) {
      if (playerCC.inCircle(x,y,size/4)) {
        player.setLife((int)(player.getLife()-damage));
        life=0;
        isDead = true;
        return true;
      }
    }
    return false;
  }

  // getter
  public int getType() {return type;}
  public boolean getJudge() {return judge;}
  public int getLife() {return life;}
  public boolean getIsDead() {return isDead;}
  
}
