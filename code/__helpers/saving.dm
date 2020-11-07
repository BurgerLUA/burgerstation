#define SAVEVAR(varname) if(!isnull(vars[varname])) .[varname] = vars[varname]
#define LOADVAR(varname) if(!isnull(object_data)) vars[varname] = object_data[varname]

#define SAVEATOM(varname) if(vars[varname]) .[varname] = vars[varname].save_item_data(save_inventory)
#define LOADATOM(varname) if(object_data[varname]) vars[varname] = load_and_create(P,object_data[varname],src)


#define SAVELISTATOM(varname) if(length(vars[varname])) {.[varname] = list(); for(var/obj/item/k in vars[varname]) .[varname] += list(k.save_item_data(save_inventory))}
#define LOADLISTATOM(varname) if(length(object_data[varname])) {for(var/k in object_data[varname]) vars[varname] += load_and_create(P,k,src)}

#define SAVEPATH(varname) if(!isnull(vars[varname])) .[varname] = vars[varname]
#define LOADPATH(varname) if(!isnull(object_data)) vars[varname] = text2path(object_data[varname])