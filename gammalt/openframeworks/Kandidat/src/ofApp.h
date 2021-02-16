#pragma once

#include "DataPacket.h"
#include "ofMain.h"
#include "ofMath.h"
#include "ofxOsc.h"
#include <vector>

#define OSC_PORT 7771

class ofApp : public ofBaseApp {

public:
  void setup();
  void update();
  void draw();

  void keyPressed(int key);
  void keyReleased(int key);
  void mouseMoved(int x, int y);
  void mouseDragged(int x, int y, int button);
  void mousePressed(int x, int y, int button);
  void mouseReleased(int x, int y, int button);
  void mouseEntered(int x, int y);
  void mouseExited(int x, int y);
  void windowResized(int w, int h);
  void dragEvent(ofDragInfo dragInfo);
  void gotMessage(ofMessage msg);
  void exit() {}

private:
  ofxOscReceiver receiver;
  std::vector<DataPacket *> receivedDataPackets;
  std::vector<ofVec2f> points; // TODO remove
  std::vector<float> values;   // TODO remove
  std::vector<int> times;      // TODO remove
  ofVec2f theCircle, velocity; // TODO change name of this! //TODO remove
  DataPacket *newPacket;
  bool isReceivingData = false;

  void updatePackets() {
    for (DataPacket *packet : receivedDataPackets) {
      packet->updateTailPoints();
      packet->keepTailBounded();
    }
  }
};
