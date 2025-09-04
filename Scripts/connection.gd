extends Node
func http(payload : String, type : int):
	#Types 1: return as utf-8 string, 2: return as png image, 3: return as json
	var request = HTTPRequest.new()
	add_child(request)
	request.request(Globals.SERVER+payload)
	var response = await request.request_completed
	request.queue_free()
	var _response_code : int = response[0]
	var http_code : int = response[1]
	var _header : PackedStringArray = response[2]
	var body : PackedByteArray = response[3]
	if http_code == 200:
		match type:
			1:
				return body.get_string_from_utf8()
			2:
				var img = Image.new()
				img.load_png_from_buffer(body)
				return ImageTexture.create_from_image(img)
			3:
				return JSON.parse_string(body.get_string_from_utf8())
	else:
		printerr("HTTP Connection Fail")
