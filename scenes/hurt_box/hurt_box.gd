class_name HurtBox
extends Area3D

@export var health: Health
@export var shape: Shape3D:
	set(value):
		shape = value
		apply_shape()

@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D


func _ready():
	apply_shape()

func apply_shape():
	if collision_shape_3d: collision_shape_3d.shape = shape

func _on_area_entered(area: Area3D) -> void:
	if area is HitBox:
		print("(HurtBox) damage=", area.damage)
		if health:
			health.take_damage(area.damage)
