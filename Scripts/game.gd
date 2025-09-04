extends Control
var load_needed = true

func _ready() -> void:
	Globals.loadsave()
	for num in Globals.BATTLES:
		var download = Globals.BATTLES[num]["mon1"]["name"]
		var req = HTTPRequest.new()
		add_child(req)
		req.request(Globals.SERVER)
	var t = Timer.new()
	add_child(t)
	t.wait_time = 1
	t.one_shot = false
	t.start()
	t.timeout.connect(gui_refresh)
	

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
func gui_refresh():
	print("hit")
	if load_needed == true:
		%Party.visible = true
		%Selecter.visible = true
		%Top.visible = true
		%LeftMenu.visible = true
		%Loading.visible = false
		load_needed = false
		
	$Top/Money.text = "Money $" + str(int(Globals.data.money))
	for num in Globals.BATTLES:
		print(num)
