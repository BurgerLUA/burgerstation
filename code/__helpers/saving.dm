#define SAVEVAR(varname) .[varname] = vars[varname]
#define LOADVAR(varname) if(isnum(object_data)) vars[varname] = object_data[varname]