// 弾クラス
public class Bullet {
  private int type;  // 1: プレイヤー  -1: 敵
  private float x, y, targetX, targetY;  // x: 発射位置x  y: 発射位置y  targetX: 目的位置x  targetY: 目的位置y
  private float deltaX, deltaY;  // 差
  private double theta;  // 角度
  private int size;  // 弾のサイズ
  private int speed;  // 弾のスピード
  private int life;  // 弾のライフ
  private boolean isDead;  // 弾がなくなったか
  private float damage;  // ダメージ量
  private boolean judge;  // 当たったかどうか
  private CollisionCheck frameCC;  // フレームの衝突判定
  private CollisionCheck playerCC;  // プレイヤーの衝突判定
  private int r, g, b;  // 色
  

// コンストラクタ
  public Bullet(int type, float x, float y, float targetX, float targetY, int size, int speed, int life, float damage) {
    this.type = type;
    this.x = x; this.y=y;
    this.targetX = targetX; this.targetY = targetY;
    this.size = size; this.speed = speed; this.life = life; this.damage = damage;
    isDead = false;
    
    // 目標との誤差計算
    deltaX = targetX-x; deltaY = targetY-y;
    if (deltaX==0) judge=false;
    if (type*deltaX<0) judge=false;
    else judge = true;
    theta = Math.atan2(deltaY, deltaX);
    
    // カラー設定
    if (type == 1) {
      r=100; g=200; b=255;
    }
    if (type == -1) {
      r=255; g=100; b=0;
    }
    
    // フレームとの衝突判定を用意
    frameCC = new CollisionCheck(0,height,width,0);
  }
  
  public boolean set(Ship player) {
    // 種類がプレイヤーで存在する場合
    if ((type==-1) && (player != null)) {
      // プレイヤーとの衝突判定
      playerCC = new CollisionCheck(player.getX(),player.getY(),player.getR());
    }
    // 衝突判定を行う
    collisionCheck();
    // 移動する
    move();
    return isDead;
  }

  // 描画
  public void view() {
    noStroke();
    fill(r, g, b);
    ellipse(x, y, size, size);
  }
  
  // 移動
  public void move() {
    if (!frameCC.inRect(x, y)) isDead = true;
    x += (speed*Math.cos(theta));
    y += (speed*Math.sin(theta));
  }
  
  // 衝突判定
  public boolean collisionCheck() {
    CollisionCheck cc;
    // プレイヤーの弾の場合
    if (type==1) {
      // 敵との衝突判定
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
      // 敵の弾の場合、プレイヤーの当たるとライフを減らす
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
