package NotificationSystemState {

    private import ScalarValues::*;
    private import SmartHomeKitchenVerification::*;

    package Definitions {
        // Define Test Components
        part def NotificationTest {
            perform action 'Send Notification': 'SendNotification';
            exhibit state 'notification states': 'Notification Workflow States';
        }

        // Define Test States
        state def 'Notification Workflow States';

        // Define Actions
        action def 'DetectEvent';
        action def 'ProcessNotification';
        action def 'SendNotification';
        action def 'VerifyNotification';

        // Define Attributes
        attribute def 'Event Detected';
        attribute def 'Notification Processed';
        attribute def 'Notification Sent';
        attribute def 'Notification Received';
        attribute def 'Processing Failed';
    }

    package Usages {
        private import Definitions::*;

        // Actions
        action 'detect event': 'DetectEvent';
        action 'process notification': 'ProcessNotification';
        action 'send notification': 'SendNotification';
        action 'verify notification': 'VerifyNotification';

        // State Machine for Notification System Workflow
        state 'notification states' {
            ref notificationSystem : NotificationTest;

            state Start {
                entry action initial;
                transition initial then DetectEvent;
            }

            state DetectEvent {
                transition 'event-detected'
                    first DetectEvent
                    accept 'Event Detected'
                    do send 'DetectEvent'() to notificationSystem
                    then ProcessNotification;

                transition 'event-fail'
                    first DetectEvent
                    accept 'Processing Failed'
                    then Fail;
            }

            state ProcessNotification {
                transition 'notification-ready'
                    first ProcessNotification
                    accept 'Notification Processed'
                    then SendNotification;
            }

            state SendNotification {
                transition 'notification-sent'
                    first SendNotification
                    accept 'Notification Sent'
                    then VerifyNotification;
            }

            state VerifyNotification {
                transition 'notification-received'
                    first VerifyNotification
                    accept 'Notification Received'
                    then Pass;

                transition 'notification-fail'
                    first VerifyNotification
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
