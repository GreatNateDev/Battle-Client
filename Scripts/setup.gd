extends Node

func init():
	print("init pinged")
	Globals.data["money"] = 0 
	# Obtain current battle data
	var battles_request = HTTPRequest.new()
	add_child(battles_request)
	battles_request.request(Globals.SERVER+"data/battles?user="+Globals.USERNAME+"&cookie="+Globals.COOKIE)
	battles_request.request_completed.connect(battles_responce)

func battles_responce(_r : int, c : int, h : PackedStringArray, b: PackedByteArray):
	if c == 200:
		if b.get_string_from_utf8() ==  "Failed Cookie Auth":
			return 1
	if h.get(0).contains("application/json")==true : Globals.BATTLES = JSON.parse_string(b.get_string_from_utf8()); print(Globals.BATTLES)
