#pragma once

#include "ofColor.h"
#include "ofMain.h"
#include "ofMath.h"
#include <map>
#include <string>
#include <vector>

#define LINE_SEGMENTS 200

/**
 * DataPacket contains all the data sent by the Python-server.
 */
class DataPacket {
public:
  std::vector<ofVec2f> tailPoints;

  DataPacket(ofVec2f startPosition = ofVec2f(ofGetWidth() / 2.f,
                                             ofGetHeight() / 2.f),
             ofColor _color = ofColor(255, 255, 255))
      : color(_color) {
    currentPosition.set(startPosition);
    tailPoints.push_back(currentPosition);
    velocity.set(1.f, 1.f);
    velocity.normalize();
    velocity.scale(10.f); // TODO better velocity-vector initilization
  }
  ~DataPacket();

  void setColor(ofColor _color) { color = _color; }

  /**
   * Ensures that tail is never longer than defined max boundary
   */
  void keepTailBounded() {
    while (tailPoints.size() > LINE_SEGMENTS)
      tailPoints.pop_back();
  }
  /**
   * Pushes received data to tail points
   */
  void updateTailPoints() {
    velocity = velocity.getRotated(receivedData[dataCounter] * 5.f);
    currentPosition += velocity;
    dataCounter = (dataCounter + 1) % receivedData.size(); // updates counter
    if (currentPosition.x > ofGetWidth() + 10) // TODO variable margins..
      currentPosition.x = 0;
    else if (currentPosition.x < -10)
      currentPosition.x = ofGetWidth();
    if (currentPosition.y > ofGetHeight() + 10)
      currentPosition.y = 0;
    else if (currentPosition.y < -10)
      currentPosition.y = ofGetHeight();

    tailPoints.insert(tailPoints.begin(), currentPosition);
  }

  void appendData(float dataPoint) { receivedData.push_back(dataPoint); }
  bool collision(DataPacket other);
  ofColor getColor() { return color; }

private:
  ofVec2f currentPosition, velocity;
  std::string type = "init";
  std::vector<float> receivedData;
  std::map<string, float> metaInfo;
  size_t dataCounter = 0;

  ofColor color;
};
