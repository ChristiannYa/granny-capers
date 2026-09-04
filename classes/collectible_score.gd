class_name CollectibleScore
extends RefCounted

var _tot := 0
var _cur := 0

func inc(): _cur += 1

func inc_total(): _tot += 1

func has_all() -> bool: return _cur >= _tot

func _to_string() -> String:
	return "%02d / %02d" % [_cur, _tot]
