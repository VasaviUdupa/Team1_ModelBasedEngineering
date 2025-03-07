import simpy
import random
from simpy import Environment
from CommunicationPorts import HardwarePort, NetworkPort
from CameraSystem import Camera
from ComputerVision import ComputerVision
from Database import Database
from LLM import LLM

class Computer:
    def __init__(self, env: Environment, image_port: HardwarePort, cv_port: NetworkPort, database_port: NetworkPort, 
                 llm_port: NetworkPort, boot_time, camera:Camera, database: Database, computer_vision: ComputerVision,
                 llm: LLM, name):
        self.env = env
        self.image_port = image_port
        self.cv_port = cv_port
        self.database_port = database_port
        self.llm_port = llm_port
        self.boot_time = boot_time
        self.camera = camera
        self.database = database
        self.computer_vision = computer_vision
        self.llm = llm
        self.name = name
        self.boot_finished_event = simpy.Event(self.env)
        self.image_received_event = simpy.Event(self.env)
        self.upload_image_data_event = simpy.Event(self.env)
        self.image_classification_request_event = simpy.Event(self.env)
        self.image_classification_received_event = simpy.Event(self.env)
        self.upload_image_classification_event = simpy.Event(self.env)
        self.llm_recipe_request_event = simpy.Event(self.env)
        self.llm_recipe_received_event = simpy.Event(self.env)

    def boot_process(self):
        print(f"{self.name}: Booting up at {self.env.now}")
        yield self.env.timeout(self.boot_time)
        print(f"{self.name}: Computer {self.name} booted at {self.env.now}")
        self.boot_finished_event.succeed()

    def get_image_data(self):
        yield self.boot_finished_event
        self.boot_finished_event = simpy.Event(self.env)
        yield self.env.process(self.image_port.set_data_request(self.name, "Image"))
        while True:
            yield self.env.process(self.camera.capture_frame())
            yield self.env.process(self.camera.send_image_data())
            yield self.image_port.data_ready
            self.image_port.reset_data_ready(self.name, "Image")
            self.image_received_event.succeed()
            break
    
    def upload_image_data(self):
        yield self.image_received_event
        self.image_received_event = simpy.Event(self.env)
        yield self.env.process(self.database_port.set_data_ready(self.name, "Image"))
        yield self.env.process(self.database.recieve_data("Image"))
        self.upload_image_data_event.succeed()
        
    def get_image_classification(self):
        yield self.upload_image_data_event
        self.upload_image_data_event = simpy.Event(self.env)
        yield self.env.process(self.cv_port.set_data_request(self.name, "Image classification"))
        self.image_classification_request_event.succeed()
        while True:
            yield self.image_classification_request_event
            self.image_classification_request_event = simpy.Event(self.env)
            yield self.env.process(self.computer_vision.recive_image_classification_request())
            yield self.env.process(self.computer_vision.database.database_port.set_data_request(self.computer_vision.name, "Image"))
            yield self.env.process(self.computer_vision.database.send_data("Image"))
            yield self.env.process(self.cv_port.set_data_ready(self.name, "Image"))
            yield self.env.process(self.computer_vision.receive_image_data())
            yield self.env.process(self.computer_vision.process_image())
            yield self.cv_port.data_ready
            self.cv_port.reset_data_ready(self.name, "Image classification")
            self.image_classification_received_event.succeed()
            break
    
    def upload_image_classification_data(self):
        yield self.image_classification_received_event
        self.image_classification_received_event = simpy.Event(self.env)
        yield self.env.process(self.database_port.set_data_ready(self.name, "Image Classification"))
        yield self.env.process(self.database.recieve_data("Image Classification"))
        self.upload_image_classification_event.succeed()
        
    def get_llm_recipe(self):
        yield self.upload_image_classification_event
        self.upload_image_classification_event = simpy.Event(self.env)
        yield self.env.process(self.llm_port.set_data_request(self.name, "LLM recipe"))
        self.llm_recipe_request_event.succeed()
        while True:
            yield self.llm_recipe_request_event
            self.llm_recipe_request_event = simpy.Event(self.env)
            yield self.env.process(self.llm.receive_recipe_request())
            yield self.env.process(self.llm.database.database_port.set_data_request(self.llm.name, "Ingredient manifest"))
            yield self.env.process(self.llm.database.send_data("Ingredient manifest"))
            yield self.env.process(self.llm_port.set_data_ready(self.name, "Ingredient manifest"))
            yield self.env.process(self.llm.receive_ingredient_manifest())
            yield self.env.process(self.llm.create_recipe())
            yield self.llm_port.data_ready
            self.llm_port.reset_data_ready(self.name, "Recipe")
            self.llm_recipe_received_event.succeed()
            break
        
    def workflow(self, camera, computer_vision, database, llm):
        yield self.env.process(self.boot_process())
        yield self.env.process(self.get_image_data())
        yield self.env.process(self.upload_image_data())
        yield self.env.process(self.get_image_classification())
        yield self.env.process(self.upload_image_classification_data())
        yield self.env.process(self.get_llm_recipe())
