extends Node3D

func _ready() -> void:
	SignalHub.add_scene_at_transform.connect(func(
		at_transform: Transform3D, 
		scene: PackedScene
	):
		var new_instance: Node3D = scene.instantiate()
		new_instance.transform = at_transform
		add_child.call_deferred(new_instance)
	)


