extends Control
@export var USERNAME : String
@export var PASSWORD : String


func Send() -> void:
	USERNAME = $Username.text
	PASSWORD = $Password.text
	var req = HTTPRequest.new()
	add_child(req)
	req.request(Globals.SERVER+"login?user="+USERNAME+"&pass="+PASSWORD)
	req.request_completed.connect(send_complete)
func send_complete(_result, code, _headers, body):
	if code == 200:
		print("Login Success")
		FileAccess.open("user://username.txt",FileAccess.WRITE).store_line(USERNAME)
		FileAccess.open("user://password.txt",FileAccess.WRITE).store_line(PASSWORD)
		var decoded_cookie = body.get_string_from_utf8()
		print("Session cookie: "+decoded_cookie)
		Globals.USERNAME = USERNAME
		Globals.PASSWORD = PASSWORD
		Globals.COOKIE = decoded_cookie
		get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	else:
		print("Login Failed Status: "+str(code))


func Send_2() -> void:
	$Username.text=FileAccess.open("user://username.txt",FileAccess.READ).get_line()
	$Password.text=FileAccess.open("user://password.txt",FileAccess.READ).get_line()
	Send()
