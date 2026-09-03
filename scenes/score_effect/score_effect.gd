extends Label3D


func _ready() -> void:
	start_tween()

func start_tween():
	var tween: Tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", Vector3(0, 1.5, 0), 1.0).as_relative()
	tween.tween_property(self, "scale", Vector3(2, 2, 2), 1.0)
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	tween.set_parallel(false)
	tween.tween_callback(self.queue_free)
