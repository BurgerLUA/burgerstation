var/mob/abstract/dview/dview = new


// Version of view() that ignores luminosity and allows you to set
/proc/dview(var/range = world.view, var/atom/source, var/see_invisible = 0)
	dview.loc           = source
	dview.see_invisible = see_invisible

	return view(range, dview)

#define FOR_DVIEW(type, range, center, invis_flags) \
	dview.loc = center; \
	dview.see_invisible = invis_flags; \
	for(type in view(range, dview))

#define END_FOR_DVIEW dview.loc = null