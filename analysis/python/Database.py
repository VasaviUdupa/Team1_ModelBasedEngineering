import simpy
from simpy import Environment
from CommunicationPorts import NetworkPort

class Database:
    def __init__(self, env: Environment, name, bus_delay, database_port:NetworkPort):
        self.env = env
        self.name = name
        self.bus_delay = bus_delay
        self.database_port = database_port

    def recieve_data(self, data):
        print(f"{self.name}: Wating to receive {data} at {self.env.now}...")
        yield self.database_port.data_ready
        self.database_port.data_ready = simpy.Event(self.env)
        yield self.env.timeout(self.bus_delay)
        yield self.env.process(self.database_port.reset_data_ready(self.name, data))
    
    def send_data(self, data):
        yield self.database_port.data_request
        self.database_port.data_request = simpy.Event(self.env)
        yield self.env.timeout(self.bus_delay)
        yield self.env.process(self.database_port.set_data_ready(self.name, data))
        print(f"{self.name}: Sent {data} at {self.env.now}")

        