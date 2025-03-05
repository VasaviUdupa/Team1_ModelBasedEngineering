import simpy
import random
from simpy import Environment
from CommunicationPorts import HardwarePort, NetworkPort, StoragePort, ServicePort

class Computer:
    def __init__(self, env:Environment, image_port:HardwarePort, cv_port:NetworkPort, database_port:NetworkPort, llm_port:NetworkPort, boot_time, name):
        self.env = env
        self.image_port = image_port
        self.cv_port = cv_port
        self.database_port = database_port
        self.llm_port = llm_port
        self.boot_time = boot_time
        self.name = name
        self.boot_finished_event = simpy.Event(self.env)
        self.image_received_event = simpy.Event(self.env)
        self.image_classification_request_event = simpy.Event(self.env)
        self.image_classification_received_event = simpy.Event(self.env)
        self.image_classification_updated_event = simpy.Event(self.env)
        self.llm_recipe_request_event = simpy.Event(self.env)
        self.llm_recipe_received_event = simpy.Event(self.env)
        
        self.validate_data_event = simpy.Event(self.env)
        self.proccess_data_event = simpy.Event(self.env)
        self.store_data_event = simpy.Event(self.env)
        self.send_output_event = simpy.Event(self.env)

    def boot_process(self):
        print(f"{self.name}: Booting up at {self.env.now}")
        yield self.env.timeout(self.boot_time) # Simulate boot time
        print(f"{self.name}: Computer {self.name} booted at {self.env.now}")
        self.boot_finished_event.succeed() 
        
    def request_image_data(self):
        print(f"{self.name}: Requesting image at {self.env.now}")
        yield self.env.process(self.image_port.set_data_request(self.name, "Image"))
        
    def receive_image_data(self):
        print(f"{self.name}: Wating to receive image at {self.env.now}...")
        yield self.image_port.data_ready
        yield self.env.process(self.image_port.reset_data_ready(self.name, "Image"))
        self.image_received_event.succeed()
    
    def request_image_classification(self):
        yield self.env.process(self.cv_port.set_data_request(self.name, "Image calssification"))
        yield self.env.process(self.cv_port.set_data_ready(self.name, "Image"))
        self.image_classification_request_event.succeed()
    
    def receive_image_classification(self):
        yield self.image_classification_request_event
        print(f"{self.name}: Wating to receive image classification at {self.env.now}...")
        yield self.cv_port.data_ready
        yield self.env.process(self.cv_port.reset_data_ready(self.name, "Image calssification"))
        self.image_classification_received_event.succeed()
    
    def upload_image_classification(self):
        yield self.image_classification_received_event
        yield self.env.process(self.database_port.set_data_ready(self.name, "Image classification"))
    
    def request_llm_data(self):
        yield self.env.process(self.llm_port.set_data_request(self.name, "Recipe"))
        self.llm_recipe_request_event.succeed()
    
    def receive_llm_data(self):
        yield self.llm_recipe_request_event
        print(f"{self.name}: Wating to receive recipe at {self.env.now}...")
        yield self.llm_port.data_ready
        yield self.env.process(self.llm_port.reset_data_ready(self.name, "recipe"))
        self.llm_recipe_received_event.succeed()
    
