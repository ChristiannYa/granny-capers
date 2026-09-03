class_name UiCollected
extends HBoxContainer

@export var item_img_texture: Texture2D

@onready var img = $Image
@onready var label: Label = $AmountLabel

func _ready() -> void:
	img.texture = item_img_texture

func set_amount(amount: String):
	label.text = amount
