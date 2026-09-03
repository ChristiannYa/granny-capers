extends Control

@onready var score: UiCollected = $Container/Pickups/Score
@onready var coins: UiCollected = $Container/Pickups/Coins
@onready var jewels: UiCollected = $Container/Pickups/Jewels
@onready var key: TextureRect = $Container/Key

func _ready():
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

	ScoreManager.start_level()
