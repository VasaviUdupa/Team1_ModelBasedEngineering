import simpy

class HardwarePort:
    def __init__(self, env, name, transfer_time_s):
        self.env = env
        self.name = name
        self.transfer_time_s = transfer_time_s
        self.data_ready = simpy.Event(self.env)
        self.data_request = simpy.Event(self.env)
        
    def set_data_ready(self, name, dtype):
        yield self.env.timeout(self.transfer_time_s)
        print(f"{name}: {dtype} ready at {self.env.now}")
        self.data_ready.succeed()
    
    def reset_data_ready(self, name, dtype):
        print(f"{name}: {dtype} recieved at {self.env.now}")
        self.data_ready = simpy.Event(self.env)
        yield self.env.timeout(0) 
    
    def set_data_request(self, name, dtype):
        yield self.env.timeout(self.transfer_time_s)
        print(f"{name}: {dtype} request at {self.env.now}")
        self.data_request.succeed()
    
    def reset_data_request(self, name, dtype):
        print(f"{name}: {dtype} request recieved at {self.env.now}")
        self.data_request = simpy.Event(self.env) 
        yield self.env.timeout(0) 
        
        
class NetworkPort:
    def __init__(self, env, name, transfer_time_s):
        self.env = env
        self.name = name
        self.transfer_time_s = transfer_time_s
        self.data_ready = simpy.Event(self.env)
        self.data_request = simpy.Event(self.env)
        
    def set_data_ready(self, name, dtype):
        yield self.env.timeout(self.transfer_time_s)
        print(f"{name}: {dtype} ready at {self.env.now}")
        self.data_ready.succeed()
    
    def reset_data_ready(self, name, dtype):
        print(f"{name}: {dtype} recieved at {self.env.now}")
        self.data_ready = simpy.Event(self.env)
        yield self.env.timeout(0) 
    
    def set_data_request(self, name, dtype):
        yield self.env.timeout(self.transfer_time_s)
        print(f"{name}: {dtype} request at {self.env.now}")
        self.data_request.succeed()
    
    def reset_data_request(self, name, dtype):
        print(f"{name}: {dtype} request recieved at {self.env.now}")
        self.data_request = simpy.Event(self.env) 
        yield self.env.timeout(0) 
        
class StoragePort:
    def __init__(self, env, name, transfer_time_s):
        self.env = env
        self.name = name
        self.transfer_time_s = transfer_time_s
        self.data_ready = simpy.Event(self.env)
        self.data_request = simpy.Event(self.env)
        
    def set_data_ready(self, name, dtype):
        yield self.env.timeout(self.transfer_time_s)
        print(f"{name}: {dtype} ready at {self.env.now}")
        self.data_ready.succeed()
    
    def reset_data_ready(self, name, dtype):
        print(f"{name}: {dtype} recieved at {self.env.now}")
        self.data_ready = simpy.Event(self.env)
        yield self.env.timeout(0) 
    
    def set_data_request(self, name, dtype):
        yield self.env.timeout(self.transfer_time_s)
        print(f"{name}: {dtype} request at {self.env.now}")
        self.data_request.succeed()
    
    def reset_data_request(self, name, dtype):
        print(f"{name}: {dtype} request recieved at {self.env.now}")
        self.data_request = simpy.Event(self.env) 
        yield self.env.timeout(0) 

class ServicePort:
    def __init__(self, env, name, transfer_time_s):
        self.env = env
        self.name = name
        self.transfer_time_s = transfer_time_s
        self.data_ready = simpy.Event(self.env)
        self.data_request = simpy.Event(self.env)
        
    def set_data_ready(self, name, dtype):
        yield self.env.timeout(self.transfer_time_s)
        print(f"{name}: {dtype} ready at {self.env.now}")
        self.data_ready.succeed()
    
    def reset_data_ready(self, name, dtype):
        print(f"{name}: {dtype} recieved at {self.env.now}")
        self.data_ready = simpy.Event(self.env)
        yield self.env.timeout(0) 
    
    def set_data_request(self, name, dtype):
        yield self.env.timeout(self.transfer_time_s)
        print(f"{name}: {dtype} request at {self.env.now}")
        self.data_request.succeed()
    
    def reset_data_request(self, name, dtype):
        print(f"{name}: {dtype} request recieved at {self.env.now}")
        self.data_request = simpy.Event(self.env) 
        yield self.env.timeout(0) 
        