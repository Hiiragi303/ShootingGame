// 敵生成クラス
public class EnemyMaker {
  ArrayList<Enemy> enemies;
  private int maxNum = 5;
  private int count;
  
  public EnemyMaker() {
    enemies = new ArrayList<>();
    create(1);
    count = 0;
    
  }
  
  // 敵生成
  public void create(int level) {
    switch (level) {
      case 1:
        int size = 15;
        float x = width - size;
        float y = random(size, height-size);
        enemies.add(new EnemyLv1(x,y,size));
        break;
       default:
         break;
    }
  }
  
  // 削除
  public void delete() {
    checkNum();
    enemies.removeIf(e -> e.getIsDeadByWall());
    enemies.removeIf(e -> e.getIsDead());
  }
  
  // 敵の数を数える
  public void checkNum() {
    for (Enemy enemy : enemies) {
      if (enemy.getIsDead()) count++;
    }
  }
  
  // 用意
  public void set(Ship player) {
    if (enemies.size() <= maxNum) {
      create(1);
    }
    setPlayerCoordinate(player.getX(), player.getY());
    for (Enemy enemy : enemies) {
      enemy.set(player);
    }
    delete();
  }
  
  // プレイヤーの座標をセット
  public void setPlayerCoordinate(float x, float y) {
    for (Enemy enemy : enemies) {
      enemy.setTargetCoordinate(x,y);
    }
  }
  
  // 描画
  public void view() {
    for (Enemy enemy : enemies) {
      enemy.view();
    }
  }
  
  // getter
  public ArrayList<Enemy> getList() {return enemies;}
}
