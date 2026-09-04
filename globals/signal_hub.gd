extends Node

signal add_scene_at_transform(at_transform: Transform3D, scene: PackedScene)
signal collected(type: GameDefs.PickupType)
signal update_ui(scores: Dictionary[GameDefs.PickupType, CollectibleScore])
signal show_key
signal level_completed
signal points(amount: int, at: Vector3)
signal score_changed(total: int)
signal player_health_changed(cur: int)

func emit_add_scene_at_transform(at_transform: Transform3D, scene: PackedScene): add_scene_at_transform.emit(at_transform, scene)
func emit_collected(type: GameDefs.PickupType): collected.emit(type)
func emit_update_ui(scores: Dictionary[GameDefs.PickupType, CollectibleScore]): update_ui.emit(scores)
func emit_show_key(): show_key.emit()
func emit_level_completed(): level_completed.emit()
func emit_points(amount: int, at: Vector3): points.emit(amount, at)
func emit_score_changed(total: int): score_changed.emit(total)
func emit_player_health_changed(cur: int): player_health_changed.emit(cur)

