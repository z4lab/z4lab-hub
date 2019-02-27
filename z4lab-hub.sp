#include <sourcemod>
#include <colorvariables>
#include <sdktools>

#define DEFAULT_TIMER_FLAGS TIMER_REPEAT | TIMER_FLAG_NO_MAPCHANGE

public Plugin myinfo =
{
	name = "z4lab-hub",
	author = "totles",
	description = "z4lab hub [chat info, welcome message]",
	version = "0.1",
	url = "https://z4lab.com"
};

// set your chat prefix
new String:g_hChatPrefix[] = "[{lightgreen}z4lab{default}] {gold}#{bluegrey}";

// general settings/stuff
bool g_bMessagesShown[MAXPLAYERS + 1];

public void OnPluginStart()
{
	CreateCommands();
	LoadTranslations("z4lab.phrases");
	HookEvent("player_spawn", Event_OnPlayerSpawn);
	CreateTimer( 10.0, Chat_Interval, _, DEFAULT_TIMER_FLAGS );
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
	RegConsoleCmd("sm_z4lab", z4labMain, "[z4lab-hub] displays all z4lab commands");
	RegConsoleCmd("sm_rules", z4labRules, "[z4lab-hub] displays our community rules");
	RegConsoleCmd("sm_homepage", z4labHomepage, "[z4lab-hub] displays a link to our homepage");
	RegConsoleCmd("sm_website", z4labHomepage, "[z4lab-hub] displays a link to our homepage");
	RegConsoleCmd("sm_link", z4labHomepage, "[z4lab-hub] displays a link to our homepage");
	RegConsoleCmd("sm_manifesto", z4labManifesto, "[z4lab-hub] displays a link to our manifesto");
	RegConsoleCmd("sm_changelog", z4labChangelog, "[z4lab-hub] displays a link to our changes");
	RegConsoleCmd("sm_changes", z4labChangelog, "[z4lab-hub] displays a link to our changes");
	RegConsoleCmd("sm_giveaway", z4labGiveaway, "[z4lab-hub] more information for our giveaway");
	RegConsoleCmd("sm_howtosurf", z4labHowtosurf, "[z4lab-hub] shows a video on how to surf");
	RegConsoleCmd("sm_discord", z4labDiscord, "[z4lab-hub] displays our discord link");
	RegConsoleCmd("sm_teamspeak", z4labTeamspeak, "[z4lab-hub] displays our teamspeak information");
	RegConsoleCmd("sm_ts", z4labTeamspeak, "[z4lab-hub] displays our teamspeak information");
	RegConsoleCmd("sm_steamgroup", z4labSteamgroup, "[z4lab-hub] displays a link to our steam group");
	RegConsoleCmd("sm_steam", z4labSteamgroup, "[z4lab-hub] displays a link to our steam group");
	RegConsoleCmd("sm_skins", z4labSkins, "[z4lab-hub] give the user an alerts that we dont support skin changers");
	RegConsoleCmd("sm_ws", z4labSkins, "[z4lab-hub] give the user an alerts that we dont support skin changers");
	RegConsoleCmd("sm_gloves", z4labSkins, "[z4lab-hub] give the user an alerts that we dont support skin changers");
	RegConsoleCmd("sm_glove", z4labSkins, "[z4lab-hub] give the user an alerts that we dont support skin changers");
}

public Action Chat_Interval(Handle timer )
{
    CPrintToChatAll("%t", "z4labAd1", g_hChatPrefix );
    return Plugin_Continue;
}  

// chat replay (commands)
public Action z4labMain(int client, int args)
{
	CPrintToChat(client, "%t", "z4labMain", g_hChatPrefix);
	return Plugin_Handled;
}

public Action z4labHomepage(int client, int args)
{
	CPrintToChat(client, "%t", "z4labHomepage", g_hChatPrefix);
	return Plugin_Handled;
}

public Action z4labManifesto(int client, int args)
{
	CPrintToChat(client, "%t", "z4labManifesto", g_hChatPrefix);
	return Plugin_Handled;
}

public Action z4labChangelog(int client, int args)
{
	CPrintToChat(client, "%t", "z4labChangelog", g_hChatPrefix);
	return Plugin_Handled;
}

public Action z4labRules(int client, int args)
{
	CPrintToChat(client, "%t", "z4labRules", g_hChatPrefix);
	return Plugin_Handled;
}

public Action z4labGiveaway(int client, int args)
{
	CPrintToChat(client, "%t", "z4labGiveaway", g_hChatPrefix);
	return Plugin_Handled;
}

public Action z4labHowtosurf(int client, int args)
{
	CPrintToChat(client, "%t", "z4labHowtosurf", g_hChatPrefix);
	return Plugin_Handled;
}

public Action z4labDiscord(int client, int args)
{
	CPrintToChat(client, "%t", "z4labDiscord", g_hChatPrefix);
	return Plugin_Handled;
}

public Action z4labTeamspeak(int client, int args)
{
	CPrintToChat(client, "%t", "z4labTeamspeak", g_hChatPrefix);
	return Plugin_Handled;
}

public Action z4labSteamgroup(int client, int args)
{
	CPrintToChat(client, "%t", "z4labSteamgroup", g_hChatPrefix);
	return Plugin_Handled;
}

public Action z4labSkins(int client, int args)
{
	PrintCenterText(client, "<font color='#bf616a'>NO NO NO</font> - this will never happen\ncheck out <font color='#d08770'>!manifesto</font>\n<font color='#a3be8c'>https://z4lab.com/rules</font>", 60);
	return Plugin_Handled;
}

// welcome message
public void Event_OnPlayerSpawn(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	
	if (client == 0 || IsFakeClient(client))
	{
		return;
	}
	CreateTimer(2.0, Timer_DelaySpawn, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
}

public Action Timer_DelaySpawn(Handle timer, any data)
{
	int client = GetClientOfUserId(data);
	
	if (client == 0 || !IsPlayerAlive(client) || g_bMessagesShown[client])
	{
		return Plugin_Continue;
	}

	PrintCenterText(client, "<font color='#b48ead'>Welcome - Please see chat for rules</font>\nMore info with <font color='#d08770'>!rules</font> or\n<font color='#a3be8c'>https://z4lab.com/rules</font>", 60);
	CPrintToChat(client, "%t", "z4labWelcome1", g_hChatPrefix, client);
	CPrintToChat(client, "%t", "z4labWelcome2", g_hChatPrefix, client);
	CPrintToChat(client, "%t", "z4labWelcome3", g_hChatPrefix, client);
	CPrintToChat(client, "%t", "z4labWelcome4", g_hChatPrefix, client);
	g_bMessagesShown[client] = true;
	
	return Plugin_Continue;
}

public void OnClientDisconnect(int client)
{
	g_bMessagesShown[client] = false;
}