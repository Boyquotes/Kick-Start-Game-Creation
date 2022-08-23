extends Sprite

export(String) var EnemyName = "Jack"
export(int) var EnemyStrength = 5
export(int) var EnemyAgility = 5
export(int) var EnemyBody = 5
export(int) var EnemyCharisma = 5
export(int) var EnemyIntelligence = 5
export(int) var EnemyWillpower = 5

var EnemyHealth = 0

export(Texture) var FullHealth
export(Texture) var HalfHealth

func _ready():
	EnemyHealth = EnemyBody

func _process(_delta):
	if EnemyHealth <= (EnemyBody / 2):
		self.texture = HalfHealth
	else:
		self.texture = FullHealth
