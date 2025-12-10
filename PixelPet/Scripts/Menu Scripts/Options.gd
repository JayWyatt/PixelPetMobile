extends Control

@onready var master_slider := $"VBoxContainer/Master Slider"
@onready var music_slider := $"VBoxContainer/Music Slider"
@onready var sfx_slider := $VBoxContainer/SFXSlider

func _ready():
	# Load saved values or default to 1.0
	master_slider.value = SettingsGlobal.get_value("master_volume", 1.0)
	music_slider.value = SettingsGlobal.get_value("music_volume", 1.0)
	sfx_slider.value = SettingsGlobal.get_value("sfx_volume", 1.0)

	_apply_volumes()

func _apply_volumes():
	_set_bus_volume("Master", master_slider.value)
	_set_bus_volume("Music", music_slider.value)
	_set_bus_volume("SFX", sfx_slider.value)

func _set_bus_volume(bus_name: String, value: float):
	var bus := AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus, linear_to_db(value))

func _on_back_button_pressed() -> void:
	SfxManagerGlobal.play("ButtonClick")
	get_tree().change_scene_to_file("res://Scenes/Menu/Menu.tscn")

func _on_master_slider_value_changed(value: float):
	SettingsGlobal.set_value("master_volume", value)
	_set_bus_volume("Master", value)

func _on_music_slider_value_changed(value: float):
	SettingsGlobal.set_value("music_volume", value)
	_set_bus_volume("Music", value)

func _on_sfx_slider_value_changed(value: float):
	SettingsGlobal.set_value("sfx_volume", value)
	_set_bus_volume("SFX", value)
