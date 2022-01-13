// Dot-matrix; time-based; periodic function; limited range; curated seed parameters; color distortion; speed alterations; striation introduced; stochastic options // animated, looping, color, periodic, processing, glitch, curated, gif, stochastic
// Optical movement; periodic function; repetition // animation, color, periodic, processing, glitch

float requiredFrames = floor(random(2, 2))*60;

float gridNumber, halfGridNumber, spacing, stripeNumber, stripeOperator;
float overlayValue, chosenHue, backgroundHue, chosenSaturation, chosenBrightness, range, colorChangeSpeed;
float splitNumberI, splitNumberJ, splitNumberIAlt, splitNumberJAlt, rotationAmount;
int splitChoice, postRenderChoice, colorChangeChoice, parameterChoice, renderChoice, stripeChoice;
float parameter, gridSize, rotation;

void setup() {
  size(512, 512);
  rectMode(CENTER);
  colorMode(HSB, 360, 1, 1, 1);
  initiate();
}

void initiate() {
  int seed = floor(random(999999));
  String formattedSeed = nf(seed, 6);
  println("  seed = " + seed + ";");
  println();
  println("Statix"+formattedSeed);
  //println("Statix is a dot-matrix rendered, time-based periodic function. Its range, colors, and other parameters are limited, producing color distortion, striation, speed alterations and changes of direction. Some slight post-processing produces a fuzzy, static effect. Seed value for this animation is " + seed + ". Values are then curated and guided in a process of experimental aesthetic manipulation.");
  println("Statix is a dot-matrix rendered, time-based periodic function. This version has a shorter framecount, leading to a tighter loop. Its range, colors, and other parameters are limited, producing color distortion, striation, speed alterations and changes of direction. Some slight post-processing produces a fuzzy, static effect. Seed value for this animation is " + seed + ". Values are then curated and guided in a process of experimental aesthetic manipulation.");
  println("animated, statix, looping, color, periodic, processing, glitch, curated, gif, stochastic, " + seed);
  println();

  randomSeed(seed);
  gridNumber = floor(random(32, 256));
  halfGridNumber = gridNumber/2;
  spacing = floor(random(4));
  stripeNumber = floor(random(0, 8));
  gridSize = width/gridNumber ; // /(gridNumber+2);
  stripeOperator = gridSize/stripeNumber;
  chosenHue = random(0, 360);
  backgroundHue = (chosenHue + random(60))%360; // (chosenHue+180)%360;
  chosenSaturation = 0.5 + int(random(1, 3))*0.25;
  chosenBrightness = 0.5 + int(random(1, 3))*0.25;
  range = random(-1, 1)/2;

  // Edit these values to alter the output
  postRenderChoice = floor(random(4));
  overlayValue = floor(random(8));
  splitNumberI = random(1, gridNumber);
  splitNumberJ = random(1, gridNumber);
  splitNumberIAlt = random(1, 4)*8;
  splitNumberJAlt = random(1, 8)*9;
  splitChoice = floor(random(0, 4));
  colorChangeChoice = floor(random(0, 5));
  rotation = random(TAU*0.01);
  parameterChoice = floor(random(9));
  colorChangeSpeed = random(-1, 1);
  renderChoice = floor(random(4));
  
}

