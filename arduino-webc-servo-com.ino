#include <Servo.h>


int SERVO_PIN_Y = 6;
int SERVO_PIN_X = 7;

Servo  X_S;
Servo  Y_S;

int x_pos = 90;
int y_pos = 90;

int speed_default = 50;
int angleShift_default = 1;

void setup() {
  X_S.attach(SERVO_PIN_X);
  Y_S.attach(SERVO_PIN_Y);
  X_S.write(x_pos);
  Y_S.write(y_pos);

  Serial.begin(9600);
  Serial.println("INIT");
}
// X+5Y+5
// X-5Y-5
// X=5Y=5


const char op_add = '+';
const char op_substract = '-';
const char op_moveTo = '=';

boolean operationPermitted(char op) {
  return op == op_add || op == op_substract || op == op_moveTo;
}

int newPosAfterOP(int currPos, char op, int newValue){
  int result = currPos;

  switch (op) {
    case op_add:
      result =  currPos + newValue;
      break;
    case op_moveTo:
       result =  newValue;
      break;
    case op_substract:
      result = currPos - newValue;
      break;
  }

  result = result > 180 ? 180 : result < 0 ? 0 : result;
  return result;
}

void turnToPos(Servo serva, int newPos, int currPos, int speedPerAngleShift, String logAtFinish) {
  int angleShift = 1;
  while (currPos != newPos) {

    if (currPos > newPos){
      currPos -= angleShift;
    } else if (currPos < newPos){
      currPos += angleShift;
    }
    
    serva.write(currPos);
    delay(speedPerAngleShift);
  }
  Serial.println(logAtFinish);
}

void serialCommandToMove(Servo serva, char operation, int newValue, int currPos,String logAtFinish) {
      turnToPos(serva, newPosAfterOP(currPos,operation,newValue), currPos, speed_default,logAtFinish);
}


void loop() {
  if (Serial.available() > 0) {
    // read the incoming byte:
    String txt = Serial.readString();

    int ypos = txt.indexOf("Y");
    int xpos = txt.indexOf("X");

    if (xpos == -1 || ypos == -1 || xpos > ypos) {
      Serial.print("Issue with Positions. X: ");
      Serial.print(xpos);
      Serial.print("Y");
      Serial.print(ypos);
      Serial.println(".");

    } else {
      //OK

      char x_moveType = txt.charAt(xpos + 1);
      char y_moveType = txt.charAt(ypos + 1);

      if (!operationPermitted(x_moveType) || !operationPermitted(y_moveType)) {
        Serial.print("One of operations not permitted X");
        Serial.print(x_moveType);
        Serial.print("Y");
        Serial.print(y_moveType);
        Serial.println(".");

      } else {
        String x_str = txt.substring(xpos + 2, ypos);
        String y_str = txt.substring(ypos + 2);
        int newX = x_str.toInt();
        int newY = y_str.toInt();

        Serial.println("WILL move");
        
        serialCommandToMove(X_S, x_moveType, newX, x_pos,"X Moved");
        x_pos =  newPosAfterOP(x_pos,x_moveType,newX);
        serialCommandToMove(Y_S, y_moveType, newY, y_pos,"Y Moved");
        y_pos =  newPosAfterOP(y_pos,y_moveType,newY);

        Serial.print("DONE Movement.Current positions: X");
        Serial.print(x_pos);
        Serial.print(" Y");
        Serial.print(y_pos);
        Serial.println(".");
      }//op found
    }// pos found
  } // serial read
}





