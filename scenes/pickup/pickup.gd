class_name  Pickup
extends Area3D

@export var collect_sound: AudioStream
@export var points := 0
@export var pickup_type := GameDefs.PickupType.NONE

func _enter_tree():
	add_to_group(GameDefs.GROUP_PICKUP)

func _ready():
	if pickup_type == GameDefs.PickupType.LEVEL_KEY: 
		monitoring = false
		hide()
		SignalHub.show_key.connect(func(): 
			set_monitoring.call_deferred(true)
			show()
		)

func _on_body_entered(body: Node3D):
	if body is Granny:
		if collect_sound:
			SoundManager.play_3d(collect_sound, global_position)
		SignalHub.emit_collected(pickup_type)
		SignalHub.emit_points(points, global_position)
		queue_free()
