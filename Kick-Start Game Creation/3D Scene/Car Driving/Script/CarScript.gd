extends VehicleBody

onready var Car = get_node(".")
export(float) var Speed = 100
export(float) var TurningSpeed = 10

func _physics_process(delta):
	self.steering = Input.get_axis("Right", "Left") * TurningSpeed
	self.engine_force = Input.get_axis("Down", "Up") * Speed
