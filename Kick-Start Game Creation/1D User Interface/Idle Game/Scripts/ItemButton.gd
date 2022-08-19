extends Control

export var PriceOfItem = 1.0
export var PriceMultiplier = 1.1
# Amount of IPS that the TotalIPS variable gets.
export var AddedIPS = 1.0
onready var Game = get_node("/root/Idle Game Example")

var InvisibleBoughtAmount = 0
var InvisibleUpgradeVariable = 1

func _ready():
	get_node("Button/RichTextLabel").text = "Cost: " + str(round(PriceOfItem))

func _on_Self_pressed():
	if Game.Score >= PriceOfItem:
		Game.AddIPS(AddedIPS, PriceOfItem)
		PriceOfItem = PriceOfItem * PriceMultiplier
		get_node("Button/RichTextLabel").text = "Cost: " + str(round(PriceOfItem))
		InvisibleBoughtAmount += AddedIPS
		
func Upgrades():
	Game.AddIPS(InvisibleBoughtAmount, 100)
	InvisibleBoughtAmount += InvisibleBoughtAmount
	get_node("Button/Upgrades/Upgrade" + str(InvisibleUpgradeVariable)).disabled = true
	InvisibleUpgradeVariable += 1
	AddedIPS = AddedIPS * 2
