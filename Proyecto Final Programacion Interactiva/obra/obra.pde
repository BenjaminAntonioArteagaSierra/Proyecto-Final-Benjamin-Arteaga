//Clases
PImage img;
Sol soles;
Piso mo;
Mont a;
Consum is;

//Biblioteca pd
import oscP5.*;
import netP5.*;
OscP5 oscP5;

//IP
NetAddress myRemoteLocation;

//Variables
color c= color (255,255,0); 
color d= color (255,0,0); 
color s= color (0,0,255); 
color in = color(0, 0, 0);

void setup() {
  size(500,500);
  //puerto a escuchar
  oscP5 = new OscP5(this,12001);
  

//Dirección
  myRemoteLocation = new NetAddress("10.70.56.53",12001);
  

//Llamar a las clases
soles= new Sol();
mo = new Piso();
a = new Mont();
is = new Consum();

//imagen
img = loadImage ("img.png");
}

void draw() {
  background(in);  

pushMatrix();
soles.Dibujar();
popMatrix();

mo.Dib ();

pushMatrix();
a.Dibujar ();
popMatrix();

is.Dibujar ();

image (img, 290, 130, 300,400);
}


void mousePressed() {
  /* create a new osc message object */
  OscMessage myMessage = new OscMessage("/mouseX");
  myMessage.add(mouseX);/* add a string to the osc message */
  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 
}


//Recibe la función al puerto
void oscEvent(OscMessage theOscMessage) {  
  //si el mensaje está etiquetado como "/x"
  if (theOscMessage.checkAddrPattern("/x") == true) {
    //asigna el valor entero a la variable x
    c = theOscMessage.get(0).intValue();
    c= color (random (255), random (255), random (155)); 
    //filtro
   // img.filter(THRESHOLD, random (0.1,.5));
    }
    
     if (theOscMessage.checkAddrPattern("/d") == true) {
    d = theOscMessage.get(0).intValue();
    d= color (random (255), 255, random (155)); 
    img.filter(INVERT);
    }

  if (theOscMessage.checkAddrPattern("/s") == true) {
   s = theOscMessage.get(0).intValue();
    s= color (random (200), random (200), random (255));   //200
  }

  
  if (theOscMessage.checkAddrPattern("/in") == true) {
    //asigna el valor entero a la variable x
    in = theOscMessage.get(0).intValue();
    in= color (random(0,100),0,0);
    
  }
  println("### received an osc message. with address pattern "+theOscMessage.addrPattern());
}
