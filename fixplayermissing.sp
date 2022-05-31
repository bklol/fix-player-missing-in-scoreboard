#pragma semicolon 1

#include <sourcemod>
#include <sdkhooks>
#include <sdktools>

public Plugin myinfo = 
{
    name = "fix player missing in scoreboard",
    author = "neko aka bklol",
    description = "fix player missing in scoreboard usually happening when player reconnect server...",
    version = "0.1",
    url = "https://github.com/bklol"
};

public void OnMapStart() 
{
	SDKHook(GetPlayerResourceEntity(), SDKHook_ThinkPost, Hook_OnThinkPost);
}

public void Hook_OnThinkPost(int iEnt) 
{
	static iConnectedOffset = -1;
	if (iConnectedOffset == -1) 
	{
		iConnectedOffset = FindSendPropInfo("CCSPlayerResource", "m_bConnected");
	}
    
	int iConnected[65];
	GetEntDataArray(iEnt, iConnectedOffset, iConnected, MaxClients + 1);  
	for (int i = 1; i <= MaxClients; i++) 
	{
		if (IsClientInGame(i)) 
		{
			if(GetClientTeam(i) < 1)
				iConnected[i] = 0;
			else
				iConnected[i] = 1;
		}
		
	}
	SetEntDataArray(iEnt, iConnectedOffset, iConnected, MaxClients + 1);
} 
