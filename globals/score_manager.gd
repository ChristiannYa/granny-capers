extends Node

var _scores: Dictionary[GameDefs.PickupType, CollectibleScore] = {}

func start_level():
	count_pickups()

func count_pickups():
	var pickups: Dictionary[GameDefs.PickupType, int] = {}

	for node in get_tree().get_nodes_in_group(GameDefs.GROUP_PICKUP):
		var pickup := node as Pickup
		if pickup == null: continue
		if not pickups.has(pickup.pickup_type):
			pickups[pickup.pickup_type] = 0
		pickups[pickup.pickup_type] += 1

	for pickup in pickups:
		_scores[pickup] = CollectibleScore.new()
		_scores[pickup].set_total(pickups[pickup])

	pass
