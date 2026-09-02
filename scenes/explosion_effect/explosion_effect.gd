extends Node3D

@export var audio_stream: AudioStream

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	animation_player.play("run")
	SoundManager.play_3d(audio_stream, global_position)

func _on_animation_player_animation_finished(_anim_name: StringName):
	queue_free()
