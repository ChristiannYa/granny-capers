class_name Granny
extends CharacterBody3D

const _GRAVITY := -30

@onready var land_sound: AudioStreamPlayer = $LandSound

## Tracks whether on the previous frame we were on the floor or not
var _last_on_floor := false

func _physics_process(delta: float):
	apply_gravity(delta)
	move_and_slide()
	check_landing()

func apply_gravity(delta: float):
	velocity.y += _GRAVITY * delta

func check_landing():
	if !_last_on_floor and is_on_floor():
		land_sound.play()

	_last_on_floor = is_on_floor()
