extends Node
@export var SERVER : String #Server IP in form of http://ip.tld:port/
@export var USERNAME : String #Logged in username
@export var PASSWORD : String #Logged in password
@export var COOKIE : String #10 Degit auth cookie
@export var BATTLES : Dictionary#Mega dict of all in-game battles
@export var data : Dictionary #All save data for game
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
	await Setup.init()
	var req = HTTPRequest.new()
	add_child(req)
	req.request(Globals.SERVER+"savedata?name="+Globals.USERNAME+"&type=download&cookie="+Globals.COOKIE+"&data=req")
	var res = await req.request_completed
	if res[1] == 200:
		var text = res[3].get_string_from_utf8()
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
	
