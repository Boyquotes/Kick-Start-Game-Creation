extends Control

var Spinning = false

# Put in the lines for where the number for slots are imputed
var NumberOfSlots = 3
onready var SlotLines = [get_node("Left Slot/Text"), get_node("Middle Slot/Text"), get_node("Right Slot/Text")]

onready var GameController = get_parent()

export var TimeItTakesToSpin = 4

var Stopwatch = 0

# Start of the spinning ;D
func Spin():
	if GameController.MoneyHave >= GameController.MoneyRequired:
		GameController.MoneyHave -= GameController.MoneyRequired
		GameController.MoneySpent += GameController.MoneyRequired
		Spinning = true
	
# Middle of the spinning
func _process(delta):
	if Spinning == true:
		Stopwatch += delta
		# ATTENTION! I GOT LAZY AND COPY & PASTED THIS FROM [func StopSpinning()]
		var SlotNumber = 0
		while (SlotNumber != NumberOfSlots):
			SlotNumber += 1
			var RandomNumber = RandomNumberGenerator.new()
			RandomNumber.randomize()
			SlotLines[SlotNumber - 1].text = str(RandomNumber.randi_range(0,5))
	if Stopwatch >= TimeItTakesToSpin:
		Spinning = false
		Stopwatch = 0
		StopSpinning()
		
# End of the spinning :(
func StopSpinning():
	print(GameController.MoneySpent)
	var SlotNumber = 0  
	while (SlotNumber != NumberOfSlots):
		SlotNumber += 1
		var RandomNumber = RandomNumberGenerator.new()
		RandomNumber.randomize()
		SlotLines[SlotNumber - 1].text = str(RandomNumber.randi_range(0,5))
		
	# Check to see if the person WON! This is only 3/3 though, might need re-adjustment
	if GameController.SlotStackingEnabled == true and (SlotLines[0].text == str(GameController.GoldenNumber) and SlotLines[1].text == str(GameController.GoldenNumber) and SlotLines[2].text == str(GameController.GoldenNumber)):
		if GameController.CurrentSlotMachine == GameController.SlotMachineSize:
			GameController.Jackpot()
		else:
			GameController.CurrentSlotMachine += 1
	elif (SlotLines[0].text == SlotLines[2].text) and (SlotLines[0].text == SlotLines[1].text) and (SlotLines[1].text == SlotLines[2].text):
		GameController.Rigged(3)
		if GameController.CurrentSlotMachine != 1:
			GameController.CurrentSlotMachine -= 1
	# This one is 2/3
	elif (SlotLines[0].text == SlotLines[2].text) or (SlotLines[0].text == SlotLines[1].text) or (SlotLines[1].text == SlotLines[2].text):
		GameController.Rigged(2)
		if GameController.CurrentSlotMachine != 1:
			GameController.CurrentSlotMachine -= 1
	print("Money: " + str(GameController.MoneyHave))
