extends Control

var MoneySpent = 0.0
var MoneyGave = 0.0

export var MoneyRequired = 25.0
var MoneyHave = 1000000
# As the game progresses, the person should get only this PERCENTAGE back fron the machine
export var PercentWin = 10.0
# This is a cool feature, innit?
export(bool) var SlotStackingEnabled = true
export var GoldenNumber = 5
var SlotMachineSize = 0
var CurrentSlotMachine = 1

export(Array, NodePath) var SlotMachines

func _ready():
	for n in SlotMachines.size():
		SlotMachines[n] = get_node(SlotMachines[n])
		SlotMachineSize += 1

# The LovelyNumberForRigging is used for how many slots were landed on. Yes, im rigging this :D
func _process(_delta):
	# My guess here is that you must just copy & paste this for it to do fun stuff. Too lazy to simplify it.
	if CurrentSlotMachine >= 2:
		SlotMachines[1].visible = true
	else:
		SlotMachines[1].visible = false
	
	if CurrentSlotMachine >= 3:
		SlotMachines[2].visible = true
	else:
		SlotMachines[2].visible = false

func Rigged(var LovelyNumberForRigging):
	match LovelyNumberForRigging:
		2:
			if (MoneyGave / MoneySpent) < (PercentWin / 100) * 2 or MoneyGave == 0:
				MoneyHave += MoneyRequired
				MoneyGave += MoneyRequired
			else:
				print("Rigged!")
		3:
			if MoneyGave / MoneySpent < PercentWin / 100 or MoneyGave == 0:
				MoneyHave += MoneyRequired * 2
				MoneyGave += MoneyRequired
			else:
				print("Rigged!")
	return

func Jackpot():
	MoneyHave += MoneySpent / 1.25
	MoneySpent = 0
	MoneyGave = 0

func _on_Spinner_pressed():
	# Same thing here, copy and paste it until I find something to make it simpler.
	if CurrentSlotMachine == 1:
		SlotMachines[0].Spin()
	if CurrentSlotMachine == 2:
		SlotMachines[1].Spin()
	if CurrentSlotMachine == 3:
		SlotMachines[2].Spin()
