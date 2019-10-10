#define INTERACT_CHECK if(!can_interact(caller)) return TRUE
//The above needs to return true because returing false means that it will try to repeat it using a different method.