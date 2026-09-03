extends Node

signal add_scene_at_transform(at_transform: Transform3D, scene: PackedScene)
signal collected(type: GameDefs.PickupType)
signal update_ui(scores: Dictionary[GameDefs.PickupType, CollectibleScore])
signal show_key

func emit_add_scene_at_transform(at_transform: Transform3D, scene: PackedScene):
	add_scene_at_transform.emit(at_transform, scene)

func emit_collected(type: GameDefs.PickupType):
	collected.emit(type)

func emit_update_ui(scores: Dictionary[GameDefs.PickupType, CollectibleScore]):
	update_ui.emit(scores)

func emit_show_key():
	show_key.emit()

