class_name Granny
extends CharacterBody3D

const _GRAVITY := -30.0
const _FALL_GRAVITY := -55.0
const _ROTATE_LERP := 8.0
const _SPEED := 5.0
const _DECELERATION := 30.0
const _JUMP_VELOCITY := 12.5
const _CAM_ROTATION_SPEED := PI
const _CAM_TILT_MAX := 45.0
const _CAM_TILT_HEIGHT := 12.0
const _CAM_TILT_LERP := 0.9

@onready var jump_sound: AudioStreamPlayer = $JumpSound
@onready var land_sound: AudioStreamPlayer = $LandSound
@onready var walk_sound: AudioStreamPlayer = $WalkSound
@onready var debug_label: Label3D = $DebugLabel
@onready var camera_controller: Node3D = $CameraController
@onready var granny: Node3D = $Granny
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var shooter: Shooter = $Granny/Shooter

## Tracks whether on the previous frame we were on the floor or not
var _last_on_floor := false
var _cam_base_tilt := 0.0
var _ground_y := 0.0

var is_moving: bool:
	get: return !Vector2(velocity.x, velocity.z).is_zero_approx()

var is_falling: bool:
	get: return velocity.y < 0.0

var is_throwing: bool:
	get: return animation_tree.get("parameters/Ground/InvokeThrow/active")

func _ready():
	_cam_base_tilt = camera_controller.rotation.x
	_ground_y = global_position.y

func _physics_process(delta: float):
	apply_gravity(delta)
	handle_jump()
	handle_movement(delta)
	handle_camera(delta)
	follow_camera()
	update_camera_tilt(delta)
	move_and_slide()
	check_landing()
	update_walk_sound()
	handle_throw()

func handle_camera(delta: float):
	var cam_turn: float = Input.get_axis("cam_right", "cam_left")
	debug_label.text += "\ncam: %.2f" % cam_turn
	camera_controller.rotate_y(cam_turn * delta * _CAM_ROTATION_SPEED)

func follow_camera():
	camera_controller.global_position = camera_controller.global_position.lerp(global_position, 0.3)

func update_camera_tilt(delta: float):
	var height: float = maxf(0.0, global_position.y - _ground_y)
	var t: float = clampf(height / _CAM_TILT_HEIGHT, 0.0, 1.0)
	var targ: float = _cam_base_tilt - deg_to_rad(_CAM_TILT_MAX) * t
	camera_controller.rotation.x = lerpf(camera_controller.rotation.x, targ, delta * _CAM_TILT_LERP)

func handle_movement(delta: float):
	var input_dir: Vector2 = Input.get_vector("m_left", "m_right", "m_fwd", "m_back")
	var dir := camera_controller.basis * Vector3(input_dir.x, 0.0, input_dir.y)
	debug_label.text = ("input: (%.1v)\n" + "dir: (%.1v)") % [ 
		input_dir, dir
	]

	# Check if Granny changed facing direction
	if dir.length() > 0.01:
		granny.rotation.y = lerp_angle(
			granny.rotation.y, 
			# `atan2()`'s args are negated because Granny is facing in the opposite direction
			# of the z axis
			atan2(-dir.x, -dir.z), 
			delta * _ROTATE_LERP
		)

		velocity.x = dir.x * _SPEED
		velocity.z = dir.z * _SPEED
	else:
		# Stops Granny from moving continiously
		velocity.x = move_toward(velocity.x, 0.0, _DECELERATION * delta)
		velocity.z = move_toward(velocity.z, 0.0, _DECELERATION * delta)

func handle_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = _JUMP_VELOCITY
		jump_sound.play()

func apply_gravity(delta: float):
	velocity.y += (_FALL_GRAVITY if velocity.y < 0.0 else _GRAVITY) * delta

func check_landing():
	if !_last_on_floor and is_on_floor(): land_sound.play()
	if is_on_floor(): _ground_y = global_position.y
	_last_on_floor = is_on_floor()

func update_walk_sound():
	var walking: bool = is_moving and is_on_floor()
	if walking and !walk_sound.playing: walk_sound.play()
	elif !walking and walk_sound.playing: walk_sound.stop()

func handle_throw():
	if Input.is_action_just_pressed("shoot") and is_on_floor() and !is_throwing:
		animation_tree.set(
			"parameters/Ground/InvokeThrow/request", 
			AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
		)

func fire_projectile():
	shooter.shoot()
