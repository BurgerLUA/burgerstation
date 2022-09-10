/menu/

	var/file
	var/list/resources = list()

	var/size = "300x300"
	var/border = FALSE
	var/can_close = TRUE
	var/can_resize = TRUE
	var/can_minimize = TRUE
	var/show_titlebar = TRUE

/menu/proc/open(var/mob/user)
	//Credit to Multiverse7 for providing the code for getting this to work.
	cache_resources(user)
	winclone(user, "window", type)
	winshow(user,type)
	winset(user, "browser([type])", "parent=[type];type=browser;size=0x0;anchor1=0,0;anchor2=100,100")
	//Onload is called by the client in another proc.

/menu/proc/close(var/mob/user)
	winset(user, "browser([type])","is-visible:false")

/menu/proc/run_function(var/user, var/function_name,var/args)
	user << output("[function_name]([args]);", "browser([type]):eval")

/menu/proc/on_load(var/mob/user)
	//When the browser sucessfully loaded.
	user << output(file, "browser([type])")
	winset(user, "browser([type])", "parent=[type];size=[size]")

/menu/proc/cache_resources(var/mob/user)
	for(var/k in resources)
		var/v = resources[k]
		user << browse_rsc(v,k)

/menu/Topic(href,href_list)
	return ..()