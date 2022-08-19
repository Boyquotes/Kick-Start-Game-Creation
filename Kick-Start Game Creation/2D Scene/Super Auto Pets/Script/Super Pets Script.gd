extends Node2D

export(Array) var PetSlots = []
export(Array) var ShopSlots = []
export(Array) var BuffSlots = []
export(int) var TexturesAmount = 3

export(Array) var AttackSlots = []
export(Array) var EnemySlots = []

export(NodePath) var BasePath
export(NodePath) var AttackPath

var RNG

func _ready():
	BasePath = get_node(BasePath)
	AttackPath = get_node(AttackPath)
	
	for n in PetSlots.size():
		PetSlots[n] = get_node(PetSlots[n])
	for n in ShopSlots.size():
		ShopSlots[n] = get_node(ShopSlots[n])
	for n in BuffSlots.size():
		BuffSlots[n] = get_node(BuffSlots[n])
	for n in AttackSlots.size():
		AttackSlots[n] = get_node(AttackSlots[n])
	for n in EnemySlots.size():
		EnemySlots[n] = get_node(EnemySlots[n])
	
	RNG = RandomNumberGenerator.new()
	RNG.randomize()
	
	RandomizeShop()

func RandomizeShop():
	for n in ShopSlots.size():
		var TextureNumber = RNG.randi_range(1, TexturesAmount)
		
		ShopSlots[n].Strength = RNG.randi_range(1, 9)
		ShopSlots[n].Health = RNG.randi_range(1, 9)
		ShopSlots[n].ItemAssigned = true
		ShopSlots[n].texture = load("res://2D Scene/Super Auto Pets/Textures/" + str(TextureNumber) + ".jpg")
		ShopSlots[n].ImageNumber = TextureNumber
		ShopSlots[n].UpdateNumbers()
	for n in BuffSlots.size():
		BuffSlots[n].Strength = RNG.randi_range(1, 9)
		BuffSlots[n].Health = RNG.randi_range(1, 9)
		BuffSlots[n].ItemAssigned = true
		BuffSlots[n].UpdateNumbers()

func SellPet(Strength, Health):
	for n in PetSlots.size():
		if PetSlots[n].Strength == Strength and PetSlots[n].Health == Health:
			PetSlots[n].Strength = 0
			PetSlots[n].Health = 0
			PetSlots[n].ItemAssigned = false
	return

func BuyPet(Strength, Health, ImageNumber):
	for n in PetSlots.size():
		if PetSlots[n].ItemAssigned == false:
			PetSlots[n].ItemAssigned = true
			PetSlots[n].Strength = Strength
			PetSlots[n].Health = Health
			PetSlots[n].ImageNumber = ImageNumber
			PetSlots[n].texture = load("res://2D Scene/Super Auto Pets/Textures/" + str(ImageNumber) + ".jpg")
			PetSlots[n].UpdateNumbers()
			break
	return

func BuyBuff(Strength, Health):
	var SlotGet = 1
	var BuyableBuff = false
	for n in PetSlots.size():
		if PetSlots[n].ItemAssigned == true:
			BuyableBuff = true
	while BuyableBuff == true:
		SlotGet = RNG.randi_range(1, PetSlots.size())
		if PetSlots[SlotGet - 1].ItemAssigned == true:
			PetSlots[SlotGet - 1].Strength += Strength
			PetSlots[SlotGet - 1].Health += Health
			PetSlots[SlotGet - 1].UpdateNumbers()
			return true
	return false
	
func Attack():
	for n in AttackSlots.size():
		if PetSlots[n].ItemAssigned == true:
			AttackSlots[n].Strength = PetSlots[n].Strength
			AttackSlots[n].Health = PetSlots[n].Health
			AttackSlots[n].texture = load("res://2D Scene/Super Auto Pets/Textures/" + str(PetSlots[n].ImageNumber) + ".jpg")
			AttackSlots[n].UpdateNumbers()
			AttackSlots[n].ItemAssigned = true
	for n in EnemySlots.size():
		var Random = RNG.randi_range(1, 100)
		if Random >= 20:
			Random = RNG.randi_range(1, 9)
			var Random2 = RNG.randi_range(1, 9)
			print("Summoning")
			EnemySlots[n].SummonEnemy(Random, Random2)
	BasePath.visible = false
	AttackPath.visible = true

func Murder():
	for n in AttackSlots.size():
		if AttackSlots[n].ItemAssigned == true:
			for x in EnemySlots.size():
				if EnemySlots[x].ItemAssigned == true:
					EnemySlots[x].Health -= AttackSlots[n].Strength
					AttackSlots[n].Health -= EnemySlots[x].Strength
					EnemySlots[x].UpdateNumbers()
					AttackSlots[n].UpdateNumbers()
					if EnemySlots[x].Health <= 0:
						EnemySlots[x].ItemAssigned = false
					if AttackSlots[n].Health <= 0:
						AttackSlots[n].ItemAssigned = false
					CheckDead()
					return
					
func CheckDead():
	var AttackDead = 0
	var EnemyDead = 0
	for n in AttackSlots.size():
		if AttackSlots[n].ItemAssigned == false:
			AttackDead += 1
	for n in EnemySlots.size():
		if EnemySlots[n].ItemAssigned == false:
			EnemyDead += 1
	if EnemyDead == 5:
		AttackPath.visible = false
		BasePath.visible = true
		print("Win")
	if AttackDead == 5:
		AttackPath.visible = false
		BasePath.visible = true
		print("Lose")
