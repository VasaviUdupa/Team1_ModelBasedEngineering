import simpy
from simpy import Environment
from Database import Database
from CommunicationPorts import NetworkPort

class LLM:
    def __init__(self, env: Environment, name, recipe_creation_time, llm_port:NetworkPort, database:Database):
        self.env = env
        self.name = name
        self.recipe_creation_time = recipe_creation_time
        self.llm_port = llm_port
        self.database = database
        self.recipe_request_receive_event = simpy.Event(self.env)
        self.ingredient_manifest_request_event = simpy.Event(self.env)
        self.ingredient_manifest_recieve_event = simpy.Event(self.env)
        self.recipe_creation_event = simpy.Event(self.env)
        self.classify_object_event = simpy.Event(self.env)

    def receive_recipe_request(self):
        yield self.llm_port.data_request
        yield self.env.process(self.llm_port.reset_data_request(self.name, "Recipe"))
        self.recipe_request_receive_event.succeed()

    def request_ingredient_manifest(self):
        yield self.recipe_request_receive_event
        self.recipe_request_receive_event = simpy.Event(self.env)
        print(f"{self.name}: Requesting ingredient manifest at {self.env.now}")
        yield self.env.process(self.database_port.set_data_request(self.name, "Ingredient manifest"))
    
    def receive_ingredient_manifest(self):
        yield self.recipe_request_receive_event
        self.recipe_request_receive_event = simpy.Event(self.env)
        while True:
            yield self.database.database_port.data_ready
            self.database.database_port.data_ready = simpy.Event(self.env)
            yield self.env.process(self.llm_port.reset_data_ready(self.name, "Ingredient manifest"))
            self.ingredient_manifest_recieve_event.succeed()
            break
        
    def create_recipe(self):
        yield self.ingredient_manifest_recieve_event
        self.ingredient_manifest_recieve_event = simpy.Event(self.env)
        print(f"{self.name}: Creating recipe at {self.env.now}")
        yield self.env.timeout(self.recipe_creation_time)
        print(f"{self.name}: Created recipe at {self.env.now}")
        yield self.env.process(self.llm_port.set_data_ready(self.name, "Recipe"))
    
    def recieve_and_proccess_workflow(self):
        yield self.env.process(self.receive_ingredient_manifest())
        yield self.env.process(self.create_recipe())
