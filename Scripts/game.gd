extends Control


func _ready() -> void:
	Globals.loadsave()

func Fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func Quit() -> void:
	get_tree().quit()


func Leave_Server() -> void:
	Globals.SERVER = ""
	Globals.USERNAME = ""
	Globals.PASSWORD = ""
	Globals.COOKIE = ""
	get_tree().change_scene_to_file("res://Scenes/Server.tscn")


func Logout() -> void:
	Globals.USERNAME = ""
	Globals.PASSWORD = ""
	Globals.COOKIE = ""
	get_tree().change_scene_to_file("res://Scenes/Login.tscn")


func Settings() -> void:
	get_tree().change_scene_to_file("res://Scenes/Settings.tscn")



func PC() -> void:
	get_tree().change_scene_to_file("res://Scenes/PC.tscn")
