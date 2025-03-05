import simpy
import random
from CommunicationPorts import HardwarePort

class Camera:
    def __init__(self, env, name, capture_time, image_port:HardwarePort):
        self.env = env
        self.name = name
        self.capture_time = capture_time
        self.image_port = image_port
        self.image_capture_event = simpy.Event(self.env)

    def capture_frame(self):
        yield self.image_port.data_request
        self.image_port.reset_data_request(self.name, "Image")
        yield self.env.timeout(self.capture_time)
        print(f"{self.name}: Captured frame at {self.env.now}")
        self.image_capture_event.succeed()
        
    def send_image_data(self):
        yield self.image_capture_event
        self.image_capture_event = simpy.Event(self.env)
        yield self.env.process(self.image_port.set_data_ready(self.name, "Image"))
        
    def caputure_and_send_workflow(self):
        yield self.env.process(self.capture_frame())
        yield self.env.process(self.send_image_data())