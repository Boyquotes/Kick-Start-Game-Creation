extends Control

export(String) var Name = "Bob"
export(int) var Strength
export(int) var Agility
export(int) var Body
export(int) var Charisma
export(int) var Intelligence
export(int) var Willpower

var Health = 0

onready var SkillText = get_node("StatsButtons/SkillText")
var SpendableSkillPoints = 0

export(Array, NodePath) var Enemy

onready var Console = get_node("Box/Console")
# Stuff for things to function
var IsEnemyAlive = false

func _ready():
	for n in Enemy.size():
		Enemy = get_node(Enemy)

func _process(_delta):
	SkillText.text = "Spendable Points: " + str(SpendableSkillPoints)
	if IsEnemyAlive == true:
		Enemy[0].visible = true
	else:
		Enemy[0].visible = false

# these next six functions is for ease-of-updating stats
func _on_Strength_pressed():
	if SpendableSkillPoints >= 1:
		Strength += 1
		SpendableSkillPoints -= 1

func _on_Agility_pressed():
	if SpendableSkillPoints >= 1:
		Agility += 1
		SpendableSkillPoints -= 1

func _on_Body_pressed():
	if SpendableSkillPoints >= 1:
		Body += 1
		SpendableSkillPoints -= 1

func _on_Charisma_pressed():
	if SpendableSkillPoints >= 1:
		Charisma += 1
		SpendableSkillPoints -= 1

func _on_Intelligence_pressed():
	if SpendableSkillPoints >= 1:
		Intelligence += 1
		SpendableSkillPoints -= 1

func _on_Willpower_pressed():
	if SpendableSkillPoints >= 1:
		Willpower += 1
		SpendableSkillPoints -= 1

# If the player Wins :D
func Win():
	Console.text += "You win! " + Enemy[0].EnemyName + " is defeated!\n"
	IsEnemyAlive = false
	SpendableSkillPoints += RandomNumberGenerator.new().randi_range(1, 3)

# If the player Loses d:
func Lose():
	Console.text += "You lose! " + Enemy[0].EnemyName + " defeated you!\n"
	IsEnemyAlive = false

func Checking_Stats():
	Console.text += "Name: " + Name + "\n"
	Console.text += "Strength: " + str(Strength) + "\n"
	Console.text += "Agility: " + str(Agility) + "\n"
	Console.text += "Body: " + str(Body) + "\n"
	Console.text += "Charisma: " + str(Charisma) + "\n"
	Console.text += "Intelligence: " + str(Intelligence) + "\n"
	Console.text += "Willpower: " + str(Willpower) + "\n"

func Find_Enemy():
	if IsEnemyAlive == false:
		IsEnemyAlive = true
		# Healing players because I don't have that yet.
		Heal()
		Enemy[0]._ready()
		Console.text += "You found: " + Enemy[0].EnemyName + "\n"
		
	else:
		Console.text += Enemy.EnemyName + " is waiting for you..." + "\n"

func Attack():
	if IsEnemyAlive == true:
		Enemy[0].EnemyHealth -= Strength
		Health -= Enemy[0].EnemyStrength
		print(Health)
		print(Enemy[0].EnemyHealth)
		if Enemy[0].EnemyHealth <= 0:
			Win()
		elif Health <= 0:
			Lose()

func Chat():
	if IsEnemyAlive == true:
		if Charisma > Enemy[0].EnemyCharisma:
			Win()
		else:
			Lose()

func Heal():
	Health = Body
