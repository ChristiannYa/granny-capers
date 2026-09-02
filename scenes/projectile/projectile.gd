class_name Projectile
extends Node3D

@export var gravity := 1.0
@export var speed := 4.0
@export var spin_speed := 16.0
@export var explosion_scene: PackedScene

var _velocity := Vector3.ZERO

func _ready():
	# Negative because Granny is facing the opposite z direction
	_velocity = -global_transform.basis.z * speed

func _physics_process(delta: float):
	_velocity.y += -(gravity * delta)
	global_position += _velocity * delta
	rotate_object_local(-Vector3.RIGHT, spin_speed * delta)


func _on_hit_box_hit():
	SignalHub.emit_add_scene_at_transform(global_transform, explosion_scene)
	queue_free()
