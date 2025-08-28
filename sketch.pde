//about
// this simple sketch is a recreation / interpretation of a "still taken from the 1982 experimental film Le ravissement de Frank N. Stein by Swiss animator Georges Schwizgebel."
// a.k.a. the album artwork for "R Plus Seven" by Oneohtrix Point Never
// See More At: https://en.wikipedia.org/wiki/R_Plus_Seven#Artwork_and_design

// functions / concepts used related to chapter 3&4
// variables, types, setup(), draw(), system variables(width), translate(), random(), frameRate()

// declare colors
color darkGreen;
color lightGreen;
color lightestGreen;
color darkBlue;
color lightYellow;
color darkBrown;
color darkestBrown;

// Function to clamp coordinates within the trapezoidal floor bounds

PVector clampToFloor(float x, float y, float w, float h) {
  // Floor boundaries
  float minY = 450 - h/2;
  float maxY = 616.6- h/2 - 16.6; // Adjusted to keep the shape fully visible

  // Clamp y-coordinate
  float clampedY = constrain(y, minY, maxY);

  // Calculate valid x-range for the given y-coordinate
  // Left edge: from(-100, 616.6) to(150, 450) => slope = -0.6664
  // Right edge: from(450, 450) to(700, 616.6) => slope = 0.6664

  // Using the derived formulas:
  // For left edge: y - 450 = -0.6664(x - 150) => x =(550 - y) / 0.6664
  // For right edge: y - 450 = 0.6664(x - 450) => x =(y - 150) / 0.6664
  float slopeFactor = 0.6664;
  float minX =(550 - clampedY) / slopeFactor - w*2; //ensuring that it stays within the walls
  float maxX =(clampedY - 150) / slopeFactor + w*2;

  // Clamp x-coordinate
  float clampedX = constrain(x, minX, maxX);

  return new PVector(clampedX, clampedY);
}

void setup() {
  //set canvas size - about half the size of the source, this needs to be set first

  size(600, 600);
  frameRate(60);
  // setup colors - while not part of the weeks material, i read through the docs to save some time on manually inputting hex values each time
  // in the future it could be good to add some gradients to emphasize shadows
  darkGreen = #3A453E;
  lightGreen = #484D45;
  lightestGreen = #A0A887;
  darkBlue = #292B61;
  lightYellow = #EBD89F;
  darkBrown = #21170E;
  darkestBrown = #110B09;
}

void draw() {
  size(600, 600);  //pre calculation so that values can we used in subsequent draw steps

  PVector minOrbDim = new PVector(36, 100);
  PVector maxOrbDim = new PVector(56, 180);
  float vertDistToDoor = max(mouseY - width / 2, 0); // only care about the y dimension between the door and the orb since that matches our perspective
  //we need to constrain the orb dimensions so that it correctly scales to the perspective
  // the function was determined by calculating the slope given the known minimum and maximum dimensions
  // e.g.(180 - 100) /(56 - 36) = 4 => slope
  // then using point slope form to determine the corresponding width
  // using the known height which is scaled to the distance between the mouse and the door.(door is furthest point in the bg)
  // e.g. y - 100 = 4(x - 36) => x = y / 4 + 11
  PVector currOrbDim = new PVector(constrain(vertDistToDoor / 4 + 11, minOrbDim.x, maxOrbDim.x), constrain(vertDistToDoor, minOrbDim.y, maxOrbDim.y));

  //constrain the position of the orb to appear within the room
  PVector clampedPos = clampToFloor(mouseX, mouseY, currOrbDim.x, currOrbDim.y);
  //true cartesian distance between the orb and the door
  float distanceToDoor = dist(clampedPos.x, clampedPos.y, 300, 392);

  //room
  //floor
  fill(lightestGreen);
  quad(-100, 616.6, 150, 450, 450, 450, 700, 616.6);
  //shadow - need to draw before walls but after floor
  translate(clampedPos.x, clampedPos.y);
  fill(darkestBrown);
  // draw the shadow in proportion to the orb size
  ellipse(0, currOrbDim.y/2, currOrbDim.x, currOrbDim.y/10);
  translate(-clampedPos.x, -clampedPos.y);
  //backwall
  fill(darkGreen);
  stroke(darkBrown);
  strokeWeight(2);
  rect(150,0,300,450);
  //left wall
  fill(darkGreen);
  strokeWeight(2);
  quad(0, 0, 150, 0, 150, 450, 0, 550);
  //right wall
  fill(darkGreen);
  quad(450, 0, 600, 0, 600, 550, 450, 450);

  //door
  fill(darkestBrown);
  rect(270, 335, 60, 115);
  fill(lightGreen);
  strokeWeight(1);
  quad(325, 337, 325, 445, 330, 450, 330, 335);

  //window
  //the window color flickers blue more rapidly as you approach the door with the shape
  fill(random(min(distanceToDoor, 75),75), random(min(distanceToDoor, 75), 75), random(min(distanceToDoor*2, 255), 255));
  strokeWeight(2);
  quad(545, 270, 545, 440, 560, 445, 560, 265);
  fill(lightestGreen);
  quad(545, 440, 560, 445, 560, 475, 530, 455);
  fill(lightGreen);
  quad(545, 440, 530, 455, 530, 270, 545, 270);
  quad(530,270,545,270,560,265,560,257);

  //orb - in the original this is a rectangular prism
  translate(clampedPos.x, clampedPos.y);
  fill(lightYellow);
  ellipse(0, 0, currOrbDim.x, currOrbDim.y);
}
