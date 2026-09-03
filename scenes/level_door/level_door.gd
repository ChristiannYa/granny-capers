extends Node3D

@onready var missing_key_sound: AudioStreamPlayer = $MissingKeySound
@onready var missing_key_label: Label3D = $MissingKeyLabel

var _can_enter := false
var _completed := false

func _ready():
	SignalHub.collected.connect(func(type: GameDefs.PickupType):
		if type == GameDefs.PickupType.LEVEL_KEY: _can_enter = true
	)

func _on_player_detect_body_entered(body: Node3D) -> void:
	if body is not Granny or _completed: return
	if !_can_enter:
		show_need_key()
		return
	_completed = true
	SignalHub.emit_level_completed()

func show_need_key():
	if missing_key_label.visible: return
	missing_key_sound.play()
	missing_key_label.show()
	await get_tree().create_timer(3.0, false).timeout
	missing_key_label.hide()
