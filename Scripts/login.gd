extends Control
func Send() -> void:
	Globals.USERNAME = $Username.text
	Globals.PASSWORD = $Password.text
	Globals.COOKIE = await Connection.http("login?user="+Globals.USERNAME+"&pass="+Globals.PASSWORD,1)
	FileAccess.open("user://username.txt",FileAccess.WRITE).store_line(Globals.USERNAME)
	FileAccess.open("user://password.txt",FileAccess.WRITE).store_line(Globals.PASSWORD)
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
func Send_2() -> void:
	$Username.text=FileAccess.open("user://username.txt",FileAccess.READ).get_line()
	$Password.text=FileAccess.open("user://password.txt",FileAccess.READ).get_line()
	Send()
