//import 
import ddf.minim.*;
import ddf.minim.signals.*;

Minim minim;
AudioPlayer ap;
AudioOutput out;
SineWave wave;

Ship player;
EnemyMaker em;
boolean upPressed = false; boolean downPressed = false;
boolean rightPressed = false; boolean leftPressed = false;
boolean enterPressed = false; boolean rPressed = false;
boolean qPressed = true; boolean tPressed = false;
boolean clear = false;

int quota;

public void setup() {
 size(880,500);
 frameRate(80);
 background(0);
 
 minim = new Minim(this);
 ap = minim.loadFile("explosion.mp3");
 out = minim.getLineOut(Minim.STEREO);
 wave = new SineWave(0, 1.0, out.sampleRate());
 out.addSignal(wave);

 
 player = new Player();
 em = new EnemyMaker();
 quota = 10;
}
  
public void draw() {
  background(0);
  tint(102);
  
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
  if (player.getIsDead()) {
    ap.play();
    player = null;
    return;
  }
  em.set(player);
  if (em.count >= quota) clear = true;
  player.view();
  em.view();
  showCount();
}
  
public void end() {
  background(0);
  fill(255,0,0);
  textSize(50);
  text("Game over", width/3,height/2);
  fill(255,100,100);
  text("Press R to reset", width/3-50, height/2+35);
  if (rPressed) {
    player = new Player();
    em = new EnemyMaker();
  }
}

public void showCount() {
  fill(255);
  textSize(30);
  text(em.count + " beated", 15,30);
}

public void gg() {
  background(255);
  fill(0);
  textSize(50);
  text("Clear!", width/2-100,height/2);
  fill(0,0,255);
  text("Press R to reset", width/3-50, height/2+35);
  if (rPressed) {
    player = new Player();
    em = new EnemyMaker();
    clear = false;
  }
}

public void setting() {
  if (tPressed) {
    background(255);
    fill(0);
    textSize(30);
    text("*WASD to move", width/3,height/3);
    text("*Enter to change gun", width/3,height/3+50);
    text("*Q to back to start", width/3,height/3+100);
    text("*T to back to menu", width/3,height/3+200);
  } else {
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

void stop() {
  out.close();
  minim.stop();
  super.stop();
}
