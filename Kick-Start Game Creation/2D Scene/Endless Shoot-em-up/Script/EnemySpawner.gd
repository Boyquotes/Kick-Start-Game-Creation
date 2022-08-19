extends Node2D

export(PackedScene) var Enemy
var timer1 = 0.0
var RNG

func _ready():
	RNG = RandomNumberGenerator.new()
	RNG.randomize()

func _process(delta):
	timer1 += delta
	if timer1 >= 5:
		timer1 = 0
		var thing = Enemy.instance()
		owner.add_child(thing)
		thing.position = self.position + Vector2(RNG.randf_range(-200, 200), 0)
