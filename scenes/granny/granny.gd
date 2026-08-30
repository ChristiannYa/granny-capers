class_name Granny
extends CharacterBody3D

const _GRAVITY := -30
const _ROTATE_LERP := 8.0

@onready var land_sound: AudioStreamPlayer = $LandSound
@onready var debug_label: Label3D = $DebugLabel
@onready var body: MeshInstance3D = $Body

## Tracks whether on the previous frame we were on the floor or not
var _last_on_floor := false

func _physics_process(delta: float):
	apply_gravity(delta)
	handle_movement(delta)
	move_and_slide()
	check_landing()

func handle_movement(delta: float):
	var input_dir: Vector2 = Input.get_vector("m_left", "m_right", "m_fwd", "m_back")
	var dir := Vector3(input_dir.x, 0.0, input_dir.y)
	debug_label.text = ("input: (%.1v)\n" + "dir: (%.1v)") % [ 
		input_dir, dir
	]

	# Check if Granny changed facing direction
	if dir.length() > 0.01:
		body.rotation.y = lerp_angle(
			body.rotation.y, 
			# `atan2()`'s args are negated because Granny is facing in the opposite direction
			# of the z axis
			atan2(-dir.x, -dir.z), 
			delta * _ROTATE_LERP
		)

func apply_gravity(delta: float):
	velocity.y += _GRAVITY * delta

func check_landing():
	if !_last_on_floor and is_on_floor():
		land_sound.play()

	_last_on_floor = is_on_floor()
