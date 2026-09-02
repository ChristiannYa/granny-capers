extends Node3D

@export var audio_stream: AudioStream

func _ready() -> void:
	SoundManager.play_3d(audio_stream, global_position)
	queue_free()

