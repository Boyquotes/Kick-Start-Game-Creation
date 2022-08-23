extends KinematicBody2D

var Velocity = Vector2(0, 0)

export var WalkSpeed = 200.0

func _physics_process(_delta):
	Velocity = Vector2(0, 0)
	
	if Input.get_action_raw_strength("Right"):
		Velocity.x = WalkSpeed
	if Input.get_action_raw_strength("Left"):
		Velocity.x = -WalkSpeed
	if Input.get_action_raw_strength("Up"):
		Velocity.y = -WalkSpeed
	if Input.get_action_raw_strength("Down"):
		Velocity.y = WalkSpeed
	
	Velocity = move_and_slide(Velocity)
