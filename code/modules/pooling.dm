// Stubs related to pooling.
// The concept of pooling is that instead of deleting and new()-ing everything, we store certain datums in a master list to "recycle" them.

/proc/returnToPool(thing)
	qdel(thing)

/proc/getFromPool(type)
	var/list/new_args = args.Copy(2)
	return new type(arglist(new_args))
