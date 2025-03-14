package MotionCameraVisionState {

    package Definitions {
        // Define Components
        part def MotionSensorTest {
            perform action 'Detect Motion': 'MotionDetection';
            exhibit state 'motion sensor states': 'Motion Sensor States';
        }

        part def CameraTest {
            perform action 'Capture Image': 'CaptureImage';
            exhibit state 'camera states': 'Camera States';
        }

        part def ComputerVisionTest {
            perform action 'Process Image': 'ProcessImage';
            exhibit state 'vision states': 'Computer Vision States';
        }

        part def ObjectDetectionTest {
            perform action 'Detect Object': 'ObjectDetection';
            exhibit state 'detection states': 'Object Detection States';
        }

        // Define Test States
        state def 'Motion Sensor States';
        state def 'Camera States';
        state def 'Computer Vision States';
        state def 'Object Detection States';

        // Define Actions
        action def 'MotionDetection';
        action def 'CaptureImage';
        action def 'ProcessImage';
        action def 'ObjectDetection';

        // Define Attributes
        attribute def 'Motion Detected';
        attribute def 'Image Captured';
        attribute def 'Processing Complete';
        attribute def 'Object Identified';
        attribute def 'Processing Failed';
    }

    package Usages {
        private import Definitions::*;

        // Actions
        action 'motion detection': 'MotionDetection';
        action 'capture image': 'CaptureImage';
        action 'process image': 'ProcessImage';
        action 'detect object': 'ObjectDetection';

        // State Machine for Motion, Camera, and Computer Vision Test Flow
        state 'test flow states' parallel {
            ref motionSensor : MotionSensorTest;
            ref camera : CameraTest;
            ref computerVision : ComputerVisionTest;
            ref objectDetection : ObjectDetectionTest;

            state Start {
                entry action initial;
                transition initial then MotionDetection;
            }

            // Motion Detection State
            state MotionDetection {
                transition 'motion-detected'
                    first MotionDetection
                    accept 'Motion Detected'
                    do send 'MotionDetection'() to motionSensor
                    then CaptureImage;

                transition 'motion-fail'
                    first MotionDetection
                    accept 'Processing Failed'
                    then Fail;
            }

            // Camera Capture State
            state CaptureImage {
                transition 'image-captured'
                    first CaptureImage
                    accept 'Image Captured'
                    do send 'CaptureImage'() to camera
                    then ProcessImage;
            }

            // Computer Vision Processing State
            state ProcessImage {
                transition 'processing-success'
                    first ProcessImage
                    accept 'Processing Complete'
                    do send 'ProcessImage'() to computerVision
                    then ObjectDetection;

                transition 'processing-fail'
                    first ProcessImage
                    accept 'Processing Failed'
                    then Fail;
            }

            // Object Detection State
            state ObjectDetection {
                transition 'object-identified'
                    first ObjectDetection
                    accept 'Object Identified'
                    do send 'ObjectDetection'() to objectDetection
                    then Pass;
                
                transition 'detection-fail'
                    first ObjectDetection
                    accept 'Processing Failed'
                    then Fail;
            }

            state Pass {
                final;
            }

            state Fail {
                final;
            }
        }
    }
}
