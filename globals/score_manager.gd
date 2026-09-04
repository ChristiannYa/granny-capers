extends Node

var _scores: Dictionary[GameDefs.PickupType, CollectibleScore] = {}
var _points := 0

func _ready():
	SignalHub.collected.connect(func (type: GameDefs.PickupType):
		if not _scores.has(type): return
		_scores[type].inc()
		SignalHub.emit_update_ui(_scores)
		if type == GameDefs.PickupType.JEWEL and _scores[type].has_all():
			SignalHub.emit_show_key()
	)
	SignalHub.points.connect(func(amount: int, _at: Vector3):
		_points += amount
		SignalHub.emit_score_changed(_points)
	)

func start_level():
	count_pickups()
	SignalHub.emit_update_ui(_scores)
	SignalHub.emit_score_changed(_points)

func count_pickups():
	for type in GameDefs.PickupType.values():
		_scores[type] = CollectibleScore.new()
	
	for node in get_tree().get_nodes_in_group(GameDefs.GROUP_PICKUP):
		var pickup := node as Pickup
		if pickup == null: continue
		_scores[pickup.pickup_type].inc_total()
	pass
