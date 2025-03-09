import unittest
import simpy
from LLM import LLM
from Database import Database
from Computer import Computer
from CameraSystem import Camera
from ComputerVision import ComputerVision
from CommunicationPorts import HardwarePort, NetworkPort

class TestComponentFailures(unittest.TestCase):
    def setUp(self):
        self.env = simpy.Environment()
        
        self.image_port = HardwarePort(env=self.env, name="CameraDataPort", transfer_time_s=0.5)
        self.cv_port = NetworkPort(env=self.env, name="CVDataPort", transfer_time_s=1.5)
        self.llm_port = NetworkPort(env=self.env, name="LLMDataPort", transfer_time_s=1.5)
        self.database_port = NetworkPort(env=self.env, name="DatabaseDataPort", transfer_time_s=1.5)
        
        self.capture_time = 1
        self.camera = Camera(env=self.env, capture_time=self.capture_time, image_port=self.image_port, name="FoodCamera")
        
        self.bus_delay = 1
        self.database = Database(env=self.env, name="Database", bus_delay=self.bus_delay, database_port=self.database_port)
        
        self.preprocesing_time = 1
        self.detection_time = 1
        self.classification_time = 1
        self.computer_vision = ComputerVision(env=self.env, name="ComputerVision", preprocesing_time=self.preprocesing_time, 
                                              detection_time=self.detection_time, classification_time=self.classification_time,
                                              cv_port=self.cv_port, database=self.database)
        
        self.recipe_creation_time = 10
        self.llm = LLM(env=self.env, name="LLM", recipe_creation_time=self.recipe_creation_time, llm_port=self.llm_port, database=self.database)

        self.boot_time = 10
        self.computer = Computer(env=self.env, image_port=self.image_port, cv_port=self.cv_port, llm_port=self.llm_port, database_port=self.database_port, 
                                 boot_time=self.boot_time, camera=self.camera, database=self.database, computer_vision=self.computer_vision, llm=self.llm, 
                                 name="MainComputer")

    def test_camera_failure(self):
        def camera_failure(env, camera):
            yield env.timeout(5)
            def fail_capture_frame():
                yield env.timeout(5)
            camera.capture_frame = fail_capture_frame

        self.env.process(camera_failure(self.env, self.camera))
        self.env.process(self.computer.workflow(self.camera, self.computer_vision, self.database, self.llm))
        self.env.run(until=100)
        
        self.assertTrue(self.computer.boot_finished_event.triggered)
        self.assertFalse(self.computer.image_received_event.triggered) 
        print("Camera failure test passed\n\n\n")
        
    def test_database_failure(self):
        def database_failure(env, database):
            yield env.timeout(5)
            def fail_receive_data(data_type):
                yield env.timeout(5)
            self.llm.database.send_data = fail_receive_data

        self.env.process(database_failure(self.env, self.database))
        self.env.process(self.computer.workflow(self.camera, self.computer_vision, self.database, self.llm))
        self.env.run(until=100)
        
        self.assertTrue(self.computer.boot_finished_event.triggered)
        self.assertTrue(self.computer.image_received_event.triggered)
        self.assertFalse(self.computer.image_classification_received_event.triggered)
        print("Database failure test passed\n\n\n")
      
    def test_llm_failure(self):
        def llm_failure(env, llm):
            yield env.timeout(5)
            def fail_create_recipe():
                yield env.timeout(5)
            llm.create_recipe = fail_create_recipe

        self.env.process(llm_failure(self.env, self.llm))
        self.env.process(self.computer.workflow(self.camera, self.computer_vision, self.database, self.llm))
        self.env.run(until=100)
        
        self.assertTrue(self.computer.boot_finished_event.triggered)
        self.assertTrue(self.computer.image_received_event.triggered)
        self.assertTrue(self.computer.image_classification_received_event.triggered)
        self.assertTrue(self.computer.llm_recipe_request_event.triggered)
        self.assertFalse(self.computer.llm_recipe_received_event.triggered) 
        print("LLM failure test passed\n\n\n")
        
if __name__ == "__main__":
    unittest.main()