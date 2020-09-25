/proc/cmp_numeric_dsc(a,b)
	return b - a

/proc/cmp_numeric_asc(a,b)
	return a - b

/proc/cmp_text_asc(a,b)
	return sorttext(b,a)

/proc/cmp_text_dsc(a,b)
	return sorttext(a,b)

/proc/cmp_path_asc(a,b)
	return sorttext("[b]","[a]")

/proc/cmp_path_dsc(a,b)
	return sorttext("[a]","[b]")

/proc/cmp_name_asc(atom/a, atom/b)
	return sorttext(b.name, a.name)

/proc/cmp_name_dsc(atom/a, atom/b)
	return sorttext(a.name, b.name)

/proc/cmp_recipe_name_asc(var/reagent_recipe/A,var/reagent_recipe/B)
	return sorttext(B.name, A.name)

/proc/cmp_recipe_name_dsc(var/reagent_recipe/A,var/reagent_recipe/B)
	return sorttext(A.name, B.name)

// Datum cmp with vars is always slower than a specialist cmp proc, use your judgement.
/proc/cmp_datum_numeric_asc(datum/a, datum/b, variable)
	return cmp_numeric_asc(a.vars[variable], b.vars[variable])

/proc/cmp_datum_numeric_dsc(datum/a, datum/b, variable)
	return cmp_numeric_dsc(a.vars[variable], b.vars[variable])

/proc/cmp_datum_text_asc(datum/a, datum/b, variable)
	return sorttext(b.vars[variable], a.vars[variable])

/proc/cmp_datum_text_dsc(datum/a, datum/b, variable)
	return sorttext(a.vars[variable], b.vars[variable])

/proc/cmp_ckey_asc(client/a, client/b)
	return sorttext(b.ckey, a.ckey)

/proc/cmp_ckey_dsc(client/a, client/b)
	return sorttext(a.ckey, b.ckey)
//This is an example comment
/proc/cmp_subsystem_display(subsystem/a, subsystem/b)
	return sorttext(b.name, a.name)

/proc/cmp_subsystem_priority(subsystem/a, subsystem/b)
	return cmp_numeric_asc(a.priority,b.priority)

/proc/cmp_layer(atom/a, atom/b)
	return cmp_numeric_asc(a.layer,b.layer)

/proc/cmp_icon_blend_layer(icon_blend/a, icon_blend/b)
	return cmp_numeric_dsc(a.layer,b.layer)

/proc/cmp_list_data_priority(list/A, list/B)
	return A["priority"] - B["priority"]

/proc/cmp_atom_layer_asc(atom/A,atom/B)
	if(A.plane != B.plane)
		return A.plane - B.plane
	else
		return A.layer - B.layer

/proc/cmp_reagents_asc(reagent/a, reagent/b)
	return sorttext(initial(b.name),initial(a.name))

/proc/cmp_typepaths_asc(A, B)
	return sorttext("[B]","[A]")
