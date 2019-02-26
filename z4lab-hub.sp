#include <sourcemod>
#include <colorvariables>

public Plugin myinfo =
{
	name = "z4lab-hub",
	author = "totles",
	description = "z4lab hub [chat info, welcome message]",
	version = "0.1",
	url = "https://z4lab.com"
};

// define chat prefix
new String:g_hChatPrefix[] = "[{lightgreen}z4lab{default}] {gold}#{bluegrey}";
bool g_bMessagesShown[MAXPLAYERS + 1];

public void OnPluginStart()
{
	CreateCommands();
	LoadTranslations("z4lab.phrases");
	HookEvent("player_spawn", Event_OnPlayerSpawn);
}

public void OnMapStart()
{
	for (int i = 1; i <= MaxClients; i++)
	{
		g_bMessagesShown[i] = false;
	}
}

void CreateCommands()
{
	RegConsoleCmd("sm_z4lab", z4labMain, "displays all z4lab commands");
	RegConsoleCmd("sm_rules", z4labRules, "displays our community rules");
	RegConsoleCmd("sm_homepage", z4labHomepage, "shows our community rules");
	RegConsoleCmd("sm_website", z4labHomepage, "shows our community rules");
	RegConsoleCmd("sm_link", z4labHomepage, "shows our community rules");
	RegConsoleCmd("sm_manifesto", z4labManifesto, "shows our community rules");
	RegConsoleCmd("sm_changelog", z4labChangelog, "shows our community rules");
	RegConsoleCmd("sm_changes", z4labChangelog, "shows our community rules");
	RegConsoleCmd("sm_giveaway", z4labGiveaway, "shows our community rules");
	RegConsoleCmd("sm_howtosurf", z4labHowtosurf, "shows our community rules");
	RegConsoleCmd("sm_discord", z4labDiscord, "shows our community rules");
	RegConsoleCmd("sm_teamspeak", z4labTeamspeak, "shows our community rules");
	RegConsoleCmd("sm_ts", z4labTeamspeak, "shows our community rules");
	RegConsoleCmd("sm_steamgroup", z4labSteamgroup, "shows our community rules");
	RegConsoleCmd("sm_steam", z4labSteamgroup, "shows our community rules");
	RegConsoleCmd("sm_skins", z4labSkins, "prints default message for skins");
	RegConsoleCmd("sm_ws", z4labSkins, "prints default message for skins");
	RegConsoleCmd("sm_gloves", z4labSkins, "prints default message for skins");
	RegConsoleCmd("sm_glove", z4labSkins, "prints default message for skins");
}

// chat replay (commands)
public Action z4labMain(int client, int args)
{
	CPrintToChat(client, "%t", "z4labMain", g_hChatPrefix);
}

public Action z4labHomepage(int client, int args)
{
	CPrintToChat(client, "%t", "z4labHomepage", g_hChatPrefix);
}

public Action z4labManifesto(int client, int args)
{
	CPrintToChat(client, "%t", "z4labManifesto", g_hChatPrefix);
}

public Action z4labChangelog(int client, int args)
{
	CPrintToChat(client, "%t", "z4labChangelog", g_hChatPrefix);
}

public Action z4labRules(int client, int args)
{
	CPrintToChat(client, "%t", "z4labRules", g_hChatPrefix);
}

public Action z4labGiveaway(int client, int args)
{
	CPrintToChat(client, "%t", "z4labGiveaway", g_hChatPrefix);
}

public Action z4labHowtosurf(int client, int args)
{
	CPrintToChat(client, "%t", "z4labHowtosurf", g_hChatPrefix);
}

public Action z4labDiscord(int client, int args)
{
	CPrintToChat(client, "%t", "z4labDiscord", g_hChatPrefix);
}

public Action z4labTeamspeak(int client, int args)
{
	CPrintToChat(client, "%t", "z4labTeamspeak", g_hChatPrefix);
}

public Action z4labSteamgroup(int client, int args)
{
	CPrintToChat(client, "%t", "z4labSteamgroup", g_hChatPrefix);
}

public Action z4labSkins(int client, int args)
{
	PrintHintText(client, "<font color='#bf616a'>NO - this will never happen</font>\ntry {gold}!manifesto");
}

// welcome message
public void Event_OnPlayerSpawn(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	
	if (client == 0 || IsFakeClient(client))
	{
		return;
	}
	CreateTimer(1.5, Timer_DelaySpawn, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
}

public Action Timer_DelaySpawn(Handle timer, any data)
{
	int client = GetClientOfUserId(data);
	
	if (client == 0 || !IsPlayerAlive(client) || g_bMessagesShown[client])
	{
		return Plugin_Continue;
	}

	CPrintToChat(client, "%t", "z4labWelcome1", g_hChatPrefix);
	CPrintToChat(client, "%t", "z4labWelcome2", g_hChatPrefix);
	CPrintToChat(client, "%t", "z4labWelcome3", g_hChatPrefix);
	CPrintToChat(client, "%t", "z4labWelcome4", g_hChatPrefix);
	g_bMessagesShown[client] = true;
	
	return Plugin_Continue;
}

public void OnClientDisconnect(int client)
{
	g_bMessagesShown[client] = false;
}