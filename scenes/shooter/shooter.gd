class_name Shooter
extends Node3D

@export var projectile_scene: PackedScene
@export var stream_adj: AudioStream
@export var volume_db_adj := 0.0

@onready var shoot_sound: AudioStreamPlayer3D = $ShootSound

func _ready() -> void:
	shoot_sound.stream = stream_adj
	shoot_sound.volume_db += volume_db_adj
	
func shoot():
	shoot_sound.play()
	var new_projectile: Projectile = projectile_scene.instantiate()
	add_child(new_projectile)
 
