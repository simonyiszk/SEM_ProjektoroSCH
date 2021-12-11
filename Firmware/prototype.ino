// Sample code for Spakfun Pro Micro

void setup()
{
  Serial1.begin(9600);
  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, HIGH);
  delay(1000);
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
}

void loop()
{
  Serial1.write("Hello SEM!");
  delay(1000);
  Serial1.write("Demo szoveg");
  delay(1000);
}
