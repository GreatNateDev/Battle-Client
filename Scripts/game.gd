extends Control
func _ready() -> void:
	await Globals.loadsave()
	for num in Globals.BATTLES:
		var tex = await Setup.GetSprites(num)
		var button = TextureButton.new()
		%BattleBox.add_child(button)
		button.texture_normal = tex
	$Top/Money.text = "Money $" + str(int(Globals.data.money))
	%Party.visible = true
	%Selecter.visible = true
	%Top.visible = true
	%LeftMenu.visible = true
	%Loading.visible = false
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
