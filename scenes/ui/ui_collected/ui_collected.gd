class_name UiCollected
extends HBoxContainer

@export var item_img_texture: Texture2D

@onready var img = $Image

func _ready() -> void:
	img.texture = item_img_texture

