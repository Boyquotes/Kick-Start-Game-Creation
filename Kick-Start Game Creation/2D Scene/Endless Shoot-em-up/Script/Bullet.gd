extends Area2D

var speed = 750

func _physics_process(delta):
	position += -transform.y * speed * delta

func _on_Bullet_area_entered(area):
	if area.collision_layer == 3: #put thing to kill here
		area.queue_free()
		queue_free()
