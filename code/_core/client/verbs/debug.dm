/client/verb/spawn_from_path(var/object as text) //TODO: Make this work.
	set name = "spawn"
	set desc = "Spawn an object."


	if(!mob)
		return FALSE

	if(!object)
		return FALSE

	if(object[1] != "/")
		object = "/" + object

	var/valid_path = text2path(object)

	if(!valid_path)
		mob.to_chat("\"[object]\" isn't a valid path.")
		return FALSE

	var/list/valid_objects = typesof(valid_path)

	var/valid_count = length(valid_objects)

	if(!valid_count)
		mob.to_chat("\"[object]\" returned no valid types.")
		return FALSE

	if(valid_count == 1)
		var/datum/A = valid_count[1]
		A = new A(mob.loc)
		if(isobj(A))
			var/obj/O = A
			O.on_spawn()
		return TRUE

	var/selection = input("Spawn object.","Spawn object") in valid_objects

	if(selection)
		var/datum/A = selection
		A = new A(mob.loc)
		if(isobj(A))
			var/obj/O = A
			O.on_spawn()
		return TRUE