extends Sprite

export(int) var Strength = 0
export(int) var Health = 0
var ImageNumber = 0
var ItemAssigned = false

export(NodePath) var GoToScript

func UpdateNumbers():
	get_node("Strength").text = str(Strength)
	get_node("Health").text = str(Health)

func SummonEnemy(RandomNumber, RandomNumber2):
	Strength = RandomNumber
	Health = RandomNumber2
	ItemAssigned = true
	UpdateNumbers()
	return
