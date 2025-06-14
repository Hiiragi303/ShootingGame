public class EnemyLv1 extends Enemy {
  
  public EnemyLv1(float x, float y, int size) {
    super(x,y,size);
    life = 100;
    type = 1;
    speed = random(1,2);
    r = 255; g = 0; b = 100;
    gun = new SimpleGun(-1);
  }
}
