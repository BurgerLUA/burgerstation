#define SAVEVAR(varname) if(!isnull(vars[varname])) .[varname] = vars[varname]
#define LOADVAR(varname) if(!isnull(object_data)) vars[varname] = object_data[varname]


#define SAVEATOM(varname) if(vars[varname]) .[varname] = vars[varname].save_item_data(save_inventory)
#define LOADATOM(varname) if(object_data[varname]) stored_radio = load_and_create(P,object_data[varname],src)


