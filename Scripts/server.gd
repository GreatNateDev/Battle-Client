extends Control
func Connect() -> void:
	Globals.SERVER = "http://"+$"Server Adress".text.strip_edges()+"/"
	Connection.http("ping",1)
	var f = FileAccess
	var store_name = f.open("user://server.txt",FileAccess.WRITE)
	store_name.store_line($"Server Adress".text.strip_edges())
	get_tree().change_scene_to_file("res://Scenes/Login.tscn")
func Connect_2() -> void:
	var f = FileAccess
	var server_name = f.open("user://server.txt", FileAccess.READ)
	server_name = server_name.get_as_text()
	$"Server Adress".text = server_name
	Connect()