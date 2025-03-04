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
    
    boot_time = 10
    computer = Computer(env=env, image_port=image_port, cv_port=cv_port, llm_port=llm_port, database_port=database_port, boot_time=boot_time,
                        name="MainComputer")
    
    capture_time = 1
    camera = Camera(env=env, capture_time=capture_time, image_port=image_port, name="FoodCamera")
    
    preprocesing_time=1
    detection_time=1
    classification_time=1
    computer_vision = ComputerVision(env=env, name="ComputerVision", preprocesing_time=preprocesing_time, 
                                     detection_time=detection_time, classification_time=classification_time,
                                     cv_port=cv_port)
    

    bus_delay = 1
    database = Database(env=env, name="Database", bus_delay=bus_delay, database_port=database_port)
    
    recipe_creation_time = 10
    llm = LLM(env=env, name="LLM", recipe_creation_time=recipe_creation_time, llm_port=llm_port, database_port=database_port)

    def camera_workflow_after_boot(env: Environment, computer: Computer, camera: Camera):
        yield env.process(computer.boot_process())
        yield env.process(computer.request_image_data())
        yield env.process(camera.caputure_and_send_workflow())
        yield env.process(computer.receive_image_data())
        yield env.process(computer.request_image_classification())
        yield env.process(computer_vision.recieve_and_proccess_workflow())
        yield env.process(computer.receive_image_classification())
        yield env.process(computer.upload_image_classification())
        yield env.process(database.recieve_data("Image classification"))
        yield env.process(computer.request_llm_data())
        yield env.process(llm.receive_recipe_request())
        yield env.process(llm.request_ingredient_manifest())
        yield env.process(database.send_data("ingredient manifest"))
        yield env.process(llm.recieve_ingredient_manifest())
        yield env.process(llm.create_recipe_send())
        yield env.process(computer.receive_llm_data())

    env.process(camera_workflow_after_boot(env, computer, camera))
    env.run(until=50)

if __name__ == "__main__":
    main()