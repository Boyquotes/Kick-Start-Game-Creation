extends Area2D

var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	if body.name == "Enemy": # put thing to kill here
		body.queue_free()
	queue_free()
