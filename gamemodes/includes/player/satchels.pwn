new charge;

CMD:breach(playerid, params[])
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	charge = CreateDynamicObject(1654, x+3, y, z, 0, 0, 0, -1, -1, playerid, 3000, 3000, -1, 0);
	EditDynamicObject(playerid, charge);
	return 1;
}

CMD:clearbreach(playerid, params[])
{
	DestroyDynamicObject(charge);
	return 1;
}