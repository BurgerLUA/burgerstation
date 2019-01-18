// This stub is a del() alternative (if implemented from SS13).
// It essentially makes sure something gets deleted, but attempts to make BYOND's built-in GC do it by attempting to remove all references.
// This gets done by calling Destroy(), note that this is, obviously, a stub.
/proc/qdel(var/datum/thing)
	thing.Destroy()

// Generic proc for removing all references to the datum it is ran on.
/datum/proc/Destroy()
	del(src)

// Returns 1 if the datum is deleted.
// Might seem weird but it makes sense with a custom GC.
/datum/proc/deleted()
	return 0
