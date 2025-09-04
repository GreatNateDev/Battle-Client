extends Control
func _ready() -> void:
	await Setup.init()
	for num in Globals.BATTLES:
		var tex : ImageTexture = await Setup.GetSprites(num)
		var button = TextureButton.new()
		%BattleBox.add_child(button)
		button.texture_normal = tex
		button.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	for num in range(1,7):
		var i : ImageTexture = await Setup.SetupParty(num)
		var button = TextureButton.new()
		button.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		button.texture_normal = i
		%PartyList.add_child(button)
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
