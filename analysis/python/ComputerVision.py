import simpy
from simpy import Environment
from CommunicationPorts import NetworkPort
from Database import Database

class ComputerVision:
    def __init__(self, env: Environment, name, preprocesing_time, detection_time, classification_time, cv_port:NetworkPort, database:Database):
        self.env = env
        self.name = name
        self.preprocesing_time = preprocesing_time
        self.detection_time = detection_time
        self.classification_time = classification_time
        self.cv_port = cv_port
        self.database = database
        self.image_classification_request_event = simpy.Event(self.env)
        self.image_received_event = simpy.Event(self.env)
        self.image_preproccessing_event = simpy.Event(self.env)
        self.object_detection_event = simpy.Event(self.env)
        self.classify_object_event = simpy.Event(self.env)

    def recive_image_classification_request(self):
        yield self.cv_port.data_request
        yield self.env.process(self.cv_port.reset_data_request(self.name, "Image classification"))
        self.image_classification_request_event.succeed()
        
        
    def receive_image_data(self):
        yield self.image_classification_request_event
        self.image_classification_request_event = simpy.Event(self.env)
        while True:
            yield self.database.database_port.data_ready
            self.database.database_port.data_ready = simpy.Event(self.env)
            yield self.env.process(self.cv_port.reset_data_ready(self.name, "Image"))
            self.image_received_event.succeed()
            break

    def process_image(self):
        yield self.image_received_event
        self.image_received_event = simpy.Event(self.env)
        print(f"{self.name}: Preprocessing image stating at {self.env.now}")
        yield self.env.timeout(self.preprocesing_time)
        print(f"{self.name}: Image data processed at {self.env.now}")
        yield self.env.timeout(self.detection_time)
        print(f"{self.name}: Image detection completed at {self.env.now}")
        yield self.env.timeout(self.classification_time)
        print(f"{self.name}: Image classification completed at {self.env.now}")
        yield self.env.process(self.cv_port.set_data_ready(self.name, "Image classification"))

    def recieve_and_proccess_workflow(self):
        yield self.env.process(self.receive_image_data())
        yield self.env.process(self.process_image())
