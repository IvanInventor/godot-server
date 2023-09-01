extends Node

func _ready():
	if "--server" in OS.get_cmdline_args():
		get_tree().change_scene_to_file('res://server-headless.tscn')
	else:
		get_tree().change_scene_to_file('res://combo.tscn')
