extends Node

const POOL_SIZE := 6

var _players: Array[AudioStreamPlayer3D] = []

func _ready():
	for i in POOL_SIZE:
		add_player()

func add_player() -> AudioStreamPlayer3D:
	var player := AudioStreamPlayer3D.new();
	add_child(player)
	_players.append(player)
	return player

func play_3d(stream: AudioStream, pos: Vector3):
	var player: AudioStreamPlayer3D = get_available()
	player.stream = stream
	player.global_position = pos
	player.play()

func get_available() -> AudioStreamPlayer3D:
	for player in _players: 
		if !player.playing: return player
	return add_player()
