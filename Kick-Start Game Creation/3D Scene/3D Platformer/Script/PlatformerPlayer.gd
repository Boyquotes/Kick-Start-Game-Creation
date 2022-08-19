extends KinematicBody

export(float) var Speed = 8.0
export(float) var Gravity = 4.0
export(float) var JumpStrength = 50.0

export(bool) var CanRun = true
export(float) var RunMultiplier = 1.5

export(bool) var UsableMoney = true
export(float) var Money

export(bool) var CanAirJump
export(int) var MaxAirJumps
var CurrentAirJumps = 0

export(float) var MaxZoomIn = 0.0
export(float) var MaxZoomOut = 20.0

var Velocity = Vector3(0, 0, 0)
var CameraMovement = Vector3(0, 0, 0)

onready var Animator = get_node("AnimationPlayer")

onready var Axis = get_node("RotationAxis")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Animator.play("Idle")

func _input(event):
	if event is InputEventMouseMotion:
		self.rotate_y(-deg2rad(event.relative.x))
		Axis.rotate_x(-deg2rad(event.relative.y))
		if Axis.rotation_degrees.x >= 80:
			Axis.rotation_degrees.x = 80
		if Axis.rotation_degrees.x <= -80:
			Axis.rotation_degrees.x = -80
	if Input.get_action_strength("Zoom_In"):
		if Axis.get_node("Camera").translation.z > MaxZoomIn:
			Axis.get_node("Camera").translation.z -= 2
	if Input.get_action_strength("Zoom_Out"):
		if Axis.get_node("Camera").translation.z < MaxZoomOut:
			Axis.get_node("Camera").translation.z += 2

func _physics_process(_delta):
	# WHY DOES THIS WORK BUT THE OTHER SH*T DESIDES TO GO _spin_ LIKE WHAT!? sorry for stealing code, I really tried.
	Velocity = Vector3((Input.get_action_strength("Right") - Input.get_action_strength("Left")), Velocity.y, (Input.get_action_strength("Down") - Input.get_action_strength("Up")))
	Velocity = Velocity.rotated(Vector3.UP, self.global_transform.basis.get_euler().y)
	
	if Input.get_action_strength("Right") == 1 or Input.get_action_strength("Left") == 1 or Input.get_action_strength("Down") == 1 or Input.get_action_strength("Up") == 1:
		Animator.play("Walk")
		Animator.playback_speed = 1
	else:
		Animator.play("Idle")
		Animator.playback_speed = 1
	# Basically walk but run when that happens.
	Velocity = Vector3(Velocity.x * Speed, Velocity.y, Velocity.z * Speed)
	if Input.get_action_strength("Run"):
		Velocity = Vector3(Velocity.x * RunMultiplier, Velocity.y, Velocity.z * RunMultiplier)
		Animator.playback_speed = 2
	
	#Jumping
	if Input.is_action_just_pressed("Jump3D") and is_on_floor():
		Velocity.y = JumpStrength
	# Air Jumps
	if Input.is_action_just_pressed("Jump3D") and CanAirJump == true and CurrentAirJumps != MaxAirJumps:
		CurrentAirJumps += 1
		Velocity.y = JumpStrength
	
	if is_on_floor():
		CurrentAirJumps = 0
	# Gravity
	Velocity.y -= Gravity
	
	Velocity = move_and_slide(Velocity, Vector3.UP)

func Die():
	Animator.stop()
	get_node("Visual").queue_free()
	Speed = 0
	get_node("CPUParticles").emitting = true
