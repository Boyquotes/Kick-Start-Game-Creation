extends KinematicBody2D

export var Speed = 10000
var attack = false
var Player = null
export var Health = 1

func _on_Follow_area_entered(area):
	if area.name == "Player":
		Player = area
		attack = true

func _physics_process(delta):
	if attack == true:
		var movement = position.direction_to(Player.position) * Speed * delta
		movement = move_and_slide(movement)
	if Health == 0:
		self.queue_free()

func _on_Follow_area_exited(body):
	if body.name == "Player":
		attack = false

func _on_EnemyCollider_body_entered(body):
	body.queue_free()
