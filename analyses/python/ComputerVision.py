import simpy
from simpy import Environment
from CommunicationPorts import NetworkPort

class ComputerVision:
    def __init__(self, env: Environment, name, preprocesing_time, detection_time, classification_time, cv_port:NetworkPort):
        self.env = env
        self.name = name
        self.preprocesing_time = preprocesing_time
        self.detection_time = detection_time
        self.classification_time = classification_time
        self.cv_port = cv_port
        self.image_received_event = simpy.Event(self.env)
        self.image_preproccessing_event = simpy.Event(self.env)
        self.object_detection_event = simpy.Event(self.env)
        self.classify_object_event = simpy.Event(self.env)

    def receive_image_data(self):
        print(f"{self.name}: Wating to receive image classification request at {self.env.now}...")
        yield self.cv_port.data_request
        yield self.env.process(self.cv_port.reset_data_request(self.name, "Image classification"))
        print(f"{self.name}: Wating to receive image at {self.env.now}...")
        yield self.cv_port.data_ready
        yield self.env.process(self.cv_port.reset_data_ready(self.name, "Image"))
        self.image_received_event.succeed()

    def preprocess_image(self):
        yield self.image_received_event
        self.image_received_event = simpy.Event(self.env)
        print(f"{self.name}: Preprocessing image stating at {self.env.now}")
        yield self.env.timeout(self.preprocesing_time)
        print(f"{self.name}: Image preprocessed at {self.env.now}")
        self.image_preproccessing_event.succeed()

    def detect_objects(self):
        yield self.image_preproccessing_event
        self.image_preproccessing_event = simpy.Event(self.env)
        print(f"{self.name}: Detecting objects in image at {self.env.now}")
        yield self.env.timeout(self.detection_time)
        print(f"{self.name}: Objects detected at {self.env.now}")
        self.object_detection_event.succeed()
        
    def classify_object(self):
        yield self.object_detection_event
        self.object_detection_event = simpy.Event(self.env)
        print(f"{self.name}: Classifying food based on objects at {self.env.now}")
        yield self.env.timeout(self.classification_time)
        print(f"{self.name}: Food classified at {self.env.now}")
        self.classify_object_event.succeed()

    def send_recognition_data(self):
        yield self.classify_object_event
        self.classify_object_event = simpy.Event(self.env)
        yield self.env.process(self.cv_port.set_data_ready(self.name, "Image classification"))

    def recieve_and_proccess_workflow(self):
        yield self.env.process(self.receive_image_data())
        yield self.env.process(self.preprocess_image())
        yield self.env.process(self.detect_objects())
        yield self.env.process(self.classify_object())
        yield self.env.process(self.send_recognition_data())
