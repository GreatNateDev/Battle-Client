extends Node
@export var SERVER : String
@export var USERNAME : String
@export var PASSWORD : String
@export var COOKIE : String
var data = HTTPRequest.new()
func _ready():
	add_child(data)
	var timer = Timer.new()
	timer.wait_time = 2
	timer.one_shot = false 
	timer.autostart = true
	timer.timeout.connect(send_cookie)
	add_child(timer)

func send_cookie():
	if COOKIE.length() != 10:
		return
	print("Sending Cookie To Server: " + COOKIE)
	data.request(SERVER + "submitcookie?cookie=" + COOKIE)
	
