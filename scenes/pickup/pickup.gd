extends Area3D

@export var collect_sound: AudioStream
@export var points := 0
 
func _on_body_entered(body: Node3D) -> void:
	if body is Granny:
		if collect_sound:
			SoundManager.play_3d(collect_sound, global_position)
		queue_free()
