extends Node

func init():
	Globals.data["money"] = 0 
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
	var _r = res[0]; var c = res[1]; var h = res[2]; var b = res[3]; var tex : ImageTexture
	if c == 200:
		if h.get(0).contains("image/png"):
			var img = Image.new()
			var err = img.load_png_from_buffer(b)
			if err == OK:
				tex = ImageTexture.create_from_image(img)
	return tex
