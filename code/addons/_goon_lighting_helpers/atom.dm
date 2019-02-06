// Gets the turf under an atom (or the src if it IS a turf).
// Technically I'm unsure of the license since Lummox Jr. wrote it.
/*
/proc/get_turf(var/atom/O)
	if(isnull(O) || isarea(O) || !istype(O))
		return

	var/atom/A
	for(A=O, A && !isturf(A), A=A.loc);  // semicolon is for the empty statement
	. = A
*/

// It's like doing loc = someplace, except it calls Crossed(), Entered() and Exited() wherever appropriate.
// This is needed to notify the light source that we've updated.
/*
/atom/movable/proc/forceMove(var/atom/new_loc)
	if(loc)
		loc.Exited(src, new_loc)

	var/atom/old_loc = loc

	loc = new_loc

	if(loc) // Moving to nullspace is a perfectly valid usage of this proc.
		loc.Entered(src, old_loc)

	for(var/atom/movable/AM in loc)
		AM.Crossed(src)
*/
