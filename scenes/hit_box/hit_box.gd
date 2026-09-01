@tool
class_name HitBox
extends Area3D

@export var shape: Shape3D:
	set(value):
		shape = value
		apply_shape()

@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

signal hit

func apply_shape():
	if collision_shape_3d: collision_shape_3d.shape = shape

func _ready():
	apply_shape()

func _on_body_exited(body: Node3D) -> void:
	hit.emit()
