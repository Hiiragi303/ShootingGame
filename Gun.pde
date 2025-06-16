// 銃クラス
public class Gun {
  protected ArrayList<Bullet> bullets;  // 弾の管理
  protected int count;  //　クールタイム用カウント
  protected int type;  // 種類
  protected int coolTime;  // クールタイム
  protected int numOfBullets;  // 弾丸数
  protected int bulletSize;  // 弾のサイズ
  protected int bulletSpeed;  // 弾のスピード
  protected int bulletLife;  // 弾のライフ
  protected float targetX, targetY;  // 目標座標
  protected float damage;  // ダメージ
  
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
  
  // 座標設定
  public void set(Coordinate c, Ship ship) {
    generateBullets(c);
    if (count != coolTime) count++;
    for (Bullet bullet : bullets) {
      bullet.set(ship);
    }
    delete();
  }
  
  // 描画
  public void view() {
    for (Bullet bullet : bullets) {
      bullet.view();
    }
  }
  
  // 弾を生成
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
  
  // 弾を削除
  public void delete() {
    bullets.removeIf(b -> b.getIsDead());
  }
  // 目標座標を設定
  public void setTargetCoordinate(float x, float y) {
    targetX = x; targetY = y;
  }

}
