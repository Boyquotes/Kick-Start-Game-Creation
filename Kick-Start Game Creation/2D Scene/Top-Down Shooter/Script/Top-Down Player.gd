extends KinematicBody2D

var Speed = 100
export(PackedScene) var Bullet
onready var Scene = get_parent()

var Velocity = Vector2(0, 0)

# Walk, damn it!
func _physics_process(_delta):
	look_at(get_global_mouse_position())
	
	Velocity = Vector2(0, 0)
	
	if Input.get_action_strength("Left"):
		Velocity += Vector2(-Speed, 0)
	if Input.get_action_strength("Up"):
		Velocity += Vector2(0, -Speed)
	if Input.get_action_strength("Down"):
		Velocity += Vector2(0, Speed)
	if Input.get_action_strength("Right"):
		Velocity += Vector2(Speed, 0)
		
	Velocity = move_and_slide(Velocity)	
	if Input.is_action_just_pressed("Click"):
		var b = Bullet.instance()
		owner.add_child(b)
		b.transform = $Muzzle.global_transform
