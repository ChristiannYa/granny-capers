class_name CollectibleScore
extends RefCounted

var _tot := 0
var _cur := 0

func set_total(tot: int):
	_tot = tot

func _to_string():
	return "%02d / %02d" % [_cur, _tot]
