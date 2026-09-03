class_name  Pickup
extends Area3D

@export var collect_sound: AudioStream
@export var points := 0
@export var pickup_type := GameDefs.PickupType.NONE

func _enter_tree():
	add_to_group(GameDefs.GROUP_PICKUP)

func _on_body_entered(body: Node3D):
	if body is Granny:
		if collect_sound:
			SoundManager.play_3d(collect_sound, global_position)
		SignalHub.emit_collected(pickup_type)
		queue_free()
