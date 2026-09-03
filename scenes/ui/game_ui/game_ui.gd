extends Control

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
	ScoreManager.start_level()
