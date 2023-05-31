
// reference: /client/proc/modify_variables(var/atom/O, var/param_var_name = null, var/autodetect_class = 0)


client/proc/debug_variables(datum/D in world)
	set category = "Debug"
	set name = "View Variables"

	if(!usr.client || !(permissions & FLAG_PERMISSION_MODERATOR))
		to_chat("\red You need to be a moderator or higher to access this.")
		return

	if(!D)	return

	var/title = ""
	var/body = ""

	//Sort of a temporary solution for right now.
	if(istype(D, /atom))
		var/atom/A = D
		title = "[A.name] (\ref[A]) = [A.type]"

		#ifdef VARSICON
		if (A.icon)
			body += debug_variable("icon", new/icon(A.icon, A.icon_state, A.dir), 0)
		#endif

	var/icon/sprite

	if(istype(D,/atom))
		var/atom/AT = D
		if(AT.icon && AT.icon_state)
			sprite = new /icon(AT.icon, AT.icon_state)
			usr << browse_rsc(sprite, "view_vars_sprite.png")

	title = "[D] (\ref[D]) = [D.type]"

	body += {"<script type="text/javascript">

				function updateSearch(){
					var filter_text = document.getElementById('filter');
					var filter = filter_text.value.toLowerCase();

					if(event.keyCode == 13){	//Enter / return
						var vars_ol = document.getElementById('vars');
						var lis = vars_ol.getElementsByTagName("li");
						for ( var i = 0; i < lis.length; ++i )
						{
							try{
								var li = lis\[i\];
								if ( li.style.backgroundColor == "#ffee88" )
								{
									alist = lis\[i\].getElementsByTagName("a")
									if(alist.length > 0){
										location.href=alist\[0\].href;
									}
								}
							}catch(err) {   }
						}
						return
					}

					if(event.keyCode == 38){	//Up arrow
						var vars_ol = document.getElementById('vars');
						var lis = vars_ol.getElementsByTagName("li");
						for ( var i = 0; i < lis.length; ++i )
						{
							try{
								var li = lis\[i\];
								if ( li.style.backgroundColor == "#5e7885" )
								{
									if( (i-1) >= 0){
										var li_new = lis\[i-1\];
										li.style.backgroundColor = "white";
										li_new.style.backgroundColor = "#5e7885";
										return
									}
								}
							}catch(err) {  }
						}
						return
					}

					if(event.keyCode == 40){	//Down arrow
						var vars_ol = document.getElementById('vars');
						var lis = vars_ol.getElementsByTagName("li");
						for ( var i = 0; i < lis.length; ++i )
						{
							try{
								var li = lis\[i\];
								if ( li.style.backgroundColor == "#5e7885" )
								{
									if( (i+1) < lis.length){
										var li_new = lis\[i+1\];
										li.style.backgroundColor = "#88969c";
										li_new.style.backgroundColor = "#dad098";
										return
									}
								}
							}catch(err) {  }
						}
						return
					}

					//This part here resets everything to how it was at the start so the filter is applied to the complete list. Screw efficiency, it's client-side anyway and it only looks through 200 or so variables at maximum anyway (mobs).
					if(complete_list != null && complete_list != ""){
						var vars_ol1 = document.getElementById("vars");
						vars_ol1.innerHTML = complete_list
					}

					if(filter.value == ""){
						return;
					}else{
						var vars_ol = document.getElementById('vars');
						var lis = vars_ol.getElementsByTagName("li");

						for ( var i = 0; i < lis.length; ++i )
						{
							try{
								var li = lis\[i\];
								if ( li.innerText.toLowerCase().indexOf(filter) == -1 )
								{
									vars_ol.removeChild(li);
									i--;
								}
							}catch(err) {   }
						}
					}
					var lis_new = vars_ol.getElementsByTagName("li");
					for ( var j = 0; j < lis_new.length; ++j )
					{
						var li1 = lis\[j\];
						if (j == 0){
							li1.style.backgroundColor = "#5e7885";
						}else{
							li1.style.backgroundColor = "#35393b";
						}
					}
				}
				function selectTextField(){
					var filter_text = document.getElementById('filter');
					filter_text.focus();
					filter_text.select();

				}

				function loadPage(list) {

					if(list.options\[list.selectedIndex\].value == ""){
						return;
					}

					location.href=list.options\[list.selectedIndex\].value;

				}
			</script> "}

	body += "<body onload='selectTextField(); updateSearch()' onkeyup='updateSearch()'>"

	body += "<div align='center'><table width='100%'><tr><td width='50%'>"

	if(sprite)
		body += "<table align='center' width='100%'><tr><td><img src='view_vars_sprite.png'></td><td>"
	else
		body += "<table align='center' width='100%'><tr><td>"

	body += "<div align='center'>"

	if(istype(D,/atom))
		var/atom/A = D
		if(is_living(A))
			body += "<a href='?_src_=vars;rename=\ref[D]'><b>[D]</b></a>"
			if(A.dir)
				body += "<br><font size='1'><a href='?_src_=vars;rotatedatum=\ref[D];rotatedir=left'><<</a> <a href='?_src_=vars;datumedit=\ref[D];varnameedit=dir'>[dir2text(A.dir)]</a> <a href='?_src_=vars;rotatedatum=\ref[D];rotatedir=right'>>></a></font>"
			var/mob/living/M = A
			body += "<br><font size='1'><a href='?_src_=vars;datumedit=\ref[D];varnameedit=ckey'>[M.ckey ? M.ckey : "No ckey"]</a> / <a href='?_src_=vars;datumedit=\ref[D];varnameedit=real_name'>[M.name ? M.name : "No real name"]</a></font>"
			body += {"
			<br><font size='1'>
			BRUTE:<font size='1'><a href='?_src_=vars;mobToDamage=\ref[D];adjustDamage=brute'>[M.health.damage[BRUTE]]</a>
			FIRE:<font size='1'><a href='?_src_=vars;mobToDamage=\ref[D];adjustDamage=fire'>[M.health.damage[BURN]]</a>
			TOXIN:<font size='1'><a href='?_src_=vars;mobToDamage=\ref[D];adjustDamage=toxin'>[M.health.damage[TOX]]</a>
			OXY:<font size='1'><a href='?_src_=vars;mobToDamage=\ref[D];adjustDamage=oxygen'>[M.health.damage[OXY]]</a>
			FATIGUE:<font size='1'><a href='?_src_=vars;mobToDamage=\ref[D];adjustDamage=fatigue'>[M.health.damage[FATIGUE]]</a>
			SANITY:<font size='1'><a href='?_src_=vars;mobToDamage=\ref[D];adjustDamage=sanity'>[M.health.damage[SANITY]]</a>
			MENTAL:<font size='1'><a href='?_src_=vars;mobToDamage=\ref[D];adjustDamage=mental'>[M.health.damage[MENTAL]]</a>
			STAMINA:<font size='1'><a href='?_src_=vars;mobToDamage=\ref[D];adjustDamage=stamina'>[M.health.stamina_max - M.health.stamina_current]</a>
			MANA:<font size='1'><a href='?_src_=vars;mobToDamage=\ref[D];adjustDamage=mana'>[M.health.mana_max - M.health.mana_current]</a>
			</font>
			"}
		else
			body += "<a href='?_src_=vars;datumedit=\ref[D];varnameedit=name'><b>[D]</b></a>"
			if(A.dir)
				body += "<br><font size='1'><a href='?_src_=vars;rotatedatum=\ref[D];rotatedir=left'><<</a> <a href='?_src_=vars;datumedit=\ref[D];varnameedit=dir'>[dir2text(A.dir)]</a> <a href='?_src_=vars;rotatedatum=\ref[D];rotatedir=right'>>></a></font>"
	else
		body += "<b>[D]</b>"

	body += "</div>"

	body += "</tr></td></table>"

	var/formatted_type = "[D.type]"
	if(length(formatted_type) > 25)
		var/middle_point = length(formatted_type) / 2
		var/splitpoint = findtext(formatted_type,"/",middle_point)
		if(splitpoint)
			formatted_type = "[copytext(formatted_type,1,splitpoint)]<br>[copytext(formatted_type,splitpoint)]"
		else
			formatted_type = "Type too long" //No suitable splitpoint (/) found.

	body += "<div align='center'><b><font size='1'>[formatted_type]</font></b>"

	body += "</div>"

	body += "</div></td>"

	body += "<td width='50%'><div align='center'><a href='?_src_=vars;datumrefresh=\ref[D]'>Refresh</a>"

	body += {"	<form>
				<select name="file" size="1"
				onchange="loadPage(this.form.elements\[0\])"
				target="_parent._top"
				onmouseclick="this.focus()"
				style="background-color:#35393b;color: #c8d7d8;">
			"}

	body += {"	<option value>Select option</option>
				<option value> </option>
			"}

	body += "<option value='?_src_=vars;callproc=\ref[D]'>Callproc</option>"
	body += "<option value='?_src_=vars;delete=\ref[D]'>Delete</option>"
	if(ismob(D))
		body += "<option value='?_src_=vars;godmode=\ref[D]'>Toggle Godmode</option>"
		body += "<option value='?_src_=vars;direct_control=\ref[D]'>Assume Direct Control</option>"
		body += "<option value='?_src_=vars;drop_everything=\ref[D]'>Drop Everything</option>"

		body += "<option value='?_src_=vars;gib=\ref[D]'>Gib</option>"
		body += "<option value='?_src_=vars;MtF=\ref[D]'>Mob to follow</option>"
		body += "<option value='?_src_=vars;regenerateicons=\ref[D]'>Regenerate Icons</option>"
		body += "<option value='?_src_=vars;addlanguage=\ref[D]'>Add Language</option>"
		body += "<option value='?_src_=vars;remlanguage=\ref[D]'>Remove Language</option>"
		body += "<option value='?_src_=vars;addorgan=\ref[D]'>Add Organ</option>"
		body += "<option value='?_src_=vars;remorgan=\ref[D]'>Remove Organ</option>"

		body += "<option value='?_src_=vars;addverb=\ref[D]'>Add Verb</option>"
		body += "<option value='?_src_=vars;remverb=\ref[D]'>Remove Verb</option>"
		if(is_advanced(D))
			body += "<option value>---</option>"
			body += "<option value='?_src_=vars;setspecies=\ref[D]'>Set Species</option>"
			body += "<option value='?_src_=vars;equip_loadout=\ref[D]'>Select Equipment</option>"
	if(isobj(D))
		body += "<option value='?_src_=vars;delall=\ref[D]'>Delete all of type</option>"
	if(isobj(D) || ismob(D) || is_turf(D))
		body += "<option value='?_src_=vars;TtU=\ref[D]'>Teleport to user</option>"
		body += "<option value='?_src_=vars;ai_alert=\ref[D]'>Alert AI</option>"
		body += "<option value='?_src_=vars;explode=\ref[D]'>Trigger explosion</option>"

	body += "</select></form>"

	body += "</div></td></tr></table></div><hr>"

	body += "<font size='1'><b>E</b> - Edit, tries to determine the variable type by itself.<br>"
	body += "<b>C</b> - Change, asks you for the var type first.<br>"
	body += "<b>M</b> - Mass modify: changes this variable for all objects of this type.</font><br>"

	body += "<hr><table width='100%'><tr><td width='20%'><div align='center'><b>Search:</b></div></td><td width='80%'><input type='text' id='filter' name='filter_text' value='' style='width:100%;background-color: #35393b;color: #c8d7d8;'></td></tr></table><hr>"

	body += "<ol id='vars'>"

	var/list/names = list()
	for (var/V in D.vars)
		names += V

	names = sort_tim(names,cmp=/proc/cmp_text_asc)

	for (var/V in names)
		body += debug_variable(V, D.vars[V], 0, D)

	body += "</ol>"

	var/html = "<html><head>"
	if (title)
		html += "<title>[title]</title>"
	html += {"<style>
body
{
	font-family: Verdana, sans-serif;
	font-size: 9pt;
	background-color: #35393b;
	color: #c8d7d8;
}
.value
{
	font-family: "Courier New", monospace;
	font-size: 8pt;
	background-color: #35393b;
	color: #c8d7d8;
}
</style>"}
	html += "</head><body>"
	html += body

	html += {"
		<script type='text/javascript'>
			var vars_ol = document.getElementById("vars");
			var complete_list = vars_ol.innerHTML;
		</script>
	"}

	html += "</body></html>"

	usr << browse(html, "window=variables\ref[D];size=475x650")

	return

client/proc/debug_variable(name, value, level, var/datum/DA = null)
	if(!usr.client || !(permissions & FLAG_PERMISSION_MODERATOR))
		to_chat("\red You need to be a moderator or higher to access this.")
		return
	var/html = ""
	if(DA)
		html += "<li style='backgroundColor:#35393b'>(<a href='?_src_=vars;datumedit=\ref[DA];varnameedit=[name]'>E</a>) (<a href='?_src_=vars;datumchange=\ref[DA];varnamechange=[name]'>C</a>) (<a href='?_src_=vars;datummass=\ref[DA];varnamemass=[name]'>M</a>) "
	else
		html += "<li>"

	if (isnull(value))
		html += "[name] = <span class='value'>null</span>"

	else if (istext(value))
		html += "[name] = <span class='value'>\"[value]\"</span>"

	else if (isicon(value))
		#ifdef VARSICON
		var/icon/I = new/icon(value)
		var/rnd = rand(1,10000)
		var/rname = "tmp\ref[I][rnd].png"
		usr << browse_rsc(I, rname)
		html += "[name] = (<span class='value'>[value]</span>) <img class=icon src=\"[rname]\">"
		#else
		html += "[name] = /icon (<span class='value'>[value]</span>)"
		#endif

/*		else if (istype(value, /image))
		#ifdef VARSICON
		var/rnd = rand(1, 10000)
		var/image/I = value

		src << browse_rsc(I.icon, "tmp\ref[value][rnd].png")
		html += "[name] = <img src=\"tmp\ref[value][rnd].png\">"
		#else
		html += "[name] = /image (<span class='value'>[value]</span>)"
		#endif
*/
	else if (isfile(value))
		html += "[name] = <span class='value'>'[value]'</span>"

	else if (istype(value, /datum))
		var/datum/D = value
		html += "<a href='?_src_=vars;Vars=\ref[value]'>[name] \ref[value]</a> = [D.type]"

	else if (istype(value, /client))
		var/client/C = value
		html += "<a href='?_src_=vars;Vars=\ref[value]'>[name] \ref[value]</a> = [C] [C.type]"
//
	else if (istype(value, /list))
		var/list/L = value
		html += "[name] = /list ([L.len])"

		if (L.len > 0 && !(name == "underlays" || name == "overlays" || name == "vars" || L.len > 500))
			// not sure if this is completely right...
			if(0)   //(L.vars.len > 0)
				html += "<ol>"
				html += "</ol>"
			else
				html += "<ul>"
				var/index = 1
				for (var/entry in L)
					if(istext(entry))
						html += debug_variable(entry, L[entry], level + 1)
					//html += debug_variable("[index]", L[index], level + 1)
					else
						html += debug_variable(index, L[index], level + 1)
					index++
				html += "</ul>"

	else
		html += "[name] = <span class='value'>[value]</span>"

	html += "</li>"
	return html

/client/proc/view_var_Topic(href, href_list, hsrc)
	if(!usr.client || !(permissions & FLAG_PERMISSION_MODERATOR))
		to_chat("\red You need to be a moderator or higher to access this.")
		return FALSE
	//This should all be moved over to datum/admins/Topic() or something ~Carn
	if(href_list["Vars"])
		debug_variables(locate(href_list["Vars"]))

	//~CARN: for renaming mobs (updates their name, real_name, mind.name, their ID/PDA and datacore records).
	else if(href_list["rename"])

		var/mob/M = locate(href_list["rename"])
		if(!istype(M))
			to_chat(span("notice",  "This can only be used on instances of type /mob"))
			return

		var/new_name = stripped_input(usr,"What would you like to name this mob?","Input a name",M.name,64)
		if( !new_name || !M )	return

		M.name = new_name
		href_list["datumrefresh"] = href_list["rename"]

	else if(href_list["varnameedit"] && href_list["datumedit"])

		var/D = locate(href_list["datumedit"])
		if(!istype(D,/datum) && !istype(D,/client))
			to_chat(span("notice",  "This can only be used on instances of types /client or /datum"))
			return

		modify_variables(D, href_list["varnameedit"], 1)
		href_list["datumrefresh"] = href_list["varnameedit"]
		href_list["datumrefresh"] = href_list["datumedit"]

	else if(href_list["varnamechange"] && href_list["datumchange"])

		var/D = locate(href_list["datumchange"])
		if(!istype(D,/datum) && !istype(D,/client))
			to_chat(span("notice",  "This can only be used on instances of types /client or /datum"))
			return

		modify_variables(D, href_list["varnamechange"], 0)
		href_list["datumrefresh"] = href_list["varnamechange"]
		href_list["datumrefresh"] = href_list["datumchange"]

	else if(href_list["varnamemass"] && href_list["datummass"])

		var/atom/A = locate(href_list["datummass"])
		if(!istype(A))
			to_chat(span("notice",  "This can only be used on instances of type /atom"))
			return

		cmd_mass_modify_object_variables(A, href_list["varnamemass"])
		href_list["datumrefresh"] = href_list["varnamemass"]
		href_list["datumrefresh"] = href_list["datummass"]

	else if(href_list["gib"])

		var/mob/M = locate(href_list["gib"])
		if(!istype(M))
			to_chat(span("notice", "This can only be used on instances of type /mob"))
			return

		smite_living(M)

	else if(href_list["delete"])
		var/atom/movable/M = locate(href_list["delete"])
		spawn(1)
		if(!M) return
		if(M.is_safe_to_delete())
			usr.to_chat(span("notice","Deleting [M]..."))
			qdel(M)
		else
			usr.to_chat(span("danger","<h2>Not safe to delete [M]!</h2>"))
			switch(alert(usr, "Do you want to continue anyway?","Delete?","Yes","No"))
				if("Yes")
					spawn(1)
					qdel(M)
				if("No")
					return

	else if(href_list["callproc"])
		var/atom/A = locate(href_list["callproc"])
		if(!istype(A))
			to_chat(span("notice", "This can only be used on instances of type /atom"))
		callproc(A)

	else if(href_list["godmode"])
		var/mob/living/advanced/M = locate(href_list["godmode"])
		if(!istype(M))
			to_chat(span("notice", "This can only be used on instances of type /mob/living/advanced"))
			return
		if(M.has_status_effect(IMMORTAL))
			M.remove_status_effect(IMMORTAL)
			M.movement_delay = initial(M.movement_delay)
		else
			M.add_status_effect(IMMORTAL)
			M.movement_delay = 0.5
		href_list["datumrefresh"] = href_list["godmode"]

	else if(href_list["drop_everything"])

		var/mob/living/advanced/M = locate(href_list["drop_everything"])
		if(!istype(M))
			to_chat(span("notice", "This can only be used on instances of type /mob/living/advanced"))
			return
		M.drop_all_items(get_turf(src))
		href_list["datumrefresh"] = href_list["drop_everything"]

	else if(href_list["direct_control"])

		var/mob/M = locate(href_list["direct_control"])
		var/client/NO = src
		if(!istype(M))
			to_chat(span("notice", "This can only be used on instances of type /mob"))
			return

		var/ghosts = list()
		for(var/mob/abstract/observer/ghost/G in range(usr,5))
			if(!G.client) continue
			ghosts += G.client
		if(length(ghosts))
			NO = input("Please choose a new client to obtain [M.name].","Control mob",src) as anything in ghosts
			if(!NO) return FALSE


		var/mob/living/advanced/player/P = M

		if(P.client) P.client.make_ghost(P.loc)

		NO.control_mob(P)
		P.add_species_buttons()
		QUEUE_HEALTH_UPDATE(P)
		href_list["datumrefresh"] = href_list["direct_control"]

	else if(href_list["delall"])

		var/obj/O = locate(href_list["delall"])
		if(!isobj(O))
			to_chat(span("notice",  "This can only be used on instances of type /obj"))
			return

		var/action_type = alert("Strict type ([O.type]) or type and all subtypes?",,"Strict type","Type and subtypes","Cancel")
		if(action_type == "Cancel" || !action_type)
			return

		if(alert("Are you really sure you want to delete all objects of type [O.type]?",,"Yes","No") != "Yes")
			return

		if(alert("Second confirmation required. Delete?",,"Yes","No") != "Yes")
			return
		var/O_type = O.type
		switch(action_type)
			if("Strict type")
				var/i = 0
				for(var/obj/Obj in world)
					if(Obj.type == O_type)
						i++
						qdel(Obj)
				if(!i)
					to_chat(span("notice",  "No objects of this type exist"))
					return
			if("Type and subtypes")
				var/i = 0
				for(var/obj/Obj in world)
					if(istype(Obj,O_type))
						i++
						qdel(Obj)
				if(!i)
					to_chat(span("notice",  "No objects of this type exist"))
					return

	else if(href_list["ai_alert"])

		var/atom/A = locate(href_list["ai_alert"])
		if(!isobj(A) && !ismob(A) && !is_turf(A))
			to_chat(span("notice",  "This can only be done to instances of type /obj, /mob and /turf"))
			return
		var/range = input(src,"Дальность распространения шума", "Alert range") as num
		create_alert(range,get_turf(A),A,2,1)
		href_list["datumrefresh"] = href_list["ai_alert"]

	else if(href_list["TtU"])

		var/atom/movable/O = locate(href_list["TtU"])
		if(!isobj(O) && !ismob(O))
			to_chat(span("notice",  "This can only be used on instances of type /obj or /mob"))
			return
		var/turf/T = get_turf(mob)
		if(!T)
			to_chat(span("warning","Invalid turf."))
			return FALSE

		O.force_move(T)
		to_chat(span("notice","You teleported [O.name] to your location."))

		href_list["datumrefresh"] = href_list["MtF"]

	else if(href_list["MtF"])

		var/mob/living/L = locate(href_list["MtF"])
		if(!ismob(L))
			to_chat(span("notice",  "This can only be used on instances of type /mob/living"))
			return

		if(!L.ai) return
		L.ai.set_move_objective(src.mob,astar=TRUE,follow=TRUE)
		L.following = src
		to_chat(span("notice","You selected [L.name] to follow you."))

		href_list["datumrefresh"] = href_list["MtF"]

	else if(href_list["explode"])

		var/atom/A = locate(href_list["explode"])
		if(!isobj(A) && !ismob(A) && !is_turf(A))
			to_chat(span("notice",  "This can only be done to instances of type /obj, /mob and /turf"))
			return
		explode(get_turf(A),4,A,A,null)
		href_list["datumrefresh"] = href_list["explode"]

	else if(href_list["rotatedatum"])

		var/atom/A = locate(href_list["rotatedatum"])
		if(!istype(A))
			to_chat(span("notice",  "This can only be done to instances of type /atom"))
			return

		switch(href_list["rotatedir"])
			if("right")	A.dir = turn(A.dir, -45)
			if("left")	A.dir = turn(A.dir, 45)
		href_list["datumrefresh"] = href_list["rotatedatum"]

	else if(href_list["setspecies"])

		var/mob/living/advanced/H = locate(href_list["setspecies"])
		if(!istype(H))
			to_chat(span("notice",  "This can only be done to instances of type /mob/living/advanced"))
			return

		var/new_species = input("Please choose a new species.","Species",null) as null|anything in SSspecies.all_species

		if(!new_species) return

		if(!H)
			to_chat(span("notice",  "Mob doesn't exist anymore"))
			return

		if(H.perform_specieschange(new_species, TRUE))
			to_chat(span("notice",  "Set species of [H] to [H.species]."))
		href_list["datumrefresh"] = href_list["setspecies"]

	else if(href_list["equip_loadout"])

		var/mob/living/advanced/H = locate(href_list["equip_loadout"])
		if(!istype(H))
			to_chat(span("notice",  "This can only be done to instances of type /mob/living/advanced"))
			return

		var/loadout = input("Please choose a loadout.","Loadout",null) as null|anything in all_loadouts

		if(!loadout) return

		if(!H)
			to_chat(span("notice",  "Mob doesn't exist anymore"))
			return

		if(H.equip_loadout(loadout,FALSE))
			to_chat(span("notice",  "Loadout is set of [H] to [loadout]."))
		else
			to_chat(span("notice",  "Failed! Something went wrong."))
		href_list["datumrefresh"] = href_list["equip_loadout"]

	else if(href_list["addlanguage"])

		var/mob/H = locate(href_list["addlanguage"])
		if(!istype(H))
			to_chat(span("notice",  "This can only be done to instances of type /mob"))
			return

		var/new_language = input("Please choose a language to add.","Language",null) as null|anything in SSlanguage.all_languages
		if(!new_language)
			return

		if(!H)
			to_chat(span("notice",  "Mob doesn't exist anymore"))
			return

		H.known_languages[new_language] = TRUE

		href_list["datumrefresh"] = href_list["addlanguage"]

	else if(href_list["remlanguage"])

		var/mob/H = locate(href_list["remlanguage"])
		if(!istype(H))
			to_chat(span("notice",  "This can only be done to instances of type /mob"))
			return

		var/rem_language = input("Please choose a language to remove.","Language",null) as null|anything in H.known_languages

		if(!rem_language)
			return

		if(!H)
			to_chat(span("notice",  "Mob doesn't exist anymore"))
			return

		if(H.known_languages[rem_language] == TRUE)
			H.known_languages[rem_language] = FALSE
			H.known_languages -= rem_language
			to_chat(span("notice",  "Removed [rem_language] from [H]."))
		else
			to_chat(span("notice",  "Mob doesn't know that language."))
		href_list["datumrefresh"] = href_list["remlanguage"]

	else if(href_list["addverb"])

		var/mob/living/H = locate(href_list["addverb"])

		if(!istype(H))
			to_chat(span("notice",  "This can only be done to instances of type /mob/living"))
			return
		var/list/possibleverbs = list()
		possibleverbs += "Cancel" 								// One for the top...
		possibleverbs += typesof(/mob/proc,/mob/verb,/mob/living/proc,/mob/living/verb)
		possibleverbs += typesof(/mob/living/advanced/proc, /mob/living/advanced/player/proc,)///mob/living/advanced/player/verb)
		possibleverbs -= H.verbs
		possibleverbs += "Cancel" 								// ...And one for the bottom

		var/verb = input("Select a verb!", "Verbs",null) as anything in possibleverbs
		if(!H)
			to_chat(span("notice",  "Mob doesn't exist anymore"))
			return
		if(!verb || verb == "Cancel")
			return
		else
			H.verbs += verb
		href_list["datumrefresh"] = href_list["addverb"]

	else if(href_list["remverb"])

		var/mob/H = locate(href_list["remverb"])

		if(!istype(H))
			to_chat(span("notice",  "This can only be done to instances of type /mob"))
			return
		var/verb = input("Please choose a verb to remove.","Verbs",null) as null|anything in H.verbs
		if(!H)
			to_chat(span("notice",  "Mob doesn't exist anymore"))
			return
		if(!verb)
			return
		else
			H.verbs -= verb
		href_list["datumrefresh"] = href_list["remverb"]

	else if(href_list["addorgan"])
		href_list["datumrefresh"] = href_list["addorgan"]
		var/mob/living/advanced/M = locate(href_list["addorgan"])
		if(!istype(M))
			to_chat(span("notice",  "This can only be done to instances of type /mob/living/advanced"))
			return

		var/new_organ = input("Please choose an organ to add.","Organ",null) as null|anything in subtypesof(/obj/item/organ)

		if(!M)
			to_chat(span("notice",  "Mob doesn't exist anymore"))
			return
		if(!new_organ)
			to_chat(span("notice",  "Aborting"))
			return
		var/obj/item/organ/O = M.add_organ(new_organ)
		var/color = input(usr, "What color of organ do you want") as null|text
		if(color)
			O.additional_blends["skin"].color = color
			M.update_overlay_tracked("\ref[O]")

		else
			var/species/S = SPECIES(M.species)
			if(S.default_color_skin)
				O.additional_blends["skin"].color = S.default_color_skin
				M.update_overlay_tracked("\ref[O]")
		QUEUE_HEALTH_UPDATE(M)

	else if(href_list["remorgan"])
		href_list["datumrefresh"] = href_list["remorgan"]
		var/mob/living/advanced/M = locate(href_list["remorgan"])
		if(!istype(M))
			to_chat(span("notice","This can only be done to instances of type /mob/living/carbon"))
			return

		var/rem_organ = input("Please choose an organ to remove.","Organ",null) as null|anything in M.organs

		if(!M)
			to_chat(span("notice","Mob doesn't exist anymore"))
			return

		if(!(locate(rem_organ) in M.organs))
			to_chat(span("notice",  "Mob does not have that organ."))
			return
		var/obj/item/organ/O = rem_organ
		to_chat(span("notice","Removed [rem_organ] from [M]."))
		O.unattach_from_parent(M.loc)
		QUEUE_HEALTH_UPDATE(M)

	else if(href_list["regenerateicons"])

		var/mob/living/advanced/M = locate(href_list["regenerateicons"])
		if(!ismob(M))
			to_chat(span("notice",  "This can only be done to instances of type /mob/living/advanced"))
			return
		M.client.update_zoom(initial(M.client.zoom_level))
		M.client.update_verbs()
		//M.client.update_color_mods()
		M.restore_inventory()
		M.restore_buttons()
		QUEUE_HEALTH_UPDATE(M)
		href_list["datumrefresh"] = href_list["regenerateicons"]

	else if(href_list["adjustDamage"] && href_list["mobToDamage"])

		var/mob/living/L = locate(href_list["mobToDamage"])
		if(!istype(L)) return

		var/Text = href_list["adjustDamage"]

		var/amount =  input("Deal how much damage to mob? (Negative values here heal)","Adjust [Text]loss",0) as num

		if(!L)
			to_chat(span("notice",  "Mob doesn't exist anymore"))
			return
		switch(Text)
			if("brute")	L.health.adjust_loss_smart(brute=amount)
			if("fire")	L.health.adjust_loss_smart(burn=amount)
			if("toxin")	L.health.adjust_loss_smart(tox=amount)
			if("oxygen")L.health.adjust_loss_smart(oxy=amount)
			if("fatigue")	L.health.adjust_loss_smart(fatigue=amount)
			if("sanity")	L.health.adjust_loss_smart(sanity=amount)
			if("mental")	L.health.adjust_loss_smart(mental=amount)
			if("stamina")	L.health.adjust_stamina(amount)
			if("mana")	L.health.adjust_mana(amount)
			else
				to_chat(span("notice",  "You caused an error. DEBUG: Text:[Text] Mob:[L]"))
				return

		if(amount != 0)
			href_list["datumrefresh"] = href_list["mobToDamage"]

	if(href_list["datumrefresh"])
		var/datum/DAT = locate(href_list["datumrefresh"])
		if(!istype(DAT, /datum))
			return
		src.debug_variables(DAT)

	return

/client/proc/mod_list_add_ass() //haha

	var/class = "text"
	class = input("What kind of variable?","Variable Type") as null|anything in list("text",
		"num","type","reference","mob reference", "icon","file","list","edit referenced object","restore to default")

	if(!class)
		return

	var/var_value = null

	switch(class)

		if("text")
			var_value = input("Enter new text:","Text") as null|text

		if("num")
			var_value = input("Enter new number:","Num") as null|num

		if("type")
			var_value = input("Enter type:","Type") as null|anything in typesof(/obj,/mob,/area,/turf)

		if("reference")
			var_value = input("Select reference:","Reference") as null|mob|obj|turf|area in world

		if("mob reference")
			var_value = input("Select reference:","Reference") as null|mob in all_mobs

		if("file")
			var_value = input("Pick file:","File") as null|file

		if("icon")
			var_value = input("Pick icon:","Icon") as null|icon

	if(!var_value) return

	return var_value

/client/proc/mod_list_add(var/list/L)

	var/class = "text"

	class = input("What kind of variable?","Variable Type") as null|anything in list("text",
		"num","type","reference","mob reference", "icon","file","list","edit referenced object","restore to default")

	if(!class)
		return

	var/var_value = null

	switch(class)

		if("text")
			var_value = input("Enter new text:","Text") as text

		if("num")
			var_value = input("Enter new number:","Num") as num

		if("type")
			var_value = input("Enter type:","Type") in typesof(/obj,/mob,/area,/turf)

		if("reference")
			var_value = input("Select reference:","Reference") as mob|obj|turf|area in world

		if("mob reference")
			var_value = input("Select reference:","Reference") as mob in all_mobs

		if("file")
			var_value = input("Pick file:","File") as file

		if("icon")
			var_value = input("Pick icon:","Icon") as icon

	if(!var_value) return

	switch(alert("Would you like to associate a var with the list entry?",,"Yes","No"))
		if("Yes")
			L += var_value
			L[var_value] = mod_list_add_ass() //haha
		if("No")
			L += var_value

/client/proc/mod_list(var/list/L)

	if(!istype(L,/list)) to_chat(src, "Not a List.")

	var/list/names = sort_tim(L,cmp=/proc/cmp_text_asc)

	var/variable = input("Which var?","Var") as null|anything in names + "(ADD VAR)"

	if(variable == "(ADD VAR)")
		mod_list_add(L)
		return

	if(!variable)
		return

	var/default

	var/dir

	if(isnull(variable))
		to_chat(span("notice",  "Unable to determine variable type."))

	else if(isnum(variable))
		to_chat(span("notice",  "Variable appears to be <b>NUM</b>."))
		default = "num"
		dir = 1

	else if(istext(variable))
		to_chat(span("notice",  "Variable appears to be <b>TEXT</b>."))
		default = "text"

	else if(isloc(variable))
		to_chat(span("notice",  "Variable appears to be <b>REFERENCE</b>."))
		default = "reference"

	else if(isicon(variable))
		to_chat(span("notice",  "Variable appears to be <b>ICON</b>."))
		variable = "\icon[variable]"
		default = "icon"

	else if(istype(variable,/atom) || istype(variable,/datum))
		to_chat(span("notice",  "Variable appears to be <b>TYPE</b>."))
		default = "type"

	else if(istype(variable,/list))
		to_chat(span("notice",  "Variable appears to be <b>LIST</b>."))
		default = "list"

	else if(istype(variable,/client))
		to_chat(span("notice",  "Variable appears to be <b>CLIENT</b>."))
		default = "cancel"

	else
		to_chat(span("notice",  "Variable appears to be <b>FILE</b>."))
		default = "file"

	to_chat(span("notice",  "Variable contains: [variable]"))
	if(dir)
		switch(variable)
			if(1)
				dir = "NORTH"
			if(2)
				dir = "SOUTH"
			if(4)
				dir = "EAST"
			if(8)
				dir = "WEST"
			if(5)
				dir = "NORTHEAST"
			if(6)
				dir = "SOUTHEAST"
			if(9)
				dir = "NORTHWEST"
			if(10)
				dir = "SOUTHWEST"
			else
				dir = null

		if(dir)
			to_chat(span("notice",  "If a direction, direction is: [dir]"))

	var/class = "text"
	var/list/choices = list("text","num","type","reference","mob reference", "icon","file","list","edit referenced object","restore to default")
	if(!isnull(default) && default != "num")
		choices += "edit associated variable"
	choices += "DELETE FROM LIST"

	class = input("What kind of variable?","Variable Type",default) as null|anything in choices

	if(!class)
		return

	switch(class) //Spits a runtime error if you try to modify an entry in the contents list. Dunno how to fix it, yet.

		if("list")
			mod_list(variable)

		if("restore to default")
			L[L.Find(variable)]=initial(variable)

		if("edit referenced object")
			modify_variables(variable)

		if("DELETE FROM LIST")
			L -= variable
			return

		if("text")
			L[L.Find(variable)] = input("Enter new text:","Text") as text

		if("num")
			L[L.Find(variable)] = input("Enter new number:","Num") as num

		if("type")
			L[L.Find(variable)] = input("Enter type:","Type") in typesof(/obj,/mob,/area,/turf)

		if("reference")
			L[L.Find(variable)] = input("Select reference:","Reference") as mob|obj|turf|area in world

		if("mob reference")
			L[L.Find(variable)] = input("Select reference:","Reference") as mob in all_mobs

		if("file")
			L[L.Find(variable)] = input("Pick file:","File") as file

		if("icon")
			L[L.Find(variable)] = input("Pick icon:","Icon") as icon

		//if("marked datum")
		//	L[L.Find(variable)] = holder.marked_datum

		if("edit associated variable")
			var/temp_var = mod_list_add_ass()
			if(temp_var)
				L[variable] = temp_var

/client/proc/modify_variables(var/atom/O, var/param_var_name = null, var/autodetect_class = 0)

	var/class
	var/variable
	var/var_value

	if(param_var_name)
		if(!param_var_name in O.vars)
			to_chat("A variable with this name ([param_var_name]) doesn't exist in this atom ([O])")
			return

		variable = param_var_name

		var_value = O.vars[variable]

		if(autodetect_class)
			if(isnull(var_value))
				to_chat("Unable to determine variable type.")
				class = null
				autodetect_class = null
			else if(isnum(var_value))
				to_chat("Variable appears to be <b>NUM</b>.")
				class = "num"
				dir = 1

			else if(istext(var_value))
				to_chat("Variable appears to be <b>TEXT</b>.")
				class = "text"

			else if(isloc(var_value))
				to_chat("Variable appears to be <b>REFERENCE</b>.")
				class = "reference"

			else if(isicon(var_value))
				to_chat("Variable appears to be <b>ICON</b>.")
				var_value = "\icon[var_value]"
				class = "icon"

			else if(istype(var_value,/atom) || istype(var_value,/datum))
				to_chat("Variable appears to be <b>TYPE</b>.")
				class = "type"

			else if(istype(var_value,/list))
				to_chat("Variable appears to be <b>LIST</b>.")
				class = "list"

			else if(istype(var_value,/client))
				to_chat("Variable appears to be <b>CLIENT</b>.")
				class = "cancel"

			else
				to_chat("Variable appears to be <b>FILE</b>.")
				class = "file"

	else

		var/list/names = list()
		for (var/V in O.vars)
			names += V

		sort_tim(names,cmp=/proc/cmp_text_asc)

		variable = input("Which var?","Var") as null|anything in names
		if(!variable)	return
		var_value = O.vars[variable]

	if(!autodetect_class)

		var/dir
		var/default
		if(isnull(var_value))
			to_chat("Unable to determine variable type.")

		else if(isnum(var_value))
			to_chat("Variable appears to be <b>NUM</b>.")
			default = "num"
			dir = 1

		else if(istext(var_value))
			to_chat("Variable appears to be <b>TEXT</b>.")
			default = "text"

		else if(isloc(var_value))
			to_chat("Variable appears to be <b>REFERENCE</b>.")
			default = "reference"

		else if(isicon(var_value))
			to_chat("Variable appears to be <b>ICON</b>.")
			var_value = "\icon[var_value]"
			default = "icon"

		else if(istype(var_value,/atom) || istype(var_value,/datum))
			to_chat("Variable appears to be <b>TYPE</b>.")
			default = "type"

		else if(istype(var_value,/list))
			to_chat("Variable appears to be <b>LIST</b>.")
			default = "list"

		else if(istype(var_value,/client))
			to_chat("Variable appears to be <b>CLIENT</b>.")
			default = "cancel"

		else
			to_chat("Variable appears to be <b>FILE</b>.")
			default = "file"

		to_chat("Variable contains: [var_value]")
		if(dir)
			switch(var_value)
				if(1)
					dir = "NORTH"
				if(2)
					dir = "SOUTH"
				if(4)
					dir = "EAST"
				if(8)
					dir = "WEST"
				if(5)
					dir = "NORTHEAST"
				if(6)
					dir = "SOUTHEAST"
				if(9)
					dir = "NORTHWEST"
				if(10)
					dir = "SOUTHWEST"
				else
					dir = null
			if(dir)
				to_chat("If a direction, direction is: [dir]")

		class = input("What kind of variable?","Variable Type",default) as null|anything in list("text",
			"num","type","reference","mob reference", "icon","file","list","edit referenced object","restore to default")

		if(!class)
			return

	switch(class)

		if("list")
			mod_list(O.vars[variable])
			return

		if("restore to default")
			O.vars[variable] = initial(O.vars[variable])

		if("edit referenced object")
			return .(O.vars[variable])

		if("text")
			var/var_new = input("Enter new text:","Text",O.vars[variable]) as null|text
			if(var_new==null) return
			O.vars[variable] = var_new

		if("num")
			/*if(variable=="luminosity")
				var/var_new = input("Enter new number:","Num",O.vars[variable]) as null|num
				if(var_new == null) return
				O.SetLuminosity(var_new)
			else if(variable=="stat")
				var/var_new = input("Enter new number:","Num",O.vars[variable]) as null|num
				if(var_new == null) return
				if((O.vars[variable] == 2) && (var_new < 2))//Bringing the dead back to life
					dead_mob_list -= O
					living_mob_list += O
				if((O.vars[variable] < 2) && (var_new == 2))//Kill he
					living_mob_list -= O
					dead_mob_list += O
				O.vars[variable] = var_new
			else*/
			var/var_new =  input("Enter new number:","Num",O.vars[variable]) as null|num
			if(var_new==null) return
			O.vars[variable] = var_new

		if("type")
			var/var_new = input("Enter type:","Type",O.vars[variable]) as null|anything in typesof(/obj,/mob,/area,/turf)
			if(var_new==null) return
			O.vars[variable] = var_new

		if("reference")
			var/var_new = input("Select reference:","Reference",O.vars[variable]) as null|mob|obj|turf|area in world
			if(var_new==null) return
			O.vars[variable] = var_new

		if("mob reference")
			var/var_new = input("Select reference:","Reference",O.vars[variable]) as null|mob in all_mobs
			if(var_new==null) return
			O.vars[variable] = var_new

		if("file")
			var/var_new = input("Pick file:","File",O.vars[variable]) as null|file
			if(var_new==null) return
			O.vars[variable] = var_new

		if("icon")
			var/var_new = input("Pick icon:","Icon",O.vars[variable]) as null|icon
			if(var_new==null) return
			O.vars[variable] = var_new

/client/proc/cmd_mass_modify_object_variables(atom/A, var/var_name)
	set category = "Debug"
	set name = "Mass Edit Variables"
	set desc="(target) Edit all instances of a target item's variables"

	var/method = 0	//0 means strict type detection while 1 means this type and all subtypes (IE: /obj/item with this set to 1 will set it to ALL itms)

	if(!usr.client || !(permissions & FLAG_PERMISSION_MODERATOR))
		to_chat("\red You need to be a moderator or higher to access this.")
		return

	if(A && A.type)
		if(typesof(A.type))
			switch(input("Strict object type detection?") as null|anything in list("Strictly this type","This type and subtypes", "Cancel"))
				if("Strictly this type")
					method = 0
				if("This type and subtypes")
					method = 1
				if("Cancel")
					return
				if(null)
					return

	src.massmodify_variables(A, var_name, method)

/client/proc/massmodify_variables(var/atom/O, var/var_name = "", var/method = 0)

	var/list/names = list()
	for (var/V in O.vars)
		names += V

	sort_tim(names,cmp=/proc/cmp_text_asc)

	var/variable = ""

	if(!var_name)
		variable = input("Which var?","Var") as null|anything in names
	else
		variable = var_name

	if(!variable)	return
	var/default
	var/var_value = O.vars[variable]
	var/dir

	if(isnull(var_value))
		to_chat(span("notice", "Unable to determine variable type."))

	else if(isnum(var_value))
		to_chat(span("notice", "Variable appears to be <b>NUM</b>."))
		default = "num"
		dir = 1

	else if(istext(var_value))
		to_chat(span("notice", "Variable appears to be <b>TEXT</b>."))
		default = "text"

	else if(isloc(var_value))
		to_chat(span("notice", "Variable appears to be <b>REFERENCE</b>."))
		default = "reference"

	else if(isicon(var_value))
		to_chat(span("notice", "Variable appears to be <b>ICON</b>."))
		var_value = "\icon[var_value]"
		default = "icon"

	else if(istype(var_value,/atom) || istype(var_value,/datum))
		to_chat(span("notice", "Variable appears to be <b>TYPE</b>."))
		default = "type"

	else if(istype(var_value,/list))
		to_chat(span("notice", "Variable appears to be <b>LIST</b>."))
		default = "list"

	else if(istype(var_value,/client))
		to_chat(span("notice", "Variable appears to be <b>CLIENT</b>."))
		default = "cancel"

	else
		to_chat(span("notice", "Variable appears to be <b>FILE</b>."))
		default = "file"

	to_chat(span("notice", "Variable contains: [var_value]"))
	if(dir)
		switch(var_value)
			if(1)
				dir = "NORTH"
			if(2)
				dir = "SOUTH"
			if(4)
				dir = "EAST"
			if(8)
				dir = "WEST"
			if(5)
				dir = "NORTHEAST"
			if(6)
				dir = "SOUTHEAST"
			if(9)
				dir = "NORTHWEST"
			if(10)
				dir = "SOUTHWEST"
			else
				dir = null
		if(dir)
			to_chat(span("notice", "If a direction, direction is: [dir]"))

	var/class = input("What kind of variable?","Variable Type",default) as null|anything in list("text",
		"num","type","icon","file","edit referenced object","restore to default")

	if(!class)
		return

	switch(class)

		if("restore to default")
			O.vars[variable] = initial(O.vars[variable])
			if(method)
				if(istype(O, /mob))
					for(var/mob/M in all_mobs)
						if ( istype(M , O.type) )
							M.vars[variable] = O.vars[variable]

				else if(istype(O, /obj))
					for(var/obj/A in world)
						if ( istype(A , O.type) )
							A.vars[variable] = O.vars[variable]

				else if(istype(O, /turf))
					for(var/turf/A in world)
						if ( istype(A , O.type) )
							A.vars[variable] = O.vars[variable]

			else
				if(istype(O, /mob))
					for(var/mob/M in all_mobs)
						if (M.type == O.type)
							M.vars[variable] = O.vars[variable]

				else if(istype(O, /obj))
					for(var/obj/A in world)
						if (A.type == O.type)
							A.vars[variable] = O.vars[variable]

				else if(istype(O, /turf))
					for(var/turf/A in world)
						if (A.type == O.type)
							A.vars[variable] = O.vars[variable]

		if("edit referenced object")
			return .(O.vars[variable])

		if("text")
			var/new_value = input("Enter new text:","Text",O.vars[variable]) as text|null
			if(new_value == null) return
			O.vars[variable] = new_value

			if(method)
				if(istype(O, /mob))
					for(var/mob/M in all_mobs)
						if ( istype(M , O.type) )
							M.vars[variable] = O.vars[variable]

				else if(istype(O, /obj))
					for(var/obj/A in world)
						if ( istype(A , O.type) )
							A.vars[variable] = O.vars[variable]

				else if(istype(O, /turf))
					for(var/turf/A in world)
						if ( istype(A , O.type) )
							A.vars[variable] = O.vars[variable]
			else
				if(istype(O, /mob))
					for(var/mob/M in all_mobs)
						if (M.type == O.type)
							M.vars[variable] = O.vars[variable]

				else if(istype(O, /obj))
					for(var/obj/A in world)
						if (A.type == O.type)
							A.vars[variable] = O.vars[variable]

				else if(istype(O, /turf))
					for(var/turf/A in world)
						if (A.type == O.type)
							A.vars[variable] = O.vars[variable]

		if("num")
			var/new_value = input("Enter new number:","Num",\
					O.vars[variable]) as num|null
			if(new_value == null) return

			/*if(variable=="luminosity")
				O.SetLuminosity(new_value)
			else*/
			O.vars[variable] = new_value

			if(method)
				if(istype(O, /mob))
					for(var/mob/M in all_mobs)
						if ( istype(M , O.type) )
							/*if(variable=="luminosity")
								M.SetLuminosity(new_value)
							else*/
							M.vars[variable] = O.vars[variable]

				else if(istype(O, /obj))
					for(var/obj/A in world)
						if ( istype(A , O.type) )
							/*if(variable=="luminosity")
								A.SetLuminosity(new_value)
							else*/
							A.vars[variable] = O.vars[variable]

				else if(istype(O, /turf))
					for(var/turf/A in world)
						if ( istype(A , O.type) )
							/*if(variable=="luminosity")
								A.SetLuminosity(new_value)
							else*/
							A.vars[variable] = O.vars[variable]

			else
				if(istype(O, /mob))
					for(var/mob/M in all_mobs)
						if (M.type == O.type)
							/*if(variable=="luminosity")
								M.SetLuminosity(new_value)
							else*/
							M.vars[variable] = O.vars[variable]

				else if(istype(O, /obj))
					for(var/obj/A in world)
						if (A.type == O.type)
							/*if(variable=="luminosity")
								A.SetLuminosity(new_value)
							else*/
							A.vars[variable] = O.vars[variable]

				else if(istype(O, /turf))
					for(var/turf/A in world)
						if (A.type == O.type)
							/*if(variable=="luminosity")
								A.SetLuminosity(new_value)
							else*/
							A.vars[variable] = O.vars[variable]

		if("type")
			var/new_value
			new_value = input("Enter type:","Type",O.vars[variable]) as null|anything in typesof(/obj,/mob,/area,/turf)
			if(new_value == null) return
			O.vars[variable] = new_value
			if(method)
				if(istype(O, /mob))
					for(var/mob/M in all_mobs)
						if ( istype(M , O.type) )
							M.vars[variable] = O.vars[variable]

				else if(istype(O, /obj))
					for(var/obj/A in world)
						if ( istype(A , O.type) )
							A.vars[variable] = O.vars[variable]

				else if(istype(O, /turf))
					for(var/turf/A in world)
						if ( istype(A , O.type) )
							A.vars[variable] = O.vars[variable]
			else
				if(istype(O, /mob))
					for(var/mob/M in all_mobs)
						if (M.type == O.type)
							M.vars[variable] = O.vars[variable]

				else if(istype(O, /obj))
					for(var/obj/A in world)
						if (A.type == O.type)
							A.vars[variable] = O.vars[variable]

				else if(istype(O, /turf))
					for(var/turf/A in world)
						if (A.type == O.type)
							A.vars[variable] = O.vars[variable]

		if("file")
			var/new_value = input("Pick file:","File",O.vars[variable]) as null|file
			if(new_value == null) return
			O.vars[variable] = new_value

			if(method)
				if(istype(O, /mob))
					for(var/mob/M in all_mobs)
						if ( istype(M , O.type) )
							M.vars[variable] = O.vars[variable]

				else if(istype(O.type, /obj))
					for(var/obj/A in world)
						if ( istype(A , O.type) )
							A.vars[variable] = O.vars[variable]

				else if(istype(O.type, /turf))
					for(var/turf/A in world)
						if ( istype(A , O.type) )
							A.vars[variable] = O.vars[variable]
			else
				if(istype(O, /mob))
					for(var/mob/M in all_mobs)
						if (M.type == O.type)
							M.vars[variable] = O.vars[variable]

				else if(istype(O.type, /obj))
					for(var/obj/A in world)
						if (A.type == O.type)
							A.vars[variable] = O.vars[variable]

				else if(istype(O.type, /turf))
					for(var/turf/A in world)
						if (A.type == O.type)
							A.vars[variable] = O.vars[variable]

		if("icon")
			var/new_value = input("Pick icon:","Icon",O.vars[variable]) as null|icon
			if(new_value == null) return
			O.vars[variable] = new_value
			if(method)
				if(istype(O, /mob))
					for(var/mob/M in all_mobs)
						if ( istype(M , O.type) )
							M.vars[variable] = O.vars[variable]

				else if(istype(O, /obj))
					for(var/obj/A in world)
						if ( istype(A , O.type) )
							A.vars[variable] = O.vars[variable]

				else if(istype(O, /turf))
					for(var/turf/A in world)
						if ( istype(A , O.type) )
							A.vars[variable] = O.vars[variable]

			else
				if(istype(O, /mob))
					for(var/mob/M in all_mobs)
						if (M.type == O.type)
							M.vars[variable] = O.vars[variable]

				else if(istype(O, /obj))
					for(var/obj/A in world)
						if (A.type == O.type)
							A.vars[variable] = O.vars[variable]

				else if(istype(O, /turf))
					for(var/turf/A in world)
						if (A.type == O.type)
							A.vars[variable] = O.vars[variable]


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* 21st Sept 2010
Updated by Skie -- Still not perfect but better!
Stuff you can't do:
Call proc /mob/proc/make_dizzy() for some player
Because if you select a player mob as owner it tries to do the proc for
/mob/living/carbon/human/ instead. And that gives a run-time error.
But you can call procs that are of type /mob/living/carbon/human/proc/ for that player.
*/

/client/proc/callproc(var/target = null)
	set category = "Debug"
	set name = "Advanced ProcCall"
	set waitfor = 0

	if(!usr.client || !(permissions & FLAG_PERMISSION_MODERATOR))
		to_chat("\red You need to be a moderator or higher to access this.")
		return

	var/targetselected = 0
	var/lst[] // List reference
	lst = new/list() // Make the list
	var/returnval = null
	var/class = null

	if(!target)
		switch(alert("Proc owned by something?",,"Yes","No"))
			if("Yes")
				targetselected = 1
				class = input("Proc owned by...","Owner",null) as null|anything in list("Obj","Mob","Area or Turf","Client")
				switch(class)
					if("Obj")
						target = input("Enter target:","Target",usr) as obj in world
					if("Mob")
						target = input("Enter target:","Target",usr) as mob in all_mobs
					if("Area or Turf")
						target = input("Enter target:","Target",usr.loc) as area|turf in world
					if("Client")
						var/list/keys = list()
						for(var/client/C)
							keys += C
						target = input("Please, select a player!", "Selection", null, null) as null|anything in keys
					else
						return
			if("No")
				target = null
				targetselected = 0
	else targetselected = 1

	var/procname = input("Proc path, eg: /proc/fake_blood","Path:", null) as text|null
	if(!procname)	return

	var/argnum = input("Number of arguments","Number:",0) as num|null
	if(!argnum && (argnum!=0))	return

	lst.len = argnum // Expand to right length
	//TODO: make a list to store whether each argument was initialised as null.
	//Reason: So we can abort the proccall if say, one of our arguments was a mob which no longer exists
	//this will protect us from a fair few errors ~Carn

	var/i
	for(i=1, i<argnum+1, i++) // Lists indexed from 1 forwards in byond

		// Make a list with each index containing one variable, to be given to the proc
		class = input("What kind of variable?","Variable Type") in list("text","num","type","reference","mob reference","icon","file","client","mob's area","CANCEL")
		switch(class)
			if("CANCEL")
				return

			if("text")
				lst[i] = input("Enter new text:","Text",null) as text

			if("num")
				lst[i] = input("Enter new number:","Num",0) as num

			if("type")
				lst[i] = input("Enter type:","Type") in typesof(/obj,/mob,/area,/turf)

			if("reference")
				lst[i] = input("Select reference:","Reference",src) as mob|obj|turf|area in world

			if("mob reference")
				lst[i] = input("Select reference:","Reference",usr) as mob in all_mobs

			if("file")
				lst[i] = input("Pick file:","File") as file

			if("icon")
				lst[i] = input("Pick icon:","Icon") as icon

			if("client")
				var/list/keys = list()
				for(var/mob/M in all_players)
					keys += M.client
				lst[i] = input("Please, select a player!", "Selection", null, null) as null|anything in keys

			if("mob's area")
				var/mob/temp = input("Select mob", "Selection", usr) as mob in all_mobs
				lst[i] = temp.loc

	if(targetselected)
		if(!target)
			to_chat(span("warning","<font color='red'>Error: callproc(): owner of proc no longer exists.</font>"))
			return

		var/actual_name = procname
		//Remove the "/proc/" in front of the actual name
		if(findtext(procname, "/proc/"))
			actual_name = replacetext(procname, "/proc/", "")
		else if(findtext(procname, "/proc"))
			actual_name = replacetext(procname, "/proc", "")
		else if(findtext(procname, "proc/"))
			actual_name = replacetext(procname, "proc/", "")
		//Remove Parenthesis if any
		actual_name = replacetext(actual_name, "()", "")

		if(!hascall(target,actual_name))
			to_chat(span("warning","<font color='red'>Error: callproc(): target has no such call [procname].</font>"))
			return
		//log_admin("[key_name(src)] called [target]'s [procname]() with [lst.len ? "the arguments [list2params(lst)]":"no arguments"].")
		returnval = call(target,actual_name)(arglist(lst)) // Pass the lst as an argument list to the proc
	else
		//this currently has no hascall protection. wasn't able to get it working.
		//log_admin("[key_name(src)] called [procname]() with [lst.len ? "the arguments [list2params(lst)]":"no arguments"].")
		returnval = call(procname)(arglist(lst)) // Pass the lst as an argument list to the proc

	to_chat(span("warning","<font color='blue'>[procname] returned: [returnval ? returnval : "null"]</font>"))



//					||||||||||||||||||Atom spawn||||||||||||||||||||			\\

/client/proc/spawn_atom(object as text)
	set category = "Debug"
	set desc = "(atom path) Spawn an atom"
	set name = "Spawn"

	if(!usr.client || !(permissions & FLAG_PERMISSION_MODERATOR))
		to_chat("\red You need to be a moderator or higher to access this.")
		return

	var/list/matches = get_fancy_list_of_types()
	if (!isnull(object) && object!="")
		matches = filter_fancy_list(matches, object)

	if(matches.len==0)
		return

	var/chosen
	if(matches.len==1)
		chosen = matches[1]
	else
		chosen = input("Select an atom type", "Spawn Atom", matches[1]) as null|anything in matches
		if(!chosen)
			return
	chosen = matches[chosen]

	/*if(ispath(chosen,/turf))
		var/turf/T = get_turf(usr.loc)
		T.ChangeTurf(chosen)
	else*/
	var/atom/A = new chosen(usr.loc)
	INITIALIZE(A)
	if(is_atom(A))
		var/atom/O = A
		O.set_dir(mob ? mob.dir : SOUTH)
		GENERATE(O)
	FINALIZE(A)

/*var/list/TYPES_SHORTCUTS = list(
	/obj/effect/decal/cleanable = "CLEANABLE",
	/obj/item/device/radio/headset = "HEADSET",
	/obj/item/clothing/head/helmet/space = "SPESSHELMET",
	/obj/item/weapon/book/manual = "MANUAL",
	/obj/item/weapon/reagent_containers/food/drinks = "DRINK", //longest paths comes first
	/obj/item/weapon/reagent_containers/food = "FOOD",
	/obj/item/weapon/reagent_containers = "REAGENT_CONTAINERS",
	/obj/machinery/atmospherics = "ATMOS",
	/obj/machinery/portable_atmospherics = "PORT_ATMOS",
	/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/missile_rack = "MECHA_MISSILE_RACK",
	/obj/item/mecha_parts/mecha_equipment = "MECHA_EQUIP",
	/obj/item/organ/internal = "ORGAN_INT",
)*/ //Well. We are not using this, but thought that this can be useful if someone actually needs it

var/global/list/g_fancy_list_of_types = null
/proc/get_fancy_list_of_types()
	if (isnull(g_fancy_list_of_types)) //init
		var/list/temp = sort_tim(subtypesof(/atom) - typesof(/area) - /atom/movable,cmp=/proc/cmp_path_asc)
		g_fancy_list_of_types = new(temp.len)
		for(var/type in temp)
			var/typename = "[type]"
			/*for (var/tn in TYPES_SHORTCUTS)
				if (copytext_char(typename,1, length("[tn]/")+1)=="[tn]/" /*findtextEx_char(typename,"[tn]/",1,2)*/ )
					typename = TYPES_SHORTCUTS[tn]+copytext_char(typename,length("[tn]/"))
					break*/
			g_fancy_list_of_types[typename] = type
	return g_fancy_list_of_types

/proc/filter_fancy_list(list/L, filter as text)
	var/list/matches = new
	for(var/key in L)
		var/value = L[key]
		if(findtext_char("[key]", filter) || findtext_char("[value]", filter))
			matches[key] = value
	return matches
