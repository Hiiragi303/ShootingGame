//Minimライブラリのインポート(音用)
import ddf.minim.*;
import ddf.minim.signals.*;

Minim minim;
AudioPlayer ap;
AudioOutput out;
SineWave wave;

Ship player;
EnemyMaker em;

// キーの変数
boolean upPressed = false; boolean downPressed = false;
boolean rightPressed = false; boolean leftPressed = false;
boolean enterPressed = false; boolean rPressed = false;
boolean qPressed = true; boolean tPressed = false;

boolean clear = false;

// ノルマ
int quota;

// setup
public void setup() {
 size(880,500);
 frameRate(80);
 background(0);
 
 minim = new Minim(this);
 ap = minim.loadFile("explosion.mp3");
 out = minim.getLineOut(Minim.STEREO);
 wave = new SineWave(0, 1.0, out.sampleRate());
 out.addSignal(wave);

 // プレイヤーと敵を生成、ノルマは10
 player = new Player();
 em = new EnemyMaker();
 quota = 10;
}

// 描画する
public void draw() {
  background(0);
  tint(102);
  
  // Qが押された時、クリアしたとき、ゲームオーバーの時
  if (qPressed) {
    setting();
    return;
  } else if (clear) {
    player = null;
    em = null;
    gg();
    return;
  } else if (player == null) {
    em = null;
    end();
    return;
  }

  ap.pause();
  ap.rewind();
  player.set();
  //プレイヤーの体力がなくなった時
  if (player.getIsDead()) {
    ap.play();
    player = null;
    return;
  }
  em.set(player);
  // ノルマ達成したとき
  if (em.count >= quota) clear = true;
  
  player.view();  // プレイヤーを描画する
  em.view();  // 敵を描画する
  showCount();  // 撃破数を描画する
}
  
// 終了したら
public void end() {
  background(0);
  fill(255,0,0);
  textSize(50);
  text("Game over", width/3,height/2);
  fill(255,100,100);
  text("Press R to reset", width/3-50, height/2+35);
  // Rが押されたら
  if (rPressed) {
    player = new Player();
    em = new EnemyMaker();
  }
}

// 撃破数を描画する
public void showCount() {
  fill(255);
  textSize(30);
  text(em.count + " beated", 15,30);
}

// ゲームクリアしたとき
public void gg() {
  background(255);
  fill(0);
  textSize(50);
  text("Clear!", width/2-100,height/2);
  fill(0,0,255);
  text("Press R to reset", width/3-50, height/2+35);
  // Rが押されたら
  if (rPressed) {
    player = new Player();
    em = new EnemyMaker();
    clear = false;
  }
}

// (説明画面とメニュー画面)
public void setting() {
  // 説明画面
  if (tPressed) {
    background(255);
    fill(0);
    textSize(30);
    text("*WASD to move", width/3,height/3);
    text("*Enter to change gun", width/3,height/3+50);
    text("*Q to back to start", width/3,height/3+100);
    text("*T to back to menu", width/3,height/3+200);
  } else {
    // メニュー画面
    background(255);
    fill(0,80);
    textSize(50);
    text("Press Q to start", width/3,height/2);
    text("Press T to explain", width/3-20, height/2+50);
    if (qPressed) {
      player = new Player();
      em = new EnemyMaker();
     }
  }
}

// キーが押された時
void keyPressed() {
  if (key == 'w') upPressed = true;
  if (key == 's') downPressed = true;
  if (key == 'd') rightPressed = true;
  if (key == 'a') leftPressed = true;
  if (key == ENTER) {
    enterPressed = true;
    wave.setFreq(1000);
  }
  if (key == 'r') rPressed = true;
  if (key == 't') tPressed = !tPressed;
  if (key == 'q') qPressed = !qPressed;
}

// キーが話された時
void keyReleased() {
  if (key == 'w') upPressed = false;
  if (key == 's') downPressed = false;
  if (key == 'd') rightPressed = false;
  if (key == 'a') leftPressed = false;
  if (key == ENTER) {
    enterPressed = false;
    wave.setFreq(0);
  }
  if (key == 'r') rPressed = false;
}

// 停止
void stop() {
  out.close();
  minim.stop();
  super.stop();
}
