int outPin = 11;
int val; 
int arpPoison = 0;
int red;

void setup() {
  // put your setup code here, to run once:
  pinMode(outPin, OUTPUT);
  Serial.begin(9600);
  Serial.flush (); 
}

void loop() {
  // put your main code here, to run repeatedly:
  if (Serial.available())
  {
    val = Serial.read();
    Serial.print(val);
    if (val == 'A')
    {
        arpPoison = 1; 
        for(red = 0; red <= 255; red+=5)
        {
          analogWrite(outPin, red);
          delay(30);
        }
        while (arpPoison == 1)
          {
            for(red = 255; red >= 25; red-=5)
            {
              analogWrite(outPin, red);
              delay(30);
            }
            for(red = 25; red <= 255; red+=5)
            {
              analogWrite(outPin, red);
              delay(30);
            }
            val = Serial.read();
            Serial.print(val);
            if (val == 'R')
            {
                arpPoison = 0;
                for(red = 255; red >= 0; red-=5)
            {
              analogWrite(outPin, red);
              delay(30);
            }
            }
          }
     }
  }
}
