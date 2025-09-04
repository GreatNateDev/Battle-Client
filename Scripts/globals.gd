extends Node
@export var SERVER : String #Server IP in form of http://ip.tld:port/
@export var USERNAME : String #Logged in username
@export var PASSWORD : String #Logged in password
@export var COOKIE : String #10 Degit auth cookie
@export var BATTLES : Dictionary#Mega dict of all in-game battles
@export var LOADED : bool#Flag to check if you loaded data from the server
@export var data : Dictionary #All save data for game
var CookieReAuth = HTTPRequest.new()#Needs to be in global scope
func _ready():
	add_child(CookieReAuth)
	var ping = Timer.new()
	ping.wait_time = 2
	ping.one_shot = false 
	ping.autostart = true
	ping.timeout.connect(send_cookie)
	add_child(ping)

func send_cookie():
	if COOKIE.length() != 10:
		return
	print("Sending Cookie To Server: " + COOKIE)
	CookieReAuth.request(SERVER + "submitcookie?cookie=" + COOKIE)
func loadsave():
	await Setup.init()
	await save()
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
	#TODO: condense
	var req = HTTPRequest.new()
	add_child(req)
	req.request(Globals.SERVER+"savedata?name="+Globals.USERNAME+"&type=store&cookie="+Globals.COOKIE+"&data="+JSON.stringify(data))
	await req.request_completed
	req.queue_free()