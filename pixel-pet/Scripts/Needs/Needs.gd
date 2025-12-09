extends Control
class_name NeedsPanel

@export var pet_path: NodePath

@onready var hunger_bar = $Panel/HungerBar
@onready var thirst_bar = $Panel/ThirstBar
@onready var love_bar = $Panel/LoveBar

var pet: BasePet = null

func _ready() -> void:
	if pet_path != NodePath():
		pet = get_node(pet_path) as BasePet
	else:
		push_error("NeedsPanel: pet_path not assigned!")


func _process(_delta: float) -> void:
	if pet == null:
		return

	hunger_bar.value = pet.hunger
	thirst_bar.value = pet.thirst
	love_bar.value = pet.love