void draw() {

  translate(width/2, height/2);
  rotate(rotation);
  scale(sqrt(2));
  translate(-width/2, -height/2);
  
  background(360-backgroundHue, 0.9, 0.1);
  //   translate(gridSize/2, gridSize/2);
  translate(spacing/2, spacing/2);
  for (float i=0; i<=gridNumber; i++) {
    for (float j=0; j<=gridNumber; j++) {

      float currentTime = map( float(frameCount)/requiredFrames, 0, 1, -PI, PI);
      float newI = map(i, 0, gridNumber, -range, range);
      float newJ = map(j, 0, gridNumber, -range, range);

      switch (parameterChoice) {
      case 0:
        parameter = map(sin((newI*newJ)+currentTime), -1, 1, 0, 255);
        break;
      case 1:
        parameter = map(cos((newI*newJ)+currentTime), -1, 1, 0, 255);
        break;
      case 2:
        parameter = map(sin((newI-newJ)+currentTime), -1, 1, 0, 255);
        break;
      case 3:
        parameter = map(sin((newI+newJ)+currentTime), -1, 1, 0, 255);
        break;
      case 4:
        parameter = map(cos((newI-newJ)+currentTime), -1, 1, 0, 255);
        break;
      case 5:
        parameter = map(sin(newJ+(newI*gridNumber)+currentTime), -1, 1, 0, 255);
        break;
      case 6:
        parameter = map(sin(newI*newI*0.01), -1, 1, 0, 255);
        break;
      case 7:
        parameter = map(sin(newJ*newJ*0.01), -1, 1, 0, 255);
        break;
      case 8:
        parameter = map(sin(newI*newI*2), -1, 1, 0, 255);
        break;
      }

      // Parameter override
      parameter = currentTime*cos(newJ)*sin(newI); // map(sin(currentTime+newI)*cos(currentTime+newJ), -1, 1, 128, 255);

      switch(stripeChoice) {
      case 0:
        if (i%stripeOperator > stripeOperator/2) {
          parameter = (255 * parameter)%255;
        }
        break;
      case 1:
        if (j%stripeOperator > stripeOperator/2) {
          parameter = (255 * parameter)%255;
        }
        break;
      default:
        break;
      }

      switch(splitChoice) {
      case 0:
        break;
      case 1: // Vertical split
        if (i > splitNumberI) parameter = parameter / splitNumberIAlt;
        break;
      case 2: // Horizontal split
        if (j > splitNumberJ) parameter = parameter / splitNumberJAlt;
        break;
      case 3: // Window split
        if (i > splitNumberI) parameter = parameter / splitNumberIAlt;
        if (j > splitNumberJ) parameter = parameter / splitNumberIAlt;
        break;
      default: // No split
        break;
      }

      switch (colorChangeChoice) {
      case 0:
        chosenHue = (chosenHue+(parameter/colorChangeSpeed))%360;
        break;
      case 1:
        chosenSaturation = (chosenSaturation+(parameter))%1;
        break;
      case 2:
        chosenBrightness = (chosenBrightness+(parameter))%1;
        break;
      case 3:
        chosenHue = (chosenHue + map(parameter, 0, 255, -255, 255))%360;
        break;
      case 4:
        chosenHue = (map(parameter, 0, 255, 0, 360))%180;
        backgroundHue = (chosenHue+180)%360;
        break;
      default:
        break;
      }


      noStroke();

      switch(renderChoice) {
      case 0:
        fill( chosenHue, chosenSaturation, chosenBrightness, 0.5);
        ellipse(i*gridSize, j*gridSize, gridSize-spacing, gridSize-spacing);
        break;
      case 1:
        fill( chosenHue, chosenSaturation, chosenBrightness);
        ellipse(j*gridSize, i*gridSize, gridSize-spacing, gridSize-spacing);
        fill( chosenHue, chosenSaturation, chosenBrightness, 0.25);
        ellipse(i*gridSize, j*gridSize*sqrt(2), gridSize-spacing, gridSize-spacing);
        break;
      case 2:
        fill( chosenHue, chosenSaturation, chosenBrightness);
        rect(i*gridSize, j*gridSize, gridSize-spacing, gridSize-spacing);
        fill( chosenHue, chosenSaturation, chosenBrightness, 0.25);
        ellipse(i*gridSize*sqrt(2), j*gridSize, gridSize-spacing, gridSize-spacing);
        break;
      case 3:
        fill( chosenHue, chosenSaturation, chosenBrightness, 0.5);
        ellipse(i*gridSize, j*gridSize, gridSize-spacing, gridSize-spacing);
        fill( (360-chosenHue)%360, chosenSaturation, chosenBrightness, 0.75);
        ellipse(j*gridSize, i*gridSize, gridSize-spacing, gridSize-spacing);
        break;
      }

      switch(postRenderChoice) {
      case 0:
        if (i%overlayValue == 0) {
          fill(0, 0, 0.5, 0.5);
          ellipse(i*gridSize, j*gridSize, 2, 2);
        }
        break;
      case 1:
        if (j%overlayValue == 0) {
          fill(0, 0, 0.5, 0.5);
          ellipse(i*gridSize, j*gridSize, 2, 2);
        }
      case 2:
        if (i%overlayValue == 0 || j%overlayValue == 0) {
          fill(0, 0, 0.5, 0.5);
          ellipse(i*gridSize, j*gridSize, 2, 2);
        }
        break;
      }
    }
  }

  strokeWeight(1);
  for (int line = -height; line <= height; line+=8) {
    stroke(0, 0, 100, 0.1); // floor(random(2))*100, 3);
    stroke(0, 0, 0, 0.1); // floor(random(2))*100, 3);
    line(-width, line, height, line);
  }

  // Uncomment to save frames
  //if (frameCount <= requiredFrames) {
  //  saveFrame();
  //} else {
  //  exit();
  //}

}
