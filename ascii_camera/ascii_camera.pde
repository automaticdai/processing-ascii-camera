// automaticdai
// YF Robotics Lab
// Copyright (c) 2024
// Credit: Koy - Generative Typography (http://www.openprocessing.org/sketch/161029)

import processing.video.*;

Capture cam;

int[] pixelMaskList;
PVector axis;
int distance;
PFont font;
int count, max;
String typedKey = "O";
PImage img;

String grey_map = "$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/|()1{}[]?-_+~<>i!lI;:,\"^`'. ";

void setup(){
  size(640, 480);
  
  colorMode(RGB,255,255,255);
  smooth(16);
  frameRate(30);
  
  strokeCap(SQUARE);
  stroke(10);
  strokeWeight(0.2);
  
  textSize(8);
  fill(0);
  
  // load camear list
  String[] cameras = Capture.list();
  
  if (cameras.length == 0){
    println("There are no camera!");
    exit();
  } else {
    for ( int i = 0; i < cameras.length; i++ ){
      println(cameras[i]);
    }
    cam = new Capture(this, cameras[0]);
    cam.start();
  }
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  
  loadCameraPixels();
  
  background(#FFFAF5);
  background(255);
  
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      if (x % 5==0 && y % 5==0) {
        text(grey_map.charAt(pixelMaskList[y*width + x]), x, y);
      }
    }
  }
}


void loadCameraPixels(){
  // make mask from an image
  background(255,255,255);
  img = loadImage("img.jpg");
  image(cam, 0, 0);
  
  pixelMaskList = new int[width*height];
  loadPixels(); // Loads the pixel data of the current display window into the pixels[] array. 
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      color pb = pixels[y*width + x];
      pixelMaskList[y*width + x] = int(brightness(pb) / 4);  
     }
  }
  updatePixels();
}
