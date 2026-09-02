@tool
extends PathFollow3D

@export var speed := 2.0
@export var bounce := true

var _dir := 1

func _ready():
	if bounce: loop = false

func _physics_process(delta: float):
	progress += speed * _dir * delta
	
	if !bounce: return

	if progress_ratio > 0.99 and _dir == 1: _dir = -1
	if progress_ratio < 0.01 and _dir == -1: _dir = 1
