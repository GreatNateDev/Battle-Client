extends Control
@export var Adress : String
@export var modified_adress : String
func Connect() -> void:
	Adress = $"Server Adress".text.strip_edges()
	print("Initial Adress: " + Adress)
	var req = HTTPRequest.new()
	add_child(req)
	modified_adress = "http://"+Adress+"/"
	print("Pinging Adress: " + modified_adress)
	req.request(modified_adress+"ping")
	req.request_completed.connect(request_completed)
	
func request_completed(_result, response_code, _headers, body):
	if response_code == 200:
		print("Status Code: 200")
		var decoded_body = body.get_string_from_utf8() 
		print("Decoded Server Message: " + decoded_body)
		Globals.SERVER = modified_adress
		var f = FileAccess
		var store_name = f.open("user://server.txt",FileAccess.WRITE)
		store_name.store_line(Adress)
		get_tree().change_scene_to_file("res://Scenes/Login.tscn")
	else:
		print("Connection Failed Status: "+str(response_code))
		get_tree().quit(1)


func Connect_2() -> void:
	var f = FileAccess
	var server_name = f.open("user://server.txt", FileAccess.READ)
	server_name = server_name.get_as_text()
	$"Server Adress".text = server_name
	Connect()
		
		
		
		
