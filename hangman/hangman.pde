import javax.swing.JOptionPane;
/* hangman game for fun
made by Cody Wallbridge
*/

final int STEM_HEIGHT = 150, HANGER = 30;
final int BOTTOM_LINE = 120, TOP_LINE = 50;
String word; boolean crashed = false;
char[] wordLetters; char[] wrongGuesses = new char[26];
boolean[] lettersGuessed;
int wrongGuessesSize = 0;

//hanger variables
float BOTTOM_LEFT; float BOTTOM_RIGHT; float BOTTOM_Y;
float STEM_TOP; float STEM_BOTTOM; float STEM_X; float TOP_LEFT; float TOP_RIGHT;
float TOP_Y; float HANGER_TOP; float HANGER_BOTTOM; float HANGER_X;

//letter variables
float letterWidth; float space; float totalLetterSpace;float totalLetterGap;
float lettersPerSide; float bottomGap;
//man variables
float ARM_LENGTH; float LEG_LENGTH; float HEAD_DIAM; float BODY_LENGTH; float HEAD_X;
float HEAD_Y; float BODY_TOP; float BODY_BOTTOM; float BODY_X; float ARMS_MIDDLE_X;
float ARMS_MIDDLE_Y; float RIGHT_ARM_X; float RIGHT_ARM_Y; float LEFT_ARM_X; float LEFT_ARM_Y;
float LEG_TOP_X; float LEG_TOP_Y; float LEFT_LEG_X; float LEFT_LEG_Y; float RIGHT_LEG_X;
float RIGHT_LEG_Y; float LEFT_EYE_X; float LEFT_EYE_Y;
float RIGHT_EYE_X; float RIGHT_EYE_Y; float EYE_DIAM; float MOUTH_LEFT; float MOUTH_RIGHT; float MOUTH_Y;

void setup(){
  size(500,500);
  drawHanger();
  getWord();
  wordLines();
}//setup

void draw(){
  if(!crashed){
  background(255);
  drawHanger();
  wordLines();
  drawLetters();
  drawMan();
  wrongGuessesBox();
  if(crashed)
    showGameOverMessage();
  }//if not crashed
}//draw

void wrongGuessesBox(){
  textSize(25);
  fill(0);
  for(int i=0;i<wrongGuessesSize;i++){
  text(wrongGuesses[i],
  (width/10)+((width/10)*i),50);
  }//for
}//wrong guesses box

void showGameOverMessage(){
  fill(0);
  textSize(100);
  textAlign(CENTER,CENTER);
  text("Game Over!",width/2,height/2);
}//game over message

void drawMan(){
ARM_LENGTH = HANGER; LEG_LENGTH = HANGER*1.25; HEAD_DIAM = HANGER; BODY_LENGTH = STEM_HEIGHT-HANGER-75;
HEAD_X = HANGER_X; HEAD_Y = HANGER_BOTTOM+(HEAD_DIAM/2); BODY_TOP = HEAD_Y+(HEAD_DIAM/2);
BODY_BOTTOM = BODY_TOP+BODY_LENGTH; BODY_X = HANGER_X; ARMS_MIDDLE_X = HANGER_X;
ARMS_MIDDLE_Y = BODY_TOP+(BODY_LENGTH/3); 

RIGHT_ARM_X = ARMS_MIDDLE_X+ARM_LENGTH*cos(HALF_PI/2);
RIGHT_ARM_Y = ARMS_MIDDLE_Y-ARM_LENGTH*sin(HALF_PI/2); 
LEFT_ARM_X =  ARMS_MIDDLE_X+ARM_LENGTH*cos(PI-(HALF_PI/2));
LEFT_ARM_Y =  ARMS_MIDDLE_Y-ARM_LENGTH*sin(PI-(HALF_PI/2)); 

LEG_TOP_X = HANGER_X;
LEG_TOP_Y = BODY_BOTTOM; LEFT_LEG_X = LEG_TOP_X+LEG_LENGTH*cos(PI+(HALF_PI/2)); LEFT_LEG_Y = LEG_TOP_Y-LEG_LENGTH*sin(PI+(HALF_PI/2));
RIGHT_LEG_X = LEG_TOP_X+LEG_LENGTH*cos(TWO_PI-(HALF_PI/2)); RIGHT_LEG_Y = LEG_TOP_Y-LEG_LENGTH*sin(TWO_PI-(HALF_PI/2));
LEFT_EYE_X = HEAD_X-(HEAD_DIAM/3); LEFT_EYE_Y = HEAD_Y-(HEAD_DIAM/5);
RIGHT_EYE_X = HEAD_X+(HEAD_DIAM/3); RIGHT_EYE_Y = HEAD_Y-(HEAD_DIAM/5);
EYE_DIAM = HEAD_DIAM/4; MOUTH_LEFT = HEAD_X-(HEAD_DIAM/3);
MOUTH_RIGHT = HEAD_X+(HEAD_DIAM/3); MOUTH_Y = HEAD_Y+(HEAD_DIAM/5);

  if(wrongGuessesSize >= 1){
    stroke(0);
    fill(255);
    ellipse(HEAD_X,HEAD_Y,HEAD_DIAM,HEAD_DIAM);
  }//if 1 wrong guess draw head
  if(wrongGuessesSize >= 2){
    stroke(0);
    fill(0);
    line(BODY_X,BODY_TOP,BODY_X,BODY_BOTTOM);
  }//if 2 wrong guess draw body
  
  if(wrongGuessesSize >= 3){
    stroke(0);
    fill(0);
    line(ARMS_MIDDLE_X,ARMS_MIDDLE_Y,RIGHT_ARM_X,RIGHT_ARM_Y);
  }//if 3 wrong guess draw left arm
  
  if(wrongGuessesSize >= 4){
    stroke(0);
    fill(0);
    line(ARMS_MIDDLE_X,ARMS_MIDDLE_Y,LEFT_ARM_X,LEFT_ARM_Y);
  }//if 4 wrong guess draw right arm
  
  if(wrongGuessesSize >= 5){
    stroke(0);
    fill(0);
    line(LEG_TOP_X,LEG_TOP_Y,LEFT_LEG_X,LEFT_LEG_Y);
  }//if 5 wrong guess draw left leg
  
  if(wrongGuessesSize >= 6){
    stroke(0);
    fill(0);
    line(LEG_TOP_X,LEG_TOP_Y,RIGHT_LEG_X,RIGHT_LEG_Y);
  }//if 6 wrong guess draw right leg
  
  if(wrongGuessesSize >= 7){
    stroke(0);
    fill(255);
    ellipse(LEFT_EYE_X,LEFT_EYE_Y,EYE_DIAM,EYE_DIAM);
  }//if 7 wrong guess draw left eye
  
  if(wrongGuessesSize >= 8){
    stroke(0);
    fill(255);
    ellipse(RIGHT_EYE_X,RIGHT_EYE_Y,EYE_DIAM,EYE_DIAM);
  }//if 8 wrong guess draw right eye
  
  if(wrongGuessesSize >= 9){
    stroke(0);
    fill(0);
    line(MOUTH_LEFT,MOUTH_Y,MOUTH_RIGHT,MOUTH_Y);
    crashed = true;
  }//if 9 wrong guess draw mouth and say game over
  
}//draw man

