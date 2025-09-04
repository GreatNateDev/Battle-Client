extends Node
func init():
	if Globals.LOADED == false:
		var userExist = await Connection.http("data/userexist?user="+Globals.USERNAME+"&cookie="+Globals.COOKIE, 1)
		if userExist == "false":
			await set_new_user_values()
			await Connection.http("savedata?name="+Globals.USERNAME+"&type=store&cookie="+Globals.COOKIE+"&data="+JSON.stringify(Globals.data),1)
		if userExist == "true":
			Globals.data = await Connection.http("savedata?name="+Globals.USERNAME+"&type=download&cookie="+Globals.COOKIE+"&data=req",3)	
		Globals.LOADED = true
		Globals.BATTLES = await Connection.http("data/battles?user="+Globals.USERNAME+"&cookie="+Globals.COOKIE, 3)
		return
	Globals.BATTLES = await Connection.http("data/battles?user="+Globals.USERNAME+"&cookie="+Globals.COOKIE, 3)
	await Connection.http("savedata?name="+Globals.USERNAME+"&type=store&cookie="+Globals.COOKIE+"&data="+JSON.stringify(Globals.data),1)
func GetSprites(num):
	var download = Globals.BATTLES[num]["mon1"]["name"]
	return await Connection.http("data/spritedl?user="+Globals.USERNAME+"&cookie="+Globals.COOKIE+"&sprite="+download+"&side=front",2)
func SetupParty(num):
	var id = Globals.data["mon"+str(num)]["name"]
	return await Connection.http("data/spritedl?name="+Globals.USERNAME+"&cookie="+Globals.COOKIE+"&sprite="+id+"&side=front",2)
func set_new_user_values():
	# most of this will be server sided soon
	Globals.data["money"] = 0
	Globals.data["mon1"] = {"name": "pikachu"}
	Globals.data["mon2"] = {"name": "pokeball"}
	Globals.data["mon3"] = {"name": "pokeball"}
	Globals.data["mon4"] = {"name": "pokeball"}
	Globals.data["mon5"] = {"name": "pokeball"}
	Globals.data["mon6"] = {"name": "pokeball"}
