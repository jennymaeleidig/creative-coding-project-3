//about
// this simple sketch is a recreation / interpretation of a "still taken from the 1982 experimental film Le ravissement de Frank N. Stein by Swiss animator Georges Schwizgebel."
// a.k.a. the album artwork for "R Plus Seven" by Oneohtrix Point Never
// See More At: https://en.wikipedia.org/wiki/R_Plus_Seven#Artwork_and_design
// functions used: fill(), stroke(), strokeWeight(), rect(), quad(), ellipse(), arc(), size(), and background()

//set canvas size - about half the size of the source, this needs to be set first
size(600, 600);
// setup colors - while not part of the weeks material, i read through the docs to save some time on manually inputting hex values each time
// in the future it could be good to add some gradients to emphasize shadows
color darkGreen = #3A453E;
color lightGreen = #484D45;
color lightestGreen = #A0A887;
color darkBlue = #292B61;
color lightYellow = #EBD89F;
color darkBrown = #21170E;
color darkestBrown = #110B09;
background(darkBlue); // set so that i can see when an object is not properly filling the background

//the sketch is separated into four logical parts, the room, the door, the window, and the shape / orb that occupies the room.

//room
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
//floor
fill(lightestGreen);
quad(-100, 616.6, 150, 450, 450, 450, 700, 616.6); //getting the floor was a bit tricky, I needed to extrapolate some points outside of the canvas and calculate the slope to ensure lines matched up

//door
fill(darkestBrown);
rect(270, 335, 60, 115);
fill(lightGreen);
strokeWeight(1);
quad(325, 337, 325, 445, 330, 450, 330, 335);

//window
fill(darkBlue);
strokeWeight(2);
quad(545, 270, 545, 440, 560, 445, 560, 265);
fill(lightestGreen);
quad(545, 440, 560, 445, 560, 475, 530, 455);
fill(lightGreen);
quad(545, 440, 530, 455, 530, 270, 545, 270);
quad(530,270,545,270,560,265,560,257);

//orb - in the original, this is a rectangular prism, however i wanted to demonstrate use of the ellipse and arc functions so i made it rounded.
//shadow - need to draw before shape so that it appears on top
fill(darkestBrown);
arc(86, 492, 25, 215, PI*.97, TWO_PI*0.99); // mimicing the 3d shadow via the arc tool required some fine tuning and iterating.
arc(86, 494, 85, 15, PI*1.57, TWO_PI*1.295);
fill(lightYellow);
ellipse(133, 420, 50, 160);