void keyPressed(){
  boolean turnSuccess = false;
  char guess = key;
  for(int i = 0; i<word.length(); i++){
    if(guess==wordLetters[i]){
      lettersGuessed[i] = true;
      turnSuccess = true;
    }
  }//for
  if(turnSuccess==false){
    wrongGuesses[wrongGuessesSize] = key;
    wrongGuessesSize++;
  }//if
}//key pressed

void drawLetters(){
  for(int i = 0; i<word.length();i++){
    textSize(25);
    fill(0);
    if(lettersGuessed[i]){
    text(
    wordLetters[i],
    (width/2)-(lettersPerSide*totalLetterSpace)-(lettersPerSide-1*space)+(i*totalLetterGap)+(totalLetterSpace/3),
    height-(bottomGap/2)
    );
    }//if
  }//for
}//draw letters

//draws one line for each character in the string Word
void wordLines(){
  for(int i = 0; i<word.length();i++){
    letterWidth = textWidth(word)/word.length();
    space = letterWidth;
    totalLetterSpace = letterWidth+space;
    totalLetterGap = totalLetterSpace+space;
    lettersPerSide = word.length()/2;
    bottomGap = (height-BOTTOM_Y)/2;
    stroke(0);
    line(  (width/2)  -  (lettersPerSide*totalLetterSpace) - (lettersPerSide-1*space) +  (i*totalLetterGap)  ,
    height-(bottomGap/2),
    (width/2)  -  (lettersPerSide*totalLetterSpace) - (lettersPerSide-1*space) + (i*totalLetterGap) +totalLetterSpace,
    height-(bottomGap/2)
    );
  }//for
}//word lines

//draws hanger for man to hang from
void drawHanger(){
//hanger variables
  BOTTOM_LEFT = width/2-(BOTTOM_LINE/2);
  BOTTOM_RIGHT = width/2+(BOTTOM_LINE/2);
  BOTTOM_Y = height/2+(STEM_HEIGHT/2);
  STEM_TOP = height/2-(STEM_HEIGHT/2);
  STEM_BOTTOM = height/2+(STEM_HEIGHT/2);
  STEM_X = width/2;
  TOP_LEFT = width/2-TOP_LINE;
  TOP_RIGHT = width/2;
  TOP_Y = height/2-(STEM_HEIGHT/2);
  HANGER_TOP = (height/2)-(STEM_HEIGHT/2);
  HANGER_BOTTOM = (height/2)-(STEM_HEIGHT/2)+HANGER;
  HANGER_X = width/2-TOP_LINE;
  stroke(0);
  line(STEM_X,STEM_TOP,STEM_X,STEM_BOTTOM);//stem
  line(BOTTOM_LEFT,BOTTOM_Y,BOTTOM_RIGHT,BOTTOM_Y);//bottom line
  line(TOP_LEFT,TOP_Y,TOP_RIGHT,TOP_Y);//top out
  line(HANGER_X,HANGER_TOP,HANGER_X,HANGER_BOTTOM);//hanger
}//draw hanger

//gets the word from a player
void getWord(){
  word = JOptionPane.showInputDialog("What word would you like to play with?");
  lettersGuessed = new boolean[word.length()];
  wordLetters = new char[word.length()];
  for(int i = 0; i<word.length(); i++){ //<>//
    lettersGuessed[i] = false;
    wordLetters[i] = word.charAt(i);
  }//for
}//get word
