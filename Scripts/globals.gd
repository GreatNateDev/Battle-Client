extends Node
@export var SERVER : String
@export var USERNAME : String
@export var PASSWORD : String
@export var COOKIE : String
@export var data : Dictionary
var dat = HTTPRequest.new()
func _ready():
	add_child(dat)
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
	dat.request(SERVER + "submitcookie?cookie=" + COOKIE)
func loadsave():
	if data != {}:
		save()
	Setup.init()
	var req = HTTPRequest.new()
	add_child(req)
	req.request(Globals.SERVER+"savedata?name="+Globals.USERNAME+"&type=download&cookie="+Globals.COOKIE+"&data=req")
	req.request_completed.connect(load_req)
func load_req(_r, c, _h, b):
	if c == 200:
		var text = b.get_string_from_utf8()
		var json = JSON.parse_string(text)
		if typeof(json) == TYPE_DICTIONARY:
			data = json
func save():
	var req = HTTPRequest.new()
	add_child(req)
	req.request(Globals.SERVER+"savedata?name="+Globals.USERNAME+"&type=store&cookie="+Globals.COOKIE+"&data="+JSON.stringify(data))
	req.request_completed.connect(save_req)
func save_req(_r, c, _h, _b):
	if c == 200:
		print("saved")
	else:
		print("failed :(")
	
