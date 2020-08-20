#define SAFEVAR(obj,variable) ispath(obj) ? initial(obj.##variable) : obj.##variable


#define SET(varname,desiredvalue) if(desiredvalue) varname = desiredvalue
#define ADD(varname,desiredvalue) if(desiredvalue) varname += desiredvalue
#define MUL(varname,desiredvalue) if(desiredvalue) varname *= desiredvalue