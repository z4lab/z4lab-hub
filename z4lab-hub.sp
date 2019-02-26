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
	// z4lab main command, shows all available commands and info
	//RegConsoleCmd("sm_z4lab", z4labMain, "displays all z4lab commands");

	// z4lab rules
	RegConsoleCmd("sm_rules", z4labRules, "displays our community rules");

	// z4lab weblinks
	//RegConsoleCmd("sm_homepage", z4labHomepage, "shows our community rules");
	//RegConsoleCmd("sm_website", z4labHomepage, "shows our community rules");
	//RegConsoleCmd("sm_link", z4labHomepage, "shows our community rules");
	//RegConsoleCmd("sm_manifesto", z4labManifesto, "shows our community rules");
	//RegConsoleCmd("sm_changelog", z4labChangelog, "shows our community rules");
	//RegConsoleCmd("sm_changes", z4labChangelog, "shows our community rules");
	//RegConsoleCmd("sm_giveaway", z4labGiveaway, "shows our community rules");
	//RegConsoleCmd("sm_howtosurf", z4labHowtosurf, "shows our community rules");

	// z4lab community links
	//RegConsoleCmd("sm_discord", z4labDiscord, "shows our community rules");
	//RegConsoleCmd("sm_teamspeak", z4labTeamspeak, "shows our community rules");
	//RegConsoleCmd("sm_ts", z4labTeamspeak, "shows our community rules");
	//RegConsoleCmd("sm_steamgroup", z4labSteamgroup, "shows our community rules");
	//RegConsoleCmd("sm_steam", z4labSteamgroup, "shows our community rules");
	
	// skin changer commands
	RegConsoleCmd("sm_skins", z4labSkins, "prints default message for skins");
	RegConsoleCmd("sm_ws", z4labSkins, "prints default message for skins");
	RegConsoleCmd("sm_gloves", z4labSkins, "prints default message for skins");
	RegConsoleCmd("sm_glove", z4labSkins, "prints default message for skins");
}

// chat replay (commands)
public Action z4labSkins(int client, int args)
{
	PrintHintText(client, "<font color='#bf616a'>NO</font>");
}

public Action z4labRules(int client, int args)
{
	CPrintToChat(client, "%t", "Command1", g_hChatPrefix);
	CPrintToChat(client, "%t", "Command2", g_hChatPrefix);
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

	CPrintToChat(client, "[{lightgreen}z4lab{default}] {gold}#{bluegrey} Welcome {purple}%N {bluegrey}enjoy your stay!", client);
	CPrintToChat(client, "[{lightgreen}z4lab{default}] {gold}#{bluegrey} You can find our rules with {gold}!rules {bluegrey}or on {lightgreen}z4lab.com/rules", client);
	CPrintToChat(client, "[{lightgreen}z4lab{default}] {gold}#{bluegrey} Be nice - {red}toxicity/racism {bluegrey}will not be tolerated!", client);
	CPrintToChat(client, "[{lightgreen}z4lab{default}] {gold}#{bluegrey} Useful commands: [{gold}!z4lab {bluegrey}| {gold}!servers {bluegrey}| {gold}!discord{bluegrey}]", client);
	g_bMessagesShown[client] = true;
	
	return Plugin_Continue;
}

public void OnClientDisconnect(int client)
{
	g_bMessagesShown[client] = false;
}