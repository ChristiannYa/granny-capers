extends Node3D

@export var score_effect_scene: PackedScene

func _ready() -> void:
	SignalHub.add_scene_at_transform.connect(func(
		at_transform: Transform3D, 
		scene: PackedScene
	):
		var new_instance: Node3D = scene.instantiate()
		new_instance.transform = at_transform
		add_child.call_deferred(new_instance)
	)
	SignalHub.points.connect(func(amount: int, at: Vector3):
		if score_effect_scene: spawn_score_effect.call_deferred(amount, at)
	)

func spawn_score_effect(amount: int, at: Vector3):
	var new_score_effect: Label3D = score_effect_scene.instantiate()
	new_score_effect.position = at
	new_score_effect.text = "+%d" % amount
	add_child(new_score_effect)

