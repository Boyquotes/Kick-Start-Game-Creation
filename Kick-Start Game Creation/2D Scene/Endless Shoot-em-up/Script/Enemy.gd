extends Area2D

var Speed = 100

func _on_Enemy_body_entered(body):
	if body.name == "Player":
		body.queue_free()

func _physics_process(delta):
	position += Vector2(0, Speed * delta)
