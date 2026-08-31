class_name Granny
extends CharacterBody3D

const _GRAVITY := -30
const _ROTATE_LERP := 8.0
const _SPEED := 5.0
const _DECELERATION := 30.0
const _JUMP_VELOCITY := 12.5
const _CAM_ROTATION_SPEED := PI

@onready var jump_sound: AudioStreamPlayer = $JumpSound
@onready var land_sound: AudioStreamPlayer = $LandSound
@onready var debug_label: Label3D = $DebugLabel
@onready var body: MeshInstance3D = $Body
@onready var camera_controller: Node3D = $CameraController

## Tracks whether on the previous frame we were on the floor or not
var _last_on_floor := false

func _physics_process(delta: float):
	apply_gravity(delta)
	handle_jump()
	handle_movement(delta)
	handle_camera(delta)
	move_and_slide()
	check_landing()

func handle_camera(delta: float):
	var cam_turn: float = Input.get_axis("cam_right", "cam_left")
	debug_label.text += "\ncam: %.2f" % cam_turn
	camera_controller.rotate_y(cam_turn * delta * _CAM_ROTATION_SPEED)

func handle_movement(delta: float):
	var input_dir: Vector2 = Input.get_vector("m_left", "m_right", "m_fwd", "m_back")
	var dir := camera_controller.basis * Vector3(input_dir.x, 0.0, input_dir.y)
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

		velocity.x = dir.x * _SPEED
		velocity.z = dir.z * _SPEED
	else:
		# print("else") # This block is always running...
		# Stops Granny from moving continiously
		velocity.x = move_toward(velocity.x, 0.0, _DECELERATION * delta)
		velocity.z = move_toward(velocity.z, 0.0, _DECELERATION * delta)

func handle_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = _JUMP_VELOCITY
		jump_sound.play()

func apply_gravity(delta: float):
	velocity.y += _GRAVITY * delta

func check_landing():
	if !_last_on_floor and is_on_floor():
		land_sound.play()

	_last_on_floor = is_on_floor()
