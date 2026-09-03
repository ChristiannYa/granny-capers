class_name CollectibleScore
extends RefCounted

var _tot := 0
var _cur := 0

func set_total(tot: int):
	_tot = tot

func inc(): _cur += 1

func has_all() -> bool: return _cur >= _tot

func _to_string() -> String:
	return "%02d / %02d" % [_cur, _tot]
