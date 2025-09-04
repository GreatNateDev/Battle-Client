extends Node

func init():
	var req = HTTPRequest.new()
	add_child(req)
	print(Globals.SERVER+"data/userexist?user="+Globals.USERNAME+"&cookie="+Globals.COOKIE)
	req.request(Globals.SERVER+"data/userexist?user="+Globals.USERNAME+"&cookie="+Globals.COOKIE)
	var res = await req.request_completed
	if !res[1] == 200:
		print("ERROR SERVER")
	if res[3].get_string_from_utf8() == "false":
		await set_new_user_values()
	# Obtain current battle data
	var battles_request = HTTPRequest.new()
	add_child(battles_request)
	battles_request.request(Globals.SERVER+"data/battles?user="+Globals.USERNAME+"&cookie="+Globals.COOKIE)
	var response = await battles_request.request_completed
	if response[1] == 200:
		if response[3].get_string_from_utf8() == "Failed Cookie Auth":
			return 1
	if response[2].get(0).contains("application/json")==true : Globals.BATTLES = JSON.parse_string(response[3].get_string_from_utf8());
func GetSprites(num):
	var download = Globals.BATTLES[num]["mon1"]["name"]
	var req = HTTPRequest.new()
	add_child(req)
	req.request(Globals.SERVER+"data/spritedl?user="+Globals.USERNAME+"&cookie="+Globals.COOKIE+"&sprite="+download+"&side=front")
	var res = await req.request_completed
	req.queue_free()
	var _r = res[0]; var c = res[1]; var h = res[2]; var b = res[3]; var tex : ImageTexture
	if c == 200:
		if h.get(0).contains("image/png"):
			var img = Image.new()
			var err = img.load_png_from_buffer(b)
			if err == OK:
				tex = ImageTexture.create_from_image(img)
	return tex
func SetupParty(num):
	var id = Globals.data["mon"+str(num)]["name"]
	var req = HTTPRequest.new()
	add_child(req)
	req.request(Globals.SERVER+"data/spritedl?name="+Globals.USERNAME+"&cookie="+Globals.COOKIE+"&sprite="+id+"&side=front")
	var res = await req.request_completed
	req.queue_free()
	var _response_code : int = res[0]
	var http_code : int = res[1]
	var header : PackedStringArray = res[2]
	var body : PackedByteArray = res[3]
	if http_code == 200:
		if header.get(0).contains("image/png"):
			var img = Image.new()
			var errchk = img.load_png_from_buffer(body)
			if errchk == OK:
				return ImageTexture.create_from_image(img)
func set_new_user_values():
	# most of this will be server sided soon
	Globals.data["money"] = 0
	Globals.data["mon1"] = {"name": "pikachu"}
	Globals.data["mon2"] = {"name": "pokeball"}
	Globals.data["mon3"] = {"name": "pokeball"}
	Globals.data["mon4"] = {"name": "pokeball"}
	Globals.data["mon5"] = {"name": "pokeball"}
	Globals.data["mon6"] = {"name": "pokeball"}
