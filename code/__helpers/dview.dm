// Dummy mob.
/mob/dview
	// Can't make it invisible enough.
	invisibility = 101
	density      = 0
	alpha        = 0
	opacity      = 0

	see_in_dark  = 1e6 // Literally arbitrary.

/var/mob/dview/dview = new


// Version of view() that ignores luminosity and allows you to set
/proc/dview(var/range = world.view, var/atom/source, var/see_invisible = 0)
	dview.loc           = source
	dview.see_invisible = see_invisible

	return view(range, dview)

// for(thing in view()) is optimized so view() only returns the thing looked for by the for loop, this is a native BYOND feature, as using the above dview() would not work for that, this define will.
#define FOR_DVIEW(type, range, source, see_invis) \
	dview.loc           = source;                 \
	dview.see_invisible = see_invis;              \
	for(type in view(range, dview))
