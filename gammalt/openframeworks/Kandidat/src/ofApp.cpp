#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
  ofSetCircleResolution(50);
  ofSetFrameRate(45);

  receiver.setup(OSC_PORT);
}

//--------------------------------------------------------------
// buffra datan
void ofApp::update() {
  while (receiver.hasWaitingMessages()) {
    ofxOscMessage message;
    receiver.getNextMessage(&message);
    if (!isReceivingData) {
      if (message.getAddress() == "/newPacket") {
        isReceivingData = true;
        newPacket = new DataPacket();
        newPacket->setColor(
            ofColor(255, ofRandom(128, 255), ofRandom(128, 255)));
      }
    } else {
      if (message.getAddress() == "/value")
        newPacket->appendData(message.getArgAsFloat(0));
      else if (message.getAddress() == "/done") {
        isReceivingData = false;
        receivedDataPackets.push_back(newPacket);
      }
    }
  }

  if (receivedDataPackets.size() > 0)
    updatePackets();
}

//--------------------------------------------------------------
void ofApp::draw() {
  ofEnableAlphaBlending();
  ofFill();

  for (DataPacket *packet : receivedDataPackets) {
    for (size_t i = 0; i < MIN(LINE_SEGMENTS, packet->tailPoints.size() - 1);
         i++) {
      ofSetColor(packet->getColor(), ofMap(i, 0, LINE_SEGMENTS, 255, 0, true));
      ofVec2f currentPoint = packet->tailPoints[i + 1],
              lastPoint = packet->tailPoints[i];
      if (currentPoint.distance(lastPoint) <
          (MIN(ofGetWidth(), ofGetHeight()) - 50))
        ofDrawLine(currentPoint, lastPoint);
    }
  }
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {}

//--------------------------------------------------------------
void ofApp::keyReleased(int key) {}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y) {}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button) {}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button) {}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button) {}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y) {}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y) {}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h) {}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg) {}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo) {}
// void ofApp::exit() { dataThread.stopThread(); }
