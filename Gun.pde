public class Gun {
  protected ArrayList<Bullet> bullets;
  protected int count;
  protected int type;
  protected int coolTime;
  protected int numOfBullets;
  protected int bulletSize;
  protected int bulletSpeed;
  protected int bulletLife;
  protected float targetX, targetY;
  protected float damage;
  
  public Gun(int type, int numOfBullets, int bulletSize, int bulletSpeed, int bulletLife, float damage ,int coolTime) {
    bullets = new ArrayList<Bullet>(numOfBullets);
    count = coolTime;
    this.type = type;
    this.numOfBullets = numOfBullets;
    this.bulletSize = bulletSize;
    this.bulletSpeed = bulletSpeed;
    this.bulletLife = bulletLife;
    this.damage = damage;
    this.coolTime = coolTime;
  }
  
  public void set(Coordinate c, Ship ship) {
    generateBullets(c);
    if (count != coolTime) count++;
    for (Bullet bullet : bullets) {
      bullet.set(ship);
    }
    delete();
  }
  
  public void view() {
    for (Bullet bullet : bullets) {
      bullet.view();
    }
  }
  
  public void generateBullets(Coordinate c) {
    if ((bullets.size() == numOfBullets) || (count != coolTime)) return;
    Bullet bullet;
    if (type == 1) {
      bullet = new Bullet(type, c.getX(), c.getY(), mouseX, mouseY, bulletSize, bulletSpeed, bulletLife, damage);
    } else if (type == -1) {
      bullet = new Bullet(type, c.getX(), c.getY(), targetX, targetY, bulletSize/2, bulletSpeed*7/8, bulletLife*6/5, 1);
    } else return;
    if (!bullet.getJudge()) {
      bullet = null;
      count = coolTime;
    } else {
      bullets.add(bullet);
      count = 0;
    }
  }
  
  public void delete() {
    bullets.removeIf(b -> b.getIsDead());
  }
  
  public void setTargetCoordinate(float x, float y) {
    targetX = x; targetY = y;
  }

}
