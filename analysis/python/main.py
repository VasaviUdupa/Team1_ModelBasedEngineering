import simpy
from LLM import LLM
from simpy import Environment
from Database import Database
from Computer import Computer
from CameraSystem import Camera
from ComputerVision import ComputerVision
from CommunicationPorts import HardwarePort, NetworkPort

def main():
    env = Environment()
    
    image_port = HardwarePort(env=env, name="CameraDataPort", transfer_time_s=0.5)
    cv_port = NetworkPort(env=env, name="CVDataPort", transfer_time_s=1.5)
    llm_port = NetworkPort(env=env, name="LLMDataPort", transfer_time_s=1.5)
    database_port = NetworkPort(env=env, name="DatabaseDataPort", transfer_time_s=1.5)
    
    capture_time = 1
    camera = Camera(env=env, capture_time=capture_time, image_port=image_port, name="FoodCamera")
    
    bus_delay = 1
    database = Database(env=env, name="Database", bus_delay=bus_delay, database_port=database_port)
    
    preprocesing_time = 1
    detection_time = 1
    classification_time = 1
    computer_vision = ComputerVision(env=env, name="ComputerVision", preprocesing_time=preprocesing_time, 
                                     detection_time=detection_time, classification_time=classification_time,
                                     cv_port=cv_port, database=database)
    
    recipe_creation_time = 10
    llm = LLM(env=env, name="LLM", recipe_creation_time=recipe_creation_time, llm_port=llm_port, database=database)

    boot_time = 10
    computer = Computer(env=env, image_port=image_port, cv_port=cv_port, llm_port=llm_port, database_port=database_port, boot_time=boot_time, 
                        camera=camera, database=database, computer_vision=computer_vision, llm=llm, name="MainComputer")

    env.process(computer.workflow(camera, computer_vision, database, llm))
    env.run(until=100)

if __name__ == "__main__":
    main()