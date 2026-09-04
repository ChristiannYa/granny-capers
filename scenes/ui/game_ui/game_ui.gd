extends Control

@onready var score: UiCollected = $Container/Pickups/Score
@onready var coins: UiCollected = $Container/Pickups/Coins
@onready var jewels: UiCollected = $Container/Pickups/Jewels
@onready var key: TextureRect = $Container/Key
@onready var hearts_con: HBoxContainer = $Container/HeartsContainer

var _hearts: Array[TextureRect] = []

func _ready():
	for child in hearts_con.get_children():
		if child is TextureRect: _hearts.append(child)

	SignalHub.update_ui.connect(func(
		scores: Dictionary[GameDefs.PickupType, CollectibleScore]
	):
		coins.set_amount(str(scores[GameDefs.PickupType.COIN]))
		jewels.set_amount(str(scores[GameDefs.PickupType.JEWEL]))
	)
	SignalHub.show_key.connect(func(): key.show())
	SignalHub.level_completed.connect(func(): 
		get_tree().paused = true
	)
	SignalHub.score_changed.connect(func(total: int):
		score.set_amount(str(total))
	)
	SignalHub.player_health_changed.connect(func(cur: int):
		for ind in _hearts.size():
			_hearts[ind].visible = cur > ind
	)

	ScoreManager.start_level()
