import simpy
from simpy import Environment
from CommunicationPorts import NetworkPort

class LLM:
    def __init__(self, env: Environment, name, recipe_creation_time, llm_port:NetworkPort, database_port:NetworkPort):
        self.env = env
        self.name = name
        self.recipe_creation_time = recipe_creation_time
        self.llm_port = llm_port
        self.database_port = database_port
        self.recipe_request_receive_event = simpy.Event(self.env)
        self.recieve_ingredient_manifest_event = simpy.Event(self.env)
        self.recipe_creation_event = simpy.Event(self.env)
        self.classify_object_event = simpy.Event(self.env)

    def receive_recipe_request(self):
        print(f"{self.name}: Wating to receive recipe request at {self.env.now}...")
        yield self.llm_port.data_request
        yield self.env.process(self.llm_port.reset_data_request(self.name, "recipe"))
        self.recipe_request_receive_event.succeed()

    def request_ingredient_manifest(self):
        yield self.recipe_request_receive_event
        self.recipe_request_receive_event = simpy.Event(self.env)
        print(f"{self.name}: Requesting ingredient manifest at {self.env.now}")
        yield self.env.process(self.database_port.set_data_request(self.name, "Ingredient manifest"))
    
    def recieve_ingredient_manifest(self):
        yield self.database_port.data_ready
        yield self.env.process(self.database_port.reset_data_request(self.name, "Ingredient manifest"))
        self.recieve_ingredient_manifest_event.succeed()
        
    def create_recipe(self):
        yield self.recieve_ingredient_manifest_event
        self.recieve_ingredient_manifest_event = simpy.Event(self.env)
        print(f"{self.name}: Creating recipe at {self.env.now}")
        yield self.env.timeout(self.recipe_creation_time)
        print(f"{self.name}: Created recipe  at {self.env.now}")
        self.recipe_creation_event.succeed()

    def send_recognition_data(self):
        yield self.recipe_creation_event
        self.recipe_creation_event = simpy.Event(self.env)
        yield self.env.process(self.llm_port.set_data_ready(self.name, "Recipe"))
    
    def create_recipe_send(self):
        yield self.env.process(self.create_recipe())
        yield self.env.process(self.send_recognition_data())
