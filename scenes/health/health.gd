class_name Health
extends Node

@export var max_health := 10

signal health_changed(cur: int)
signal died

var _cur_health: int

func _ready():
	_cur_health = max_health

func take_damage(value: int):
	if value <= 0: return
	set_health(_cur_health - value)

func set_health(value: int):
	_cur_health = clampi(value, 0, max_health)
	print("Health=", _cur_health, "/", max_health)
	health_changed.emit(_cur_health)
	if _cur_health == 0:
		print("Out of health!")
		died.emit()
