/*
================================================================================

	                            INFORMACIJE

	Skripta: PCRP by TazGee
	Mape: by TazGee
	Svrha: YouTube Tutorijali
	Sistemi: Dinamicni


	                            UPDATE INFO

	v1.1
	- Soon

	POSLOVI ID: 1 - Bus Vozac
				2 - Kosac Trave
				3 - ...

================================================================================
*/

#define SNOW_MODE           0


//============================== INCLUDES ======================================
#include <a_samp>
#include <zcmd>
#include <sscanf2>
#include <streamer>
#include <foreach>
#include <YSI\y_ini>
//=============================== LOGOVI =======================================
#define WARNING 			1
#define AC 					2
#define KICK 				3
#define BAN 				4
#define LOGIN 				5
#define REGISTER 			6
//=============================== DILOGS =======================================
#define DIALOG_REGISTER 	1
#define DIALOG_LOGIN 		2
#define DIALOG_STATS   		3

#define DIALOG_ORGIME       4
#define DIALOG_ORGDRZAVNA   5
#define DIALOG_ORGRANK1     6
#define DIALOG_ORGRANK2     7
#define DIALOG_ORGRANK3     8
#define DIALOG_ORGRANK4     9
#define DIALOG_ORGRANK5     10
#define DIALOG_ORGRANK6     11
#define DIALOG_ORGRANK7     12
#define DIALOG_ORGINFO      13
#define DIALOG_ORGLIST      14
#define DIALOG_ORGLEADERS   15

#define DIALOG_PORT         16

#define DIALOG_ALIST        17

#define DIALOG_GATEPERM     18
#define DIALOG_GATEORGID    19
#define DIALOG_GATEINFO     20

#define DIALOG_PROMLIST     21

#define DIALOG_KUPIVOZILO	22

#define DIALOG_NAPRAVIFIRMU 23
#define DIALOG_CENAFIRME	24
#define DIALOG_LEVELFIRME	25

#define DIALOG_RADIO 		26

#define DIALOG_HOUSE		27
#define DIALOG_HOUSEINFO	28
#define DIALOG_HOUSEPRODAJ	29
#define DIALOG_HOUSERENT	30
#define DIALOG_HOUSERENTC	31

#define DIALOG_GPS			32
//================================= MAX ========================================
#define MAX_HOUSES 			2000
#define MAX_ORGS            15
#define MAX_PORTS           100
#define MAX_ADMINS          20
#define MAX_PROMOTERS       20
#define MAX_GATES           500
#define MAX_VOZILA 			2500
#define MAX_FIRME			200
#define MAX_GPS 			100

#define SKIDANJEID          MAX_PLAYERS
//================================ PATHS =======================================
#define PATH 				"/korisnici/%s.ini"
#define HOUSEPATH 			"/kuce/%d.ini"
#define ORGPATH 			"/organizacije/%d.ini"
#define PORTPATH            "/ports/%d.ini"
#define ADMINPATH           "/admins/%d.ini"
#define GATEPATH            "/gates/%d.ini"
#define PROMPATH            "/promoteri/%d.ini"
#define VEHPATH 			"/vozila/%d.ini"
#define FIRMAPATH 			"/firme/%d.ini"
#define GPSPATH 			"/gps/%d.ini"
//============================== SKRACENO ======================================
#define SCM                 SendClientMessage
#define SCMTA               SendClientMessageToAll
#define SPD                 ShowPlayerDialog
#define TDSFP               TextDrawShowForPlayer
#define SetPos				SetPlayerPos
#define SetAngle			SetPlayerFacingAngle
#define SCBP				SetCameraBehindPlayer
#define C3D					Create3DTextLabel
#define CP                  CreatePickup
#define UzmiIme             GetPlayerName
#define GTFP				GameTextForPlayer
#define UVozilu             IsPlayerInAnyVehicle
#define UzmiVID				GetPlayerVehicleID
#define UzmiModel			GetVehicleModel
#define DajNovac			AC_AC_GivePlayerMoney
#define Povezan				IsPlayerConnected
#define SCP                 SetCameraPos
#define SCLA                SetCameraLookAt
//===============================  BOJE   ======================================
#define COLOR_GREY 			0xAFAFAFAA
#define COLOR_GREEN 		0x33AA33AA
#define COLOR_RED 			0xAA3333AA
#define COLOR_YELLOW 		0xFFFF00AA
#define COLOR_WHITE 		0xFFFFFFAA
#define COLOR_BLUE			0x0000BBAA
#define COLOR_LIGHTBLUE 	0x33CCFFAA
#define COLOR_ORANGE 		0xFF9900AA
#define COLOR_RED 			0xAA3333AA
#define COLOR_LIME 			0x10F441AA
#define COLOR_MAGENTA 		0xFF00FFFF
#define COLOR_NAVY 			0x000080AA
#define COLOR_AQUA 			0xF0F8FFAA
#define COLOR_CRIMSON 		0xDC143CAA
#define COLOR_FLBLUE 		0x6495EDAA
#define COLOR_BISQUE 		0xFFE4C4AA
#define COLOR_BLACK 		0x000000AA
#define COLOR_CHARTREUSE 	0x7FFF00AA
#define COLOR_BROWN 		0XA52A2AAA
#define COLOR_CORAL 		0xFF7F50AA
#define COLOR_GOLD 			0xB8860BAA
#define COLOR_GREENYELLOW 	0xADFF2FAA
#define COLOR_INDIGO 		0x4B00B0AA
#define COLOR_IVORY 		0xFFFF82AA
#define COLOR_LAWNGREEN 	0x7CFC00AA
#define COLOR_LIMEGREEN 	0x32CD32AA 
#define COLOR_MIDNIGHTBLUE 	0X191970AA
#define COLOR_MAROON 		0x800000AA
#define COLOR_OLIVE 		0x808000AA
#define COLOR_ORANGERED 	0xFF4500AA
#define COLOR_PINK 			0xFFC0CBAA 
#define COLOR_SEAGREEN 		0x2E8B57AA
#define COLOR_SPRINGGREEN 	0x00FF7FAA
#define COLOR_TOMATO 		0xFF6347AA 
#define COLOR_YELLOWGREEN 	0x9ACD32AA 
#define COLOR_MEDIUMAQUA 	0x83BFBFAA
#define COLOR_MEDIUMMAGENTA 0x8B008BAA 
//=============================== PLATE ========================================
#define BUSPLATA 			7500
#define BUSPLATAPREMIUM		12500
#define PILOTPLATA 			12500
#define KOSACPLATA    		500
#define KAMOINDZIJAPLATA 	9500
//============================== DOZVOLE =======================================
#define DRIVERLICNECE       30000
#define MOTORLICNECE       	12500
#define FLYINGLICNECE       75000
#define TRUCKLICNECE        25000
#define WEAPONLICNECE       15000
//==============================================================================
new pID[MAX_PLAYERS];
//=========================== NAGRADNI SISTEM ==================================
new nagradnaPoruka[64];
new igraTraje;
//==============================================================================
new TutorijalProgres[MAX_PLAYERS];
//==============================================================================
new pEditujeVozilo[MAX_PLAYERS];
new probnovozilo[MAX_PLAYERS];
new Text3D:textvozila[MAX_VOZILA];
//==============================================================================
new PosaoUniforma[MAX_PLAYERS];

new Indicators[MAX_VEHICLES][6];

new ulogovan[MAX_PLAYERS];

//ANTICHEAT
new lastMoney[MAX_PLAYERS], pMoneyTokens[MAX_PLAYERS];


new NasumicniKarakter [][] =
{
	"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o",
	"p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D",
	"E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S",
	"T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7",
	"8", "9"
};

enum gpsInfo
{
	gpsIme[128],
	Float:gpsX,
	Float:gpsY,
	Float:gpsZ
};
new GPSInfo[MAX_GPS][gpsInfo];
new brojgps;

enum vehInfo
{
	vID,
	vOwnable,
	vOwner[128],
	vCena,
	vNeaktivnost,
	vRegistracija,
	vPosaoID,
	vOrgID,
	vRent,
	vAdmin,
	vVip,
	vPromoter,
	vBoja,
	vBoja2,
	vGorivo,
	Float:vX,
	Float:vY,
	Float:vZ,
	Float:vRot,
	vDozvola
};
new VoziloInfo[MAX_VOZILA][vehInfo];

enum promInfo
{
	promName[128],
	promNeaktivnost
};
new PromoterInfo[MAX_PROMOTERS][promInfo];


enum gInfo
{
	gObjID,
	Float:gX,
	Float:gY,
	Float:gZ,
	Float:gRX,
	Float:gRY,
	Float:gRZ,
	Float:gOX,
	Float:gOY,
	Float:gOZ,
	gOrgID,
	gPerm
};
new GateInfo[MAX_GATES][gInfo];
new gate[MAX_GATES];
new gateObj[MAX_GATES];
new gatefaza[MAX_PLAYERS];
new editagate[MAX_PLAYERS];
new editagateid[MAX_PLAYERS];
new editing[MAX_PLAYERS];


enum aInfo
{
	aName[128],
	aNeaktivnost,
	aDuty
};
new AdminInfo[MAX_ADMINS][aInfo];
new pADuty[MAX_PLAYERS];

enum orgInfo
{
	orgIme[128],
	orgLeader[128],
	orgMember1[128],
	orgMember2[128],
	orgMember3[128],
	orgMember4[128],
	orgMember5[128],
	orgMember6[128],
	orgMember7[128],
	orgMember8[128],
	orgMember9[128],
	orgMember10[128],
	orgMember11[128],
	orgMember12[128],
	orgMember13[128],
	orgMember14[128],
	orgMember15[128],
	orgMember16[128],
	orgMember17[128],
	orgMember18[128],
	orgMember19[128],
	orgMember20[128],
	orgSefMoney,
	orgSefMats,
	orgSefDrugs,
	orgDrzavna,
	orgRank1[128],
	orgRank2[128],
	orgRank3[128],
	orgRank4[128],
	orgRank5[128],
	orgRank6[128],
	orgRank7[128],
	Float:orgX,
	Float:orgY,
	Float:orgZ
};
new OrgInfo[MAX_ORGS][orgInfo];
new brojorg;


new NasumicnePoruke[][] =
{
	"Ako vam je potrebna pomoc ukucajte /help!",
	"Ako ne znate broj neke drzavne organizacije, ukucajte /call 222!",
	"Ovaj tutorijal ce vam se prikazivati sve dok vas level ne postane veci od 5!",
	"Listu organizacija mozete videti na /organizacije!",
	"Listu lidera mozete videti na /lideri!",
	"Ako ne mozete da se snadjete, koristite /gps!",
	"Ako zelite da pozovete admina, ukucajte /pomoc ili /askq!",
	"Ako zelite da se zaposlite, to mozete uraditi u opstini!"
};

enum portInfo
{
	portIme[128],
	Float:portX,
	Float:portY,
	Float:portZ
};
new PortInfo[MAX_PORTS][portInfo];
new brojportova;

enum hInfo
{
	hOwner[128],
	hOwned,
	hCena,
	hLevel,
	hNeaktivnost,
	hTip,
	Float:hX,
	Float:hY,
	Float:hZ,
	hSefNovac,
	hSefDroga,
	hZakljucana
};
new HouseInfo[MAX_HOUSES][hInfo];

enum fiInfo
{
	fiOwner[128],
	fiOwned,
	fiCena,
	fiLevel,
	fiNeaktivnost,
	fiTip,
	Float:fiX,
	Float:fiY,
	Float:fiZ,
	fiKasa,
	fiZalihe,
	fiZakljucana
};
new FirmaInfo[MAX_FIRME][fiInfo];

enum pInfo
{
        pPremium,
	pLozinka,
	pNovac,
	pLevel,
	pDoPlate,
	pRespekti,
	pAdmin,
	pPasos,
	pNeededRep,
	pPosao,
	pLeader,
	pRacun,
	pBanka,
	pRate,
	pKredit,
	pKuca,
	pBan,
	pBanRazlog[128],
	pPromoter,
	pNagradniPoeni,
	pTutorijal,
	pSkin,
	pVozilo1,
	pVozilo2,
	pVozilo3,
	pVozilo4,
	pVozilo5
};
new PlayerInfo[MAX_PLAYERS+1][pInfo];

enum vInfo
{
	vEngine,
	vLights,
	vAlarm,
	vDoor,
	vBonnet,
	vBoot,
	vObj,
	vFuel
};
new VehInfo[MAX_VEHICLES][vInfo];

stock SetVehicleIndicator(vehicleid, levi=0, desni=0)
{
	if(!levi & !desni) return false;
	new Float:_vX[2], Float:_vY[2], Float:_vZ[2];
	if(desni)
	{
		if(IsTrailerAttachedToVehicle(vehicleid))
		{
			new omg = GetVehicleModel(GetVehicleTrailer(vehicleid));
			GetVehicleModelInfo(omg, VEHICLE_MODEL_INFO_SIZE, _vX[0], _vY[0], _vZ[0]);
			Indicators[vehicleid][4] = CreateObject(19294, 0, 0, 0, 0, 0, 0);
			AttachObjectToVehicle(Indicators[vehicleid][4], GetVehicleTrailer(vehicleid), _vX[0]/2.4, _vY[0]/3.35, -1, 0, 0, 0);
		}
		GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, _vX[0], _vY[0], _vZ[0]);
		Indicators[vehicleid][0] = CreateObject(19294, 0, 0, 0, 0, 0, 0);
		AttachObjectToVehicle(Indicators[vehicleid][0], vehicleid, _vX[0]/2.23, _vY[0]/2.23, 0.1, 0, 0, 0);
		Indicators[vehicleid][1] = CreateObject(19294, 0, 0, 0, 0, 0, 0);
		AttachObjectToVehicle(Indicators[vehicleid][1], vehicleid, _vX[0]/2.23, -_vY[0]/2.23, 0.1, 0, 0, 0);
	}
	if(levi)
	{
		if(IsTrailerAttachedToVehicle(vehicleid))
		{
			new omg = GetVehicleModel(GetVehicleTrailer(vehicleid));
			GetVehicleModelInfo(omg, VEHICLE_MODEL_INFO_SIZE, _vX[0], _vY[0], _vZ[0]);
			Indicators[vehicleid][5] = CreateObject(19294, 0, 0, 0, 0, 0, 0);
			AttachObjectToVehicle(Indicators[vehicleid][5], GetVehicleTrailer(vehicleid), _vX[0]/2.4, _vY[0]/3.35, -1, 0, 0, 0);
		}
		GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, _vX[0], _vY[0], _vZ[0]);
		Indicators[vehicleid][2] = CreateObject(19294, 0, 0, 0, 0, 0, 0);
		AttachObjectToVehicle(Indicators[vehicleid][2], vehicleid, -_vX[0]/2.23, _vY[0]/2.23, 0.1, 0, 0, 0);
		Indicators[vehicleid][3] = CreateObject(19294, 0, 0, 0, 0, 0, 0);
		AttachObjectToVehicle(Indicators[vehicleid][3], vehicleid, -_vX[0]/2.23, -_vY[0]/2.23, 0.1, 0, 0, 0);
	}
	return 1;
}

stock StaviLabel(i, vozilo)
{
	new str[128];
	format(str, 128, "");
	if(VoziloInfo[i][vOwnable] == 1 && !strcmp(VoziloInfo[i][vOwner], str))
	{
		new txt[128];
		format(txt, 128, "{DAA520}[{FFFFFF} VOZILO NA PRODAJU {DAA520}]\nCena: {FFFFFF}$%d", VoziloInfo[i][vCena]);
		textvozila[i] = Create3DTextLabel(txt, COLOR_BLACK, 0.0, 0.0, 0.0, 15.0, 0, 1);
		Attach3DTextLabelToVehicle(textvozila[i], vozilo, 0.0, 0.0, 0.0);
	}
	if(VoziloInfo[i][vRent] == 1)
	{
		textvozila[i] = Create3DTextLabel("{DAA520}[ {FFFFFF}RENT {DAA520}]", COLOR_BLACK, 0.0, 0.0, 0.0, 15.0, 0, 1);
		Attach3DTextLabelToVehicle(textvozila[i], vozilo, 0.0, 0.0, 0.0);
	}
	if(VoziloInfo[i][vAdmin] == 1)
	{
		textvozila[i] = Create3DTextLabel("{DAA520}[ {FFFFFF}ADMIN {DAA520}]", COLOR_BLACK, 0.0, 0.0, 0.0, 15.0, 0, 1);
		Attach3DTextLabelToVehicle(textvozila[i], vozilo, 0.0, 0.0, 0.0);
	}
	if(VoziloInfo[i][vVip] == 1)
	{
		textvozila[i] = Create3DTextLabel("{DAA520}[ {FFFFFF}VIP {DAA520}]", COLOR_BLACK, 0.0, 0.0, 0.0, 15.0, 0, 1);
		Attach3DTextLabelToVehicle(textvozila[i], vozilo, 0.0, 0.0, 0.0);
	}
	if(VoziloInfo[i][vPromoter] == 1)
	{
		textvozila[i] = Create3DTextLabel("{DAA520}[ {FFFFFF}PROMOTER {DAA520}]", COLOR_BLACK, 0.0, 0.0, 0.0, 15.0, 0, 1);
		Attach3DTextLabelToVehicle(textvozila[i], vozilo, 0.0, 0.0, 0.0);
	}
}

stock SavePromoter(id)
{
	new p_file[64];
	format(p_file, sizeof(p_file), PROMPATH, id);
	new INI:File = INI_Open(p_file);
	INI_WriteString(File, "Name", PromoterInfo[id][promName]);
	INI_WriteInt(File, "Neaktivnost", PromoterInfo[id][promNeaktivnost]);
	INI_Close(File);
}
stock UzetPromSlot(id)
{
	new str[128];
	format(str, 128, "Niko");
	if(!strcmp(PromoterInfo[id][promName], str)) return false;
	return true;
}

stock ClearChat(id)
{
	for(new i = 0; i < 30; i++)
	{
	    SCM(id, -1, "");
 	}
}

stock UpdateBubble(id)
{
	new str[128];
	if(PlayerInfo[id][pLevel] <= 3) format(str, sizeof(str), "{8B8989}[ NOVAJLIJA ]");
	if(PlayerInfo[id][pLevel] > 3) format(str, sizeof(str), "{FFFFFF}[ GRADJANIN ]");
	if(PlayerInfo[id][pAdmin] == 1) format(str, sizeof(str), "{000000}[ ADMIN 1 ]");
	if(PlayerInfo[id][pAdmin] == 2) format(str, sizeof(str), "{000000}[ ADMIN 2 ]");
	if(PlayerInfo[id][pAdmin] == 3) format(str, sizeof(str), "{000000}[ ADMIN 3 ]");
	if(PlayerInfo[id][pAdmin] == 4) format(str, sizeof(str), "{000000}[ HEAD ADMIN ]");
	if(PlayerInfo[id][pAdmin] == 5) format(str, sizeof(str), "{000000}[ DIREKTOR ]");
	if(PlayerInfo[id][pAdmin] == 6) format(str, sizeof(str), "{000000}[ VLASNIK ]");
	if(PlayerInfo[id][pAdmin] == 1337) format(str, sizeof(str), "{000000}[ SKRIPTER ]");
	if(pADuty[id] == 1) SetPlayerColor(id, 0x000000FF);
	else SetPlayerColor(id, 0xFFFFFFFF);
	SetPlayerChatBubble(id, str, -1, 30.0, 1001);
}

stock UzetSlot(id)
{
	new str[128];
	format(str, sizeof(str), "Niko");
	if(!strcmp(AdminInfo[id][aName], str)) return false;
	return true;
}
stock SaveAdmin(id)
{
	new a_file[64];
	format(a_file, sizeof(a_file), ADMINPATH, id);
	new INI:File = INI_Open(a_file);
	INI_WriteString(File, "Name", AdminInfo[id][aName]);
	INI_WriteInt(File, "Neaktivnost", AdminInfo[id][aNeaktivnost]);
	INI_WriteInt(File, "Duty", AdminInfo[id][aDuty]);
	INI_Close(File);
}
stock GetPlayerID(name[])
{
	new ime[128];
	for(new i = 0; i <= MAX_PLAYERS; i++)
	{
	    GetPlayerName(i, ime, sizeof(ime));
	    if(!strcmp(name, ime)) return i;
	}
	return -1;
}
stock Sacuvaj(playerid, ime[128])
{
	new upath[128];
	format(upath, sizeof(upath), PATH, ime);
	new INI:File = INI_Open(upath);
	INI_SetTag(File, "data");
	INI_WriteInt(File, "Premium", PlayerInfo[playerid][pPremium]);
	INI_WriteInt(File, "Lozinka", PlayerInfo[playerid][pLozinka]);
 	INI_WriteInt(File, "Novac", GetPlayerMoney(playerid));
 	INI_WriteInt(File, "Level", PlayerInfo[playerid][pLevel]);
 	INI_WriteInt(File, "DoPlate", PlayerInfo[playerid][pDoPlate]);
 	INI_WriteInt(File, "Respekti", PlayerInfo[playerid][pRespekti]);
 	INI_WriteInt(File, "Admin", PlayerInfo[playerid][pAdmin]);
 	INI_WriteInt(File, "Pasos", PlayerInfo[playerid][pPasos]);
 	INI_WriteInt(File, "NeededRep", PlayerInfo[playerid][pNeededRep]);
 	INI_WriteInt(File, "Posao", PlayerInfo[playerid][pPosao]);
 	INI_WriteInt(File, "Leader", PlayerInfo[playerid][pLeader]);
 	INI_WriteInt(File, "Racun", PlayerInfo[playerid][pRacun]);
 	INI_WriteInt(File, "Banka", PlayerInfo[playerid][pBanka]);
 	INI_WriteInt(File, "Rate", PlayerInfo[playerid][pRate]);
 	INI_WriteInt(File, "Kredit", PlayerInfo[playerid][pKredit]);
 	INI_WriteInt(File, "Kuca", PlayerInfo[playerid][pKuca]);
 	INI_WriteInt(File, "Ban", PlayerInfo[playerid][pBan]);
 	INI_WriteString(File, "BanRazlog", PlayerInfo[playerid][pBanRazlog]);
 	INI_WriteInt(File, "Promoter", PlayerInfo[playerid][pPromoter]);
 	INI_WriteInt(File, "NagradniPoeni", PlayerInfo[playerid][pNagradniPoeni]);
 	INI_WriteInt(File, "Tutorijal", PlayerInfo[playerid][pTutorijal]);
 	INI_WriteInt(File, "Skin", PlayerInfo[playerid][pSkin]);
 	INI_WriteInt(File, "Vozilo1", PlayerInfo[playerid][pVozilo1]);
 	INI_WriteInt(File, "Vozilo2", PlayerInfo[playerid][pVozilo2]);
 	INI_WriteInt(File, "Vozilo3", PlayerInfo[playerid][pVozilo3]);
 	INI_WriteInt(File, "Vozilo4", PlayerInfo[playerid][pVozilo4]);
 	INI_WriteInt(File, "Vozilo5", PlayerInfo[playerid][pVozilo5]);
 	INI_Close(File);
}

stock SnijegObjekti(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	new
	object = CreateDynamicObject(modelid, x + 0.05, y + 0.075, z + 0.1, rx, ry, rz, -1, -1, -1, 300.0, 0.0);
	for(new a = 0; a < 30; a++)
		SetDynamicObjectMaterial(object, a, 17944, "lngblok_lae2", "white64bumpy", 0);
	return object;
}
/*
	tip 1 = house
	tip 2 = org
	tip 3 = port
	tip 4 = gate
*/
stock NewID(tip)
{
	new id = -1, len;
	if(tip == 1)
	{
	    len = MAX_HOUSES;
	    for(new loop = (0), check = (-1), Data_[64] = "\0"; loop != len; ++ loop)
		{
		    check = (loop+1);
		    format(Data_, sizeof(Data_), HOUSEPATH, check);
		    if(!fexist(Data_))
		    {
		        id = (check);
		        break;
		    }
		}
	}
	if(tip == 2)
	{
	    len = MAX_ORGS;
	    for(new loop = (0), check = (-1), Data_[64] = "\0"; loop != len; ++ loop)
		{
		    check = (loop+1);
		    format(Data_, sizeof(Data_), ORGPATH, check);
		    if(!fexist(Data_))
		    {
		        id = (check);
		        break;
		    }
		}
	}
	if(tip == 3)
	{
	    len = MAX_PORTS;
	    for(new loop = (0), check = (-1), Data_[64] = "\0"; loop != len; ++ loop)
		{
		    check = (loop+1);
		    format(Data_, sizeof(Data_), PORTPATH, check);
		    if(!fexist(Data_))
		    {
		        id = (check);
		        break;
		    }
		}
	}
	if(tip == 4)
	{
	    len = MAX_GATES;
	    for(new loop = (0), check = (-1), Data_[64] = "\0"; loop != len; ++ loop)
		{
		    check = (loop+1);
		    format(Data_, sizeof(Data_), GATEPATH, check);
		    if(!fexist(Data_))
		    {
		        id = (check);
		        break;
		    }
		}
	}
	if(tip == 5)
	{
	    len = MAX_VOZILA;
	    for(new loop = (0), check = (-1), Data_[64] = "\0"; loop != len; ++ loop)
		{
		    check = (loop+1);
		    format(Data_, sizeof(Data_), VEHPATH, check);
		    if(!fexist(Data_))
		    {
		        id = (check);
		        break;
		    }
		}
	}
	if(tip == 6)
	{
	    len = MAX_FIRME;
	    for(new loop = (0), check = (-1), Data_[64] = "\0"; loop != len; ++ loop)
		{
		    check = (loop+1);
		    format(Data_, sizeof(Data_), FIRMAPATH, check);
		    if(!fexist(Data_))
		    {
		        id = (check);
		        break;
		    }
		}
	}
	if(tip == 7)
	{
		len = MAX_GPS;
	    for(new loop = (0), check = (-1), Data_[64] = "\0"; loop != len; ++ loop)
		{
		    check = (loop+1);
		    format(Data_, sizeof(Data_), GPSPATH, check);
		    if(!fexist(Data_))
		    {
		        id = (check);
		        break;
		    }
		}
	}
	return id;
}

stock SaveVozilo(id)
{
	new v_file[64];
	format(v_file, 64, VEHPATH, id);
	new INI:File = INI_Open(v_file);
	INI_WriteInt(File, "ID", VoziloInfo[id][vID]);
	INI_WriteInt(File, "Ownable", VoziloInfo[id][vOwnable]);
	INI_WriteString(File, "Owner", VoziloInfo[id][vOwner]);
	INI_WriteInt(File, "Cena", VoziloInfo[id][vCena]);
	INI_WriteInt(File, "Neaktivnost", VoziloInfo[id][vNeaktivnost]);
	INI_WriteInt(File, "Registracija", VoziloInfo[id][vRegistracija]);
	INI_WriteInt(File, "PosaoID", VoziloInfo[id][vPosaoID]);
	INI_WriteInt(File, "OrgID", VoziloInfo[id][vOrgID]);
	INI_WriteInt(File, "Rent", VoziloInfo[id][vAdmin]);
	INI_WriteInt(File, "Vip", VoziloInfo[id][vVip]);
	INI_WriteInt(File, "Promoter", VoziloInfo[id][vPromoter]);
	INI_WriteInt(File, "Boja", VoziloInfo[id][vBoja]);
	INI_WriteInt(File, "Boja2", VoziloInfo[id][vBoja2]);
	INI_WriteFloat(File, "X", VoziloInfo[id][vX]);
	INI_WriteFloat(File, "Y", VoziloInfo[id][vY]);
	INI_WriteFloat(File, "Z", VoziloInfo[id][vZ]);
	INI_WriteFloat(File, "Rot", VoziloInfo[id][vRot]);
	INI_WriteInt(File, "Dozvola", VoziloInfo[id][vDozvola]);
	INI_Close(File);
}

stock SaveGate(id)
{
	new g_file[64];
	format(g_file, sizeof(g_file), GATEPATH, id);
	new INI:File = INI_Open(g_file);
	INI_WriteInt(File, "ObjID", GateInfo[id][gObjID]);
	INI_WriteFloat(File, "X", GateInfo[id][gX]);
	INI_WriteFloat(File, "Y", GateInfo[id][gY]);
	INI_WriteFloat(File, "Z", GateInfo[id][gZ]);
	INI_WriteFloat(File, "RX", GateInfo[id][gRX]);
	INI_WriteFloat(File, "RY", GateInfo[id][gRY]);
	INI_WriteFloat(File, "RZ", GateInfo[id][gRZ]);
	INI_WriteFloat(File, "OX", GateInfo[id][gOX]);
	INI_WriteFloat(File, "OY", GateInfo[id][gOY]);
	INI_WriteFloat(File, "OZ", GateInfo[id][gOZ]);
	INI_WriteInt(File, "OrgID", GateInfo[id][gOrgID]);
	INI_WriteInt(File, "Perm", GateInfo[id][gPerm]);
	INI_Close(File);
}


stock SavePort(id)
{
	new port_file[64];
	format(port_file, sizeof(port_file), PORTPATH, id);
	new INI:File = INI_Open(port_file);
	INI_WriteString(File, "Ime", PortInfo[id][portIme]);
	INI_WriteFloat(File, "X", PortInfo[id][portX]);
	INI_WriteFloat(File, "Y", PortInfo[id][portY]);
	INI_WriteFloat(File, "Z", PortInfo[id][portZ]);
	INI_Close(File);
}

stock SaveGPS(id)
{
	new gps_file[64];
	format(gps_file, sizeof(gps_file), GPSPATH, id);
	new INI:File = INI_Open(gps_file);
	INI_WriteString(File, "Ime", GPSInfo[id][gpsIme]);
	INI_WriteFloat(File, "X", GPSInfo[id][gpsX]);
	INI_WriteFloat(File, "Y", GPSInfo[id][gpsY]);
	INI_WriteFloat(File, "Z", GPSInfo[id][gpsZ]);
	INI_Close(File);
}

stock SaveOrg(id)
{
	new org_file[64];
	format(org_file, sizeof(org_file), ORGPATH, id);
	new INI:File = INI_Open(org_file);
	INI_WriteString(File, "Ime", OrgInfo[id][orgIme]);
	INI_WriteString(File, "Leader", OrgInfo[id][orgLeader]);
	INI_WriteString(File, "Member1", OrgInfo[id][orgMember1]);
	INI_WriteString(File, "Member2", OrgInfo[id][orgMember2]);
	INI_WriteString(File, "Member3", OrgInfo[id][orgMember3]);
	INI_WriteString(File, "Member4", OrgInfo[id][orgMember4]);
	INI_WriteString(File, "Member5", OrgInfo[id][orgMember5]);
	INI_WriteString(File, "Member6", OrgInfo[id][orgMember6]);
	INI_WriteString(File, "Member7", OrgInfo[id][orgMember7]);
	INI_WriteString(File, "Member8", OrgInfo[id][orgMember8]);
	INI_WriteString(File, "Member9", OrgInfo[id][orgMember9]);
	INI_WriteString(File, "Member10", OrgInfo[id][orgMember10]);
	INI_WriteString(File, "Member11", OrgInfo[id][orgMember11]);
	INI_WriteString(File, "Member12", OrgInfo[id][orgMember12]);
	INI_WriteString(File, "Member13", OrgInfo[id][orgMember13]);
	INI_WriteString(File, "Member14", OrgInfo[id][orgMember14]);
	INI_WriteString(File, "Member15", OrgInfo[id][orgMember15]);
	INI_WriteString(File, "Member16", OrgInfo[id][orgMember16]);
	INI_WriteString(File, "Member17", OrgInfo[id][orgMember17]);
	INI_WriteString(File, "Member18", OrgInfo[id][orgMember18]);
	INI_WriteString(File, "Member19", OrgInfo[id][orgMember19]);
	INI_WriteString(File, "Member20", OrgInfo[id][orgMember20]);
	INI_WriteInt(File, "SefMoney", OrgInfo[id][orgSefMoney]);
	INI_WriteInt(File, "SefMats", OrgInfo[id][orgSefMats]);
	INI_WriteInt(File, "SefDroga", OrgInfo[id][orgSefDrugs]);
	INI_WriteInt(File, "Drzavna", OrgInfo[id][orgDrzavna]);
	INI_WriteString(File, "Rank1", OrgInfo[id][orgRank1]);
	INI_WriteString(File, "Rank2", OrgInfo[id][orgRank2]);
	INI_WriteString(File, "Rank3", OrgInfo[id][orgRank3]);
	INI_WriteString(File, "Rank4", OrgInfo[id][orgRank4]);
	INI_WriteString(File, "Rank5", OrgInfo[id][orgRank5]);
	INI_WriteString(File, "Rank6", OrgInfo[id][orgRank6]);
	INI_WriteString(File, "Rank7", OrgInfo[id][orgRank7]);
	INI_WriteFloat(File, "X", OrgInfo[id][orgX]);
	INI_WriteFloat(File, "Y", OrgInfo[id][orgY]);
	INI_WriteFloat(File, "Z", OrgInfo[id][orgZ]);
	INI_Close(File);
}

stock UserPath(playerid)
{
	new string[128],playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid,playername,sizeof(playername));
	format(string,sizeof(string),PATH,playername);
	return string;
}

stock SavePlayer(playerid)
{
    new INI:File = INI_Open(UserPath(playerid));
	INI_SetTag(File, "data");
	INI_WriteInt(File, "Premium", PlayerInfo[playerid][pPremium]);
	INI_WriteInt(File, "Lozinka", PlayerInfo[playerid][pLozinka]);
 	INI_WriteInt(File, "Novac", GetPlayerMoney(playerid));
 	INI_WriteInt(File, "Level", PlayerInfo[playerid][pLevel]);
 	INI_WriteInt(File, "DoPlate", PlayerInfo[playerid][pDoPlate]);
 	INI_WriteInt(File, "Respekti", PlayerInfo[playerid][pRespekti]);
 	INI_WriteInt(File, "Admin", PlayerInfo[playerid][pAdmin]);
 	INI_WriteInt(File, "Pasos", PlayerInfo[playerid][pPasos]);
 	INI_WriteInt(File, "NeededRep", PlayerInfo[playerid][pNeededRep]);
 	INI_WriteInt(File, "Posao", PlayerInfo[playerid][pPosao]);
 	INI_WriteInt(File, "Leader", PlayerInfo[playerid][pLeader]);
 	INI_WriteInt(File, "Racun", PlayerInfo[playerid][pRacun]);
 	INI_WriteInt(File, "Banka", PlayerInfo[playerid][pBanka]);
 	INI_WriteInt(File, "Rate", PlayerInfo[playerid][pRate]);
 	INI_WriteInt(File, "Kredit", PlayerInfo[playerid][pKredit]);
 	INI_WriteInt(File, "Kuca", PlayerInfo[playerid][pKuca]);
 	INI_WriteInt(File, "Ban", PlayerInfo[playerid][pBan]);
 	INI_WriteString(File, "BanRazlog", PlayerInfo[playerid][pBanRazlog]);
 	INI_WriteInt(File, "Promoter", PlayerInfo[playerid][pPromoter]);
 	INI_WriteInt(File, "NagradniPoeni", PlayerInfo[playerid][pNagradniPoeni]);
 	INI_WriteInt(File, "Tutorijal", PlayerInfo[playerid][pTutorijal]);
 	INI_WriteInt(File, "Skin", PlayerInfo[playerid][pSkin]);
 	INI_WriteInt(File, "Vozilo1", PlayerInfo[playerid][pVozilo1]);
 	INI_WriteInt(File, "Vozilo2", PlayerInfo[playerid][pVozilo2]);
 	INI_WriteInt(File, "Vozilo3", PlayerInfo[playerid][pVozilo3]);
 	INI_WriteInt(File, "Vozilo4", PlayerInfo[playerid][pVozilo4]);
 	INI_WriteInt(File, "Vozilo5", PlayerInfo[playerid][pVozilo5]);
 	INI_Close(File);
}
stock SaveHouse(id)
{
	new h_file[64];
	format(h_file, sizeof(h_file), HOUSEPATH, id);
	new INI:File = INI_Open(h_file);
	INI_WriteString(File, "Owner", HouseInfo[id][hOwner]);
	INI_WriteInt(File, "Owned", HouseInfo[id][hOwned]);
	INI_WriteInt(File, "Cena", HouseInfo[id][hCena]);
	INI_WriteInt(File, "Level", HouseInfo[id][hLevel]);
	INI_WriteInt(File, "Neaktivnost", HouseInfo[id][hNeaktivnost]);
	INI_WriteInt(File, "Tip", HouseInfo[id][hTip]);
	INI_WriteFloat(File, "X", HouseInfo[id][hX]);
	INI_WriteFloat(File, "Y", HouseInfo[id][hY]);
	INI_WriteFloat(File, "Z", HouseInfo[id][hZ]);
	INI_WriteInt(File, "SefNovac", HouseInfo[id][hSefNovac]);
	INI_WriteInt(File, "SefDroga", HouseInfo[id][hSefDroga]);
	INI_WriteInt(File, "Zakljucana", HouseInfo[id][hZakljucana]);
	INI_Close(File);
}

stock SaveFirma(id)
{
	new f_file[64];
	format(f_file, sizeof(f_file), FIRMAPATH, id);
	new INI:File = INI_Open(f_file);
	INI_WriteString(File, "Owner", FirmaInfo[id][fiOwner]);
	INI_WriteInt(File, "Owned", FirmaInfo[id][fiOwned]);
	INI_WriteInt(File, "Cena", FirmaInfo[id][fiCena]);
	INI_WriteInt(File, "Level", FirmaInfo[id][fiLevel]);
	INI_WriteInt(File, "Neaktivnost", FirmaInfo[id][fiNeaktivnost]);
	INI_WriteInt(File, "Tip", FirmaInfo[id][fiTip]);
	INI_WriteFloat(File, "X", FirmaInfo[id][fiX]);
	INI_WriteFloat(File, "Y", FirmaInfo[id][fiY]);
	INI_WriteFloat(File, "Z", FirmaInfo[id][fiZ]);
	INI_WriteInt(File, "Kasa", FirmaInfo[id][fiKasa]);
	INI_WriteInt(File, "Zalihe", FirmaInfo[id][fiZalihe]);
	INI_WriteInt(File, "Zakljucana", FirmaInfo[id][fiZakljucana]);
	INI_Close(File);
}

stock udb_hash(buf[])
{
	new length=strlen(buf);
	new s1 = 1;
	new s2 = 0;
	new n;
	for (n=0; n<length; n++)
	{
		s1 = (s1 + buf[n]) % 65521;
		s2 = (s2 + s1)     % 65521;
	}
	return (s2 << 16) + s1;
}

new ImenaVozila[212][] = {
{"Landstalker"},{"Bravura"},{"Buffalo"},{"Linerunner"},{"Perrenial"},{"Sentinel"},{"Dumper"},{"Firetruck"},{"Trashmaster"},{"Stretch"},{"Manana"},{"Infernus"},{"Voodoo"},
{"Pony"},{"Mule"},{"Cheetah"},{"Ambulance"},{"Leviathan"},{"Moonbeam"},{"Esperanto"},{"Taxi"},{"Washington"},{"Bobcat"},{"Mr Whoopee"},{"BF Injection"},{"Hunter"},{"Premier"},
{"Enforcer"},{"Securicar"},{"Banshee"},{"Predator"},{"Bus"},{"Rhino"},{"Barracks"},{"Hotknife"},{"Trailer 1"},{"Previon"},{"Coach"},{"Cabbie"},{"Stallion"},{"Rumpo"},{"RC Bandit"},
{"Romero"},{"Packer"},{"Monster"},{"Admiral"},{"Squalo"},{"Seasparrow"},{"Pizzaboy"},{"Tram"},{"Trailer 2"},{"Turismo"},{"Speeder"},{"Reefer"},{"Tropic"},{"Flatbed"},{"Yankee"},{"Caddy"},{"Solair"},
{"Berkley's RC Van"},{"Skimmer"},{"PCJ-600"},{"Faggio"},{"Freeway"},{"RC Baron"},{"RC Raider"},{"Glendale"},{"Oceanic"},{"Sanchez"},{"Sparrow"},{"Patriot"},{"Quad"},{"Coastguard"},{"Dinghy"},
{"Hermes"},{"Sabre"},{"Rustler"},{"ZR-350"},{"Walton"},{"Regina"},{"Comet"},{"BMX"},{"Burrito"},{"Camper"},{"Marquis"},{"Baggage"},{"Dozer"},{"Maverick"},{"News Chopper"},{"Rancher"},{"FBI Rancher"},
{"Virgo"},{"Greenwood"},{"Jetmax"},{"Hotring"},{"Sandking"},{"Blista Compact"},{"Police Maverick"},{"Boxville"},{"Benson"},{"Mesa"},{"RC Goblin"},{"Hotring Racer A"},{"Hotring Racer B"},{"Bloodring Banger"},
{"Rancher"},{"Super GT"},{"Elegant"},{"Journey"},{"Bike"},{"Mountain Bike"},{"Beagle"},{"Cropdust"},{"Stunt"},{"Tanker"},{"Roadtrain"},{"Nebula"},{"Majestic"},{"Buccaneer"},{"Shamal"},{"Hydra"},{"FCR-900"},
{"NRG-500"},{"HPV1000"},{"Cement Truck"},{"Tow Truck"},{"Fortune"},{"Cadrona"},{"FBI Truck"},{"Willard"},{"Forklift"},{"Tractor"},{"Combine"},{"Feltzer"},{"Remington"},{"Slamvan"},{"Blade"},{"Freight"},
{"Streak"},{"Vortex"},{"Vincent"},{"Bullet"},{"Clover"},{"Sadler"},{"Firetruck LA"},{"Hustler"},{"Intruder"},{"Primo"},{"Cargobob"},{"Tampa"},{"Sunrise"},{"Merit"},{"Utility"},{"Nevada"},{"Yosemite"},
{"Windsor"},{"Monster A"},{"Monster B"},{"Uranus"},{"Jester"},{"Sultan"},{"Stratum"},{"Elegy"},{"Raindance"},{"RC Tiger"},{"Flash"},{"Tahoma"},{"Savanna"},{"Bandito"},{"Freight Flat"},{"Streak Carriage"},
{"Kart"},{"Mower"},{"Duneride"},{"Sweeper"},{"Broadway"},{"Tornado"},{"AT-400"},{"DFT-30"},{"Huntley"},{"Stafford"},{"BF-400"},{"Newsvan"},{"Tug"},{"Trailer 3"},{"Emperor"},{"Wayfarer"},{"Euros"},{"Hotdog"},
{"Club"},{"Freight Carriage"},{"Trailer 3"},{"Andromada"},{"Dodo"},{"RC Cam"},{"Launch"},{"Police Car (LSPD)"},{"Police Car (SFPD)"},{"Police Car (LVPD)"},{"Police Ranger"},{"Picador"},{"S.W.A.T. Van"},
{"Alpha"},{"Phoenix"},{"Glendale"},{"Sadler"},{"Luggage Trailer A"},{"Luggage Trailer B"},{"Stair Trailer"},{"Boxville"},{"Farm Plow"},{"Utility Trailer"}
};
	new PlayerText:Speedometer0[MAX_PLAYERS];
	new PlayerText:Speedometer1[MAX_PLAYERS];
	new PlayerText:Speedometer2[MAX_PLAYERS];
	new PlayerText:Speedometer3[MAX_PLAYERS];
	new PlayerText:Speedometer4[MAX_PLAYERS];
	new PlayerText:Speedometer5[MAX_PLAYERS];
	new PlayerText:Speedometer6[MAX_PLAYERS];
	new PlayerText:Speedometer7[MAX_PLAYERS];
	new PlayerText:Speedometer8[MAX_PLAYERS];




new editaorg[MAX_PLAYERS];

new logintimer[MAX_PLAYERS];

new radi[MAX_PLAYERS];
new jobprogress[MAX_PLAYERS];


new adminveh[2];
new vipveh[38];
new Text3D:vipvehtext[38];

new rentGate;
new rent[10];
new Text3D:renttext[10];
new renta[MAX_PLAYERS];
new rented[MAX_VEHICLES];
new rentvreme[MAX_PLAYERS];

new sneg[MAX_PLAYERS] = 0;
new snegobj[MAX_PLAYERS];

new hPickup[MAX_HOUSES];
new Text3D:hLabel[MAX_HOUSES];

new fiPickup[MAX_FIRME];
new Text3D:fiLabel[MAX_FIRME];

new orgPickup[MAX_ORGS];
new Text3D:orgLabel[MAX_ORGS];

new excludedveh[MAX_VEHICLES];


//============================= GATES ==========================================
new vipgate;


//============================== TD ============================================

new Text:IGTD0;
new Text:IGTD1;
new Text:IGTD2;
new Text:IGTD3;
new Text:IGTD4;
new Text:IGTD5;
new Text:IGTD6;
new Text:IGTD7;
new Text:IGTD8;
new Text:IGTD9;
new Text:IGTD10;
new Text:IGTD11;
new Text:IGTD12;
new Text:IGTD13;
new Text:IGTD14;
	
//==============================================================================





#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" PerfectCrime by TazGee");
	print("----------------------------------\n");
}

#endif

public OnGameModeInit()
{
	SetGameModeText("[PCRP] by TazGee");
	AddPlayerClass(0, 1765.3517,-1894.7328,13.5621, 270.0000, 0, 0, 0, 0, 0, 0);
	DisableInteriorEnterExits();
	UsePlayerPedAnims();
	EnableStuntBonusForAll(0);
	brojorg = 0;

	for(new i = 0; i < MAX_VEHICLES; i++)
	{
	    excludedveh[i] = 0;
	}

//============================== TIMERS ========================================

	SetTimer("Fuel", 60000, true);

//============================================================================== 

	for(new i = 0; i < MAX_GPS; i++)
	{
	    new gpsfile[64];
	    format(gpsfile, sizeof(gpsfile), GPSPATH, i);
	    if(fexist(gpsfile))
	    {
	        INI_ParseFile(gpsfile, "LoadGPS", .bExtra = true, .extra = i);
	        brojgps++;
	    }
	}
//VEH SISTEM
	for(new i = 0; i < MAX_VOZILA; i++)
	{
	    new vfile[64];
	    format(vfile, 64, VEHPATH, i);
	    if(fexist(vfile))
	    {
	        INI_ParseFile(vfile, "LoadVozila", .bExtra = true, .extra = i);
	        new vozilo = AddStaticVehicle(VoziloInfo[i][vID], VoziloInfo[i][vX], VoziloInfo[i][vY], VoziloInfo[i][vZ], VoziloInfo[i][vRot], VoziloInfo[i][vBoja], VoziloInfo[i][vBoja2]);
	        StaviLabel(i, vozilo);
	    }
	}
	print("Ucitan veh sistem");
//PROMOTER SISTEM
	for(new i = 0; i < MAX_PROMOTERS; i++)
	{
	    new pfile[64];
	    format(pfile, 64, PROMPATH, i);
	    if(!fexist(pfile))
	    {
	        new str[128];
	        format(str, 128, "Niko");
	        PromoterInfo[i][promName] = str;
	        PromoterInfo[i][promNeaktivnost] = 0;
	        SavePromoter(i);
	        INI_ParseFile(pfile, "LoadPromoters", .bExtra = true, .extra = i);
	    }
	    else
	    {
	        INI_ParseFile(pfile, "LoadPromoters", .bExtra = true, .extra = i);
	    }
	}
	print("Ucitan promoter sistem");
//GATES
	vipgate = CreateDynamicObject(980, 1108.47034, -1741.14038, 15.23720,   0.00000, -1.00000, 90.00000);
	Create3DTextLabel("{B8860B}[ {FFFFFF}Pritisnite {B8860B}H {FFFFFF}da otvorite gate {B8860B}]\n{B8860B}[ {FFFFFF}Lokacija: Vip Baza{B8860B}]", COLOR_ORANGE, 1108.47034, -1741.14038, 14.23720, 25.0, 0, 0);


	for(new i = 0; i < MAX_ADMINS; i++)
	{
	    new afile[64];
	    format(afile, sizeof(afile), ADMINPATH, i);
		if(!fexist(afile))
		{
		    new str[128];
		    format(str, sizeof(str), "Niko");
		    AdminInfo[i][aName] = str;
		    AdminInfo[i][aNeaktivnost] = 0;
		    AdminInfo[i][aDuty] = 0;
		    SaveAdmin(i);
		    INI_ParseFile(afile, "LoadAdmins", .bExtra = true, .extra = i);
		}
		else
		{
		    INI_ParseFile(afile, "LoadAdmins", .bExtra = true, .extra = i);
		}
	}
	print("Ucitan admin sistem");
//GATE SISTEM
	for(new i = 0; i < MAX_GATES; i++)
	{
	    new gfile[64];
	    format(gfile, sizeof(gfile), GATEPATH, i);
	    if(fexist(gfile))
	    {
	        INI_ParseFile(gfile, "LoadGates", .bExtra = true, .extra = i);
	        gate[i] = CreateDynamicObject(GateInfo[i][gObjID], GateInfo[i][gX], GateInfo[i][gY], GateInfo[i][gZ], GateInfo[i][gRX], GateInfo[i][gRY], GateInfo[i][gRZ]);
	    }
	}
	print("Ucitan gate sistem");
//HOUSE SISTEM
	for(new i = 0; i < MAX_HOUSES; i++)
	{
	    new hfile[64];
	    format(hfile, sizeof(hfile), HOUSEPATH, i);
	    if(fexist(hfile))
	    {
	        INI_ParseFile(hfile, "LoadHouses", .bExtra = true, .extra = i);
	        new str[32];
	        if(HouseInfo[i][hTip] == 1) { format(str, sizeof(str), "Stan"); }
			if(HouseInfo[i][hTip] == 2) { format(str, sizeof(str), "Mala Kuca"); }
			if(HouseInfo[i][hTip] == 3) { format(str, sizeof(str), "Srednja Kuca"); }
			if(HouseInfo[i][hTip] == 4) { format(str, sizeof(str), "Velika Kuca"); }
			if(HouseInfo[i][hTip] == 5) { format(str, sizeof(str), "Vila"); }
			if(HouseInfo[i][hOwned] == 0)
			{
			    new string[512];
			    format(string, sizeof(string), "{4682B4}Kuca na prodaju\nOwner: {FFFFFF}Niko\n{4682B4}Cena: {FFFFFF}%d\n{4682B4}Level: {FFFFFF}%d\n{4682B4}Tip: {FFFFFF}%s\n{4682B4}Adresa: {FFFFFF}%d\n{4682B4}/kupikucu", HouseInfo[i][hCena], HouseInfo[i][hLevel], str, i);
			    hPickup[i] = CreatePickup(1273, 1, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ]);
			    hLabel[i] = Create3DTextLabel(string, COLOR_WHITE, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ], 10.0, 0, 0);
			}
			else
			{
			    new string[512];
			    format(string, sizeof(string), "{4682B4}Kuca na prodaju\nOwner: {FFFFFF}%s\n{4682B4}Cena: {FFFFFF}%d\n{4682B4}Level: {FFFFFF}%d\n{4682B4}Tip: {FFFFFF}%s\n{4682B4}Adresa: {FFFFFF}%d", HouseInfo[i][hOwner], HouseInfo[i][hCena], HouseInfo[i][hLevel], str, i);
			    hPickup[i] = CreatePickup(1272, 1, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ]);
			    hLabel[i] = Create3DTextLabel(string, COLOR_WHITE, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ], 10.0, 0, 0);
			}
	    }
	}
	for(new i = 0; i < MAX_FIRME; i++)
	{
	    new ffile[64];
	    format(ffile, sizeof(ffile), FIRMAPATH, i);
	    if(fexist(ffile))
	    {
	        INI_ParseFile(ffile, "LoadFirme", .bExtra = true, .extra = i);
	        new str[32];

	        if(FirmaInfo[i][fiTip] == 0) { format(str, sizeof(str), "Mali Restoran"); }
	        else if(FirmaInfo[i][fiTip] == 1) { format(str, sizeof(str), "Veliki Restoran"); }
			else if(FirmaInfo[i][fiTip] == 2) { format(str, sizeof(str), "Prodavnica"); }
			else if(FirmaInfo[i][fiTip] == 3) { format(str, sizeof(str), "Gun Shop"); }
			else { format(str, sizeof(str), "Nepoznato"); }
			if(FirmaInfo[i][fiOwned] == 0)
			{
			    new string[512];
			    format(string, sizeof(string), "{4682B4}Firma na prodaju\nOwner: {FFFFFF}Niko\n{4682B4}Cena: {FFFFFF}$%d\n{4682B4}Level: {FFFFFF}%d\n{4682B4}Tip: {FFFFFF}%s\n{4682B4}Adresa: {FFFFFF}%d\n{4682B4}/kupifirmu", FirmaInfo[i][fiCena], FirmaInfo[i][fiLevel], str, i);
			    fiPickup[i] = CreatePickup(1274, 1, FirmaInfo[i][fiX], FirmaInfo[i][fiY], FirmaInfo[i][fiZ]);
			    fiLabel[i] = Create3DTextLabel(string, COLOR_WHITE, FirmaInfo[i][fiX], FirmaInfo[i][fiY], FirmaInfo[i][fiZ], 10.0, 0, 0);
			}
			else
			{
			    new string[512];
			    format(string, sizeof(string), "{4682B4}Firma\nOwner: {FFFFFF}%s\n{4682B4}Cena: {FFFFFF}$%d\n{4682B4}Level: {FFFFFF}%d\n{4682B4}Tip: {FFFFFF}%s\n{4682B4}Adresa: {FFFFFF}%d", FirmaInfo[i][fiOwner], FirmaInfo[i][fiCena], FirmaInfo[i][fiLevel], str, i);
			    fiPickup[i] = CreatePickup(1274, 1, FirmaInfo[i][fiX], FirmaInfo[i][fiY], FirmaInfo[i][fiZ]);
			    fiLabel[i] = Create3DTextLabel(string, COLOR_WHITE, FirmaInfo[i][fiX], FirmaInfo[i][fiY], FirmaInfo[i][fiZ], 10.0, 0, 0);
			}
	    }
	}
	print("Ucitan house i firma sistem");

//ORG SISTEM
	for(new i = 0; i < MAX_ORGS; i++)
	{
	    new orgfile[64];
	    format(orgfile, sizeof(orgfile), ORGPATH, i);
     	if(fexist(orgfile))
     	{
     		INI_ParseFile(orgfile, "LoadOrgs", .bExtra = true, .extra = i);
        	new string[128];
        	format(string, sizeof(string), "{DAA520}[ {FFFFFF}%s {DAA520}]\n{FFFFFF}Leader: {DAA520}%s", OrgInfo[i][orgIme], OrgInfo[i][orgLeader]);
        	orgLabel[i] = Create3DTextLabel(string, COLOR_BLACK, OrgInfo[i][orgX], OrgInfo[i][orgY], OrgInfo[i][orgZ], 20.0, 0, 0);
        	orgPickup[i] = CreatePickup(19132, 1, OrgInfo[i][orgX], OrgInfo[i][orgY], OrgInfo[i][orgZ]);
        	brojorg++;
     	}
	}
	print("Ucitan org sistem");
//PORT SISTEM
	for(new i = 0; i < MAX_PORTS; i++)
	{
	    new portfile[64];
	    format(portfile, sizeof(portfile), PORTPATH, i);
	    if(fexist(portfile))
	    {
	        INI_ParseFile(portfile, "LoadPorts", .bExtra = true, .extra = i);
	        brojportova++;
	    }
	}
	print("Ucitan port sistem");
//==============================================================================
	rent[0] = AddStaticVehicle(405,1248.2274,-2010.4163,59.7497,180.6989,3,3);
	rent[1] = AddStaticVehicle(405,1244.8611,-2010.3964,59.6136,180.0861,3,3);
	rent[2] = AddStaticVehicle(405,1240.2274,-2010.4163,59.7497,180.6989,3,3);
	rent[3] = AddStaticVehicle(405,1236.8611,-2010.3964,59.6136,180.0861,3,3);
	rent[4] = AddStaticVehicle(405,1232.2274,-2010.4163,59.7497,180.6989,3,3);
	rent[5] = AddStaticVehicle(405,1228.8611,-2010.3964,59.6136,180.0861,3,3);
	rent[6] = AddStaticVehicle(405,1224.2274,-2010.4163,59.7497,180.6989,3,3);
	rent[7] = AddStaticVehicle(405,1220.8611,-2010.3964,59.6136,180.0861,3,3);
	rent[8] = AddStaticVehicle(405,1216.2274,-2010.4163,59.7497,180.6989,3,3);
	rent[9] = AddStaticVehicle(405,1212.8611,-2010.3964,59.6136,180.0861,3,3);
	for(new i = 0; i < 10; i++)
	{
	    rented[rent[i]] = 0;
	    renttext[i] = Create3DTextLabel("[ RENT ]", COLOR_BLACK, 0.0, 0.0, 0.0, 15.0, 0, 1);
	    Attach3DTextLabelToVehicle(renttext[i], rent[i], 0.0, 0.0, 0.0);
	}
	print("Ucitana rent vozila");
//==============================  ADMIN VOZILA  ================================

	adminveh[0] = AddStaticVehicle(411,1244.7427,-2042.3899,59.3886,359.5034,64,1); 			// adminvozilo1
	adminveh[1] = AddStaticVehicle(411,1248.2914,-2042.4238,59.2852,358.2997,123,1); 			// adminvozilo2
    print("Ucitana admin vozila");
//==============================  VIP VOZILA  ==================================

    vipveh[0] = AddStaticVehicle(411, 1077.6318, -1775.6132, 12.8263, 90.0000, 16, 16);
	vipveh[1] = AddStaticVehicle(411, 1077.6318, -1772.6331, 12.8263, 90.0000, 16, 16);
	vipveh[2] = AddStaticVehicle(411, 1077.6318, -1769.7296, 12.8263, 90.0000, 16, 16);
	vipveh[3] = AddStaticVehicle(411, 1077.6318, -1766.7239, 12.8263, 90.0000, 16, 16);
	vipveh[4] = AddStaticVehicle(411, 1077.6318, -1763.7979, 12.8263, 90.0000, 16, 16);
	vipveh[5] = AddStaticVehicle(411, 1077.6318, -1760.8560, 12.8263, 90.0000, 16, 16);
	vipveh[6] = AddStaticVehicle(411, 1077.6318, -1757.8866, 12.8263, 90.0000, 16, 16);
	vipveh[7] = AddStaticVehicle(411, 1077.6318, -1754.9606, 12.8263, 90.0000, 16, 16);
	vipveh[8] = AddStaticVehicle(495, 1084.3378, -1775.5923, 13.4178, -90.0000, 16, 16);
	vipveh[9] = AddStaticVehicle(495, 1084.3685, -1772.5752, 13.4178, -90.0000, 16, 16);
	vipveh[10] = AddStaticVehicle(495, 1084.3446, -1769.6390, 13.4178, -90.0000, 16, 16);
	vipveh[11] = AddStaticVehicle(495, 1084.3322, -1766.7231, 13.4178, -90.0000, 16, 16);
	vipveh[12] = AddStaticVehicle(495, 1084.3254, -1763.8258, 13.4178, -90.0000, 16, 16);
	vipveh[13] = AddStaticVehicle(495, 1084.3234, -1760.8752, 13.4178, -90.0000, 16, 16);
	vipveh[14] = AddStaticVehicle(495, 1084.2903, -1757.9619, 13.4178, -90.0000, 16, 16);
	vipveh[15] = AddStaticVehicle(495, 1084.3035, -1754.9561, 13.4178, -90.0000, 16, 16);
	vipveh[16] = AddStaticVehicle(522, 1062.8092, -1775.6136, 12.8110, -90.0000, 16, 16);
	vipveh[17] = AddStaticVehicle(522, 1062.7207, -1772.5812, 12.8110, -90.0000, 16, 16);
	vipveh[18] = AddStaticVehicle(522, 1062.7257, -1769.6898, 12.8110, -90.0000, 16, 16);
	vipveh[19] = AddStaticVehicle(522, 1062.5771, -1766.7239, 12.8110, -90.0000, 16, 16);
	vipveh[20] = AddStaticVehicle(522, 1062.4797, -1763.8033, 12.8110, -90.0000, 16, 16);
	vipveh[21] = AddStaticVehicle(522, 1062.5143, -1760.8744, 12.8110, -90.0000, 16, 16);
	vipveh[22] = AddStaticVehicle(522, 1062.4961, -1757.9104, 12.8110, -90.0000, 16, 16);
	vipveh[23] = AddStaticVehicle(522, 1062.4081, -1754.8765, 12.8110, -90.0000, 16, 16);
	vipveh[24] = AddStaticVehicle(522, 1062.3534, -1752.0546, 12.8110, -90.0000, 16, 16);
	vipveh[25] = AddStaticVehicle(522, 1062.2457, -1749.1171, 12.8110, -90.0000, 16, 16);
	vipveh[26] = AddStaticVehicle(522, 1062.3159, -1746.2239, 12.8110, -90.0000, 16, 16);
	vipveh[27] = AddStaticVehicle(522, 1062.3804, -1743.1449, 12.8110, -90.0000, 16, 16);
	vipveh[28] = AddStaticVehicle(522, 1062.6147, -1740.3313, 12.8110, -90.0000, 16, 16);
	vipveh[29] = AddStaticVehicle(522, 1062.5714, -1737.3058, 12.8110, -90.0000, 16, 16);
	vipveh[30] = AddStaticVehicle(560, 1098.8130, -1775.6464, 12.8993, 90.0000, 16, 16);
	vipveh[31] = AddStaticVehicle(560, 1098.7478, -1772.6261, 12.8993, 90.0000, 16, 16);
	vipveh[32] = AddStaticVehicle(560, 1098.7704, -1769.7352, 12.8993, 90.0000, 16, 16);
	vipveh[33] = AddStaticVehicle(560, 1098.7581, -1766.7856, 12.8993, 90.0000, 16, 16);
	vipveh[34] = AddStaticVehicle(560, 1098.7094, -1763.7927, 12.8993, 90.0000, 16, 16);
	vipveh[35] = AddStaticVehicle(560, 1098.7578, -1760.8446, 12.8993, 90.0000, 16, 16);
	vipveh[36] = AddStaticVehicle(560, 1098.8612, -1757.9807, 12.8993, 90.0000, 16, 16);
	vipveh[37] = AddStaticVehicle(560, 1098.8724, -1755.0452, 12.8993, 90.0000, 16, 16);
	for(new i = 0; i < 38; i++)
	{
	    vipvehtext[i] = Create3DTextLabel("[ VIP ]", COLOR_BLACK, 0.0, 0.0, 0.0, 15.0, 0, 1);
	    Attach3DTextLabelToVehicle(vipvehtext[i], vipveh[i], 0.0, 0.0, 0.0);
	}
	print("Ucitana vip vozila");
//===============================  PICKUPI  ====================================
	
	CreatePickup(19132, 1, 1481.1208,-1771.8009,18.7958, 0);
	CreatePickup(19132, 1, 384.808624,173.804992,1008.382812, 0);
	CreatePickup(19132, 1, 1466.1982,-1004.7651,16.2557, 0);
	CreatePickup(19132, 1, 1467.2875,-1010.2311,26.8438, 0);
	
	CreatePickup(1239, 1, 362.1759,173.6288,1008.3828, 0);
	Create3DTextLabel("/kupipasos", -1, 362.1759,173.6288,1008.3828, 5.0, 0, 0);
	
	CreatePickup(1239, 1, 358.7209,178.6033,1008.3828, 0);
	Create3DTextLabel("/otkaz", -1, 358.7209,178.6033,1008.3828, 5.0, 0, 0);
	
	CreatePickup(1239, 1, 1752.7542,-1894.1619,13.5573, 0);
	Create3DTextLabel("/zaposlise\n/otkaz", -1, 1752.7542,-1894.1619,13.5573, 5.0, 0, 0);
	
	CreatePickup(1239, 1, 1456.4519,-972.4586,19.1609, 0);
	Create3DTextLabel("/napraviracun", -1, 1456.4519,-972.4586,19.1609, 5.0, 0, 0);
	CreatePickup(1239, 1, 1458.5801,-972.6403,19.1646, 0);
	Create3DTextLabel("/kredit\n/transfer", -1,1458.5801,-972.6403,19.1646, 5.0, 0, 0);
	CreatePickup(1239, 1, 1460.8018,-972.6647,19.1685, 0);
	Create3DTextLabel("/deposit", -1, 1460.8018,-972.6647,19.1685, 5.0, 0, 0);
	CreatePickup(1239, 1, 1463.0957,-972.5809,19.1725, 0);
	Create3DTextLabel("/withdraw", -1, 1463.0957,-972.5809,19.1725, 5.0, 0, 0);
	print("Ucitani pickupi");
//==============================================================================
	
	SetTimer("PosaljiPoruku", 60000, true);
	SetTimer("PayDay", 60000, true);
	SetTimer("RespawnVozila", 1800000, true);
	SetTimer("RentTimer", 60000, true);
	SetTimer("NagradnaPoruka", 180000, true);
	SetTimer("AntiCheatTimer", 1000, true);
    NagradnaPoruka();
	print("Ucitani timeri");
////////////////////////////////////////////////////////////////////////////////
//=================================== MAPE =====================================
////////////////////////////////////////////////////////////////////////////////
//===================================BUS STANICE================================
//==================================== RENT ====================================
	
	rentGate = CreateDynamicObject(980, 1263.84814, -2048.43701, 60.92853,   0.00000, 2.00000, 0.00000);
//================================ SPAWN SIGN ==================================
	new spawnsign;
	spawnsign = CreateDynamicObject(19454, 1122.287475, -2037.164062, 75.565994, 0.000000, 0.000000, 0.000000);
	SetDynamicObjectMaterial(spawnsign, 0, -1, "none", "none", 0xFF000000);
	spawnsign = CreateDynamicObject(4731, 1122.461669, -2037.078735, 75.652603, 0.000000, 0.000000, 120.300003);
	SetDynamicObjectMaterialText(spawnsign, 0, "SPAWN", 120, "Ariel", 60, 1, 0xFFFFFFFF, 0x00000000, 1);
	print("Ucitani spawn objekti");

	#if SNOW_MODE == 1
	SnijegObjekti(5145, 2716.79687, -2447.87500, 2.15625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5146, 2498.19531, -2408.00781, 1.80468, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5147, 2533.76562, -2330.82812, 22.19531, 0.00000, 0.00000, 315.00000);
	SnijegObjekti(3753, 2702.39843, -2324.25781, 3.03906, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5333, 2374.38281, -2171.46875, 21.17968, 0.00000, 0.00000, 135.00000);
	SnijegObjekti(5191, 2381.44531, -2397.43750, 6.67187, 0.00000, 0.00000, 45.00000);
	SnijegObjekti(5176, 2521.53906, -2606.95312, 17.64843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(3753, 2615.10937, -2464.61718, 3.03906, 0.00000, 0.00000, 180.00000);
	SnijegObjekti(3753, 2748.01562, -2571.59375, 3.03906, 0.00000, 0.00000, 180.00000);
	SnijegObjekti(5115, 2523.40625, -2217.46093, 12.07031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(3753, 2511.47656, -2256.03125, 3.03906, 0.00000, 0.00000, 180.00000);
	SnijegObjekti(5108, 2333.55468, -2308.71093, 3.27343, 0.00000, 0.00000, 45.00000);
	SnijegObjekti(5353, 2543.75000, -2163.78906, 14.20312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5250, 2743.43750, -2120.64062, 15.42187, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5184, 2699.03125, -2227.74218, 31.42968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5125, 2397.82031, -2183.05468, 15.33593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5124, 2278.89843, -2286.31250, 15.33593, 0.00000, 0.00000, 45.00000);
	SnijegObjekti(3753, 2299.18750, -2405.39843, 3.03906, 0.00000, 0.00000, 225.00000);
	SnijegObjekti(3753, 2368.16406, -2523.86718, 3.03906, 0.00000, 0.00000, 90.00000);
	SnijegObjekti(3753, 2454.82812, -2702.91406, 3.03906, 0.00000, 0.00000, 180.00000);
	SnijegObjekti(5109, 2219.33593, -2558.80468, 4.98437, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4841, 2123.78906, -2576.32812, 15.33593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5003, 2018.43750, -2585.50000, 18.78125, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4864, 1996.06250, -2677.55468, 14.13281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4822, 2179.89843, -2407.41406, 15.33593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5004, 2030.14062, -2417.69531, 12.31250, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4867, 1780.80468, -2604.14062, 12.54687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4842, 1383.79687, -2707.74218, 3.27343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4863, 1533.08593, -2677.43750, 11.29687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4865, 1515.40625, -2602.50781, 12.54687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4843, 1274.56250, -2551.86718, 3.27343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4839, 1383.60937, -2633.05468, 15.33593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4883, 1339.23437, -2456.69531, 15.08593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4866, 1517.15625, -2449.64843, 12.55468, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4816, 1210.71093, -2467.78906, 1.07031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4840, 1233.50000, -2438.00000, 8.14062, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4845, 1222.82812, -2291.23437, 7.07031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4835, 1466.76562, -2286.43750, 16.58593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4838, 1411.57812, -2265.07031, 12.50781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4834, 1315.84375, -2286.33593, 13.43750, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4833, 1528.74218, -2252.64062, 12.68750, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4871, 1569.93750, -2378.24218, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4831, 1756.08593, -2286.50000, 16.39843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4830, 1687.78125, -2286.53906, 10.25000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4869, 1893.39062, -2269.60156, 14.60937, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5002, 1780.35937, -2437.60156, 12.55468, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5009, 2065.13281, -2269.60156, 15.32031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4868, 2139.60937, -2292.42187, 15.32031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5123, 2195.08593, -2266.61718, 12.56250, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5276, 2219.60156, -2200.49218, 12.50781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4827, 2056.88281, -2187.35156, 6.27343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5314, 2085.17968, -2132.70312, 12.41406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5271, 2275.40625, -2095.26562, 12.50781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5274, 2317.71875, -2210.57812, 8.80468, 0.00000, 0.00000, 315.00000);
	SnijegObjekti(5277, 2235.91406, -2282.46093, 13.18750, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5275, 2293.80468, -2172.77343, 11.71093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5106, 2390.24218, -2013.87500, 16.04687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5112, 2521.09375, -2049.24218, 18.73437, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5297, 2393.06250, -2049.24218, 18.09375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5330, 2303.75000, -1982.78125, 12.42968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5311, 2287.34375, -2024.38281, 12.53906, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5174, 2371.25781, -2024.32031, 16.58593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5149, 2479.82812, -2009.00000, 15.18750, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5105, 2543.46093, -2142.28125, 10.19531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5120, 2243.64843, -2021.01562, 12.41406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5270, 2112.30468, -2001.79687, 9.76562, 0.00000, 0.00000, 45.00000);
	SnijegObjekti(5273, 2153.40625, -2051.42968, 12.54687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5272, 2213.17187, -2033.06250, 12.64843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5343, 2136.50781, -1992.89062, 12.79687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5347, 2130.63281, -1987.89843, 13.14843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5122, 2184.43750, -1932.95312, 14.38281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5119, 2176.06250, -1911.87500, 12.64843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5329, 2216.18750, -1912.33593, 13.00000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5111, 2271.35937, -1912.38281, 14.50781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5513, 2200.72656, -1811.33593, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17595, 2217.48437, -1810.83593, 12.36718, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5141, 2271.19531, -1928.39062, 12.49218, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5349, 2143.67187, -1894.47656, 12.50000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5118, 2107.77343, -1958.81250, 12.64843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5182, 2115.00000, -1921.52343, 15.39062, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5117, 2031.25000, -1962.31250, 13.28906, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5121, 2041.65625, -1904.81250, 12.39843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5116, 2361.27343, -1918.74218, 16.44531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5168, 2385.18750, -1906.51562, 18.44531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5178, 2479.85156, -1930.21093, 12.41406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5187, 2439.28125, -1979.96093, 15.75000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5142, 2489.23437, -1962.01562, 19.03906, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5355, 2582.42968, -1979.37500, 9.14843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5296, 2652.92968, -2049.24218, 18.12500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5143, 2639.40625, -2102.39843, 36.69531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5113, 2758.53906, -2104.89843, 18.28125, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5188, 2718.44531, -1977.50000, 11.21875, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5133, 2845.64843, -1969.99218, 9.13281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5173, 2768.44531, -2012.09375, 14.79687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5144, 2768.56250, -1942.69531, 11.30468, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17582, 2739.21875, -1770.08593, 17.55468, 0.00000, 0.00000, 175.00000);
	SnijegObjekti(17927, 2771.17187, -1901.49218, 11.21093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17602, 2678.68750, -1849.80468, 9.90625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17606, 2848.87500, -1799.57031, 10.32031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17675, 2893.58593, -1586.53125, 10.22656, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17605, 2798.70312, -1657.29687, 10.98437, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17607, 2854.89843, -1525.40625, 9.89843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17541, 2803.39843, -1573.80468, 20.29687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17604, 2690.29687, -1657.30468, 10.89843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17609, 2730.14062, -1572.89843, 20.63281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17682, 2674.94531, -1622.54687, 14.17968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17680, 2642.69531, -1540.80468, 19.59375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17538, 2682.80468, -1507.41406, 44.14062, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17603, 2642.79687, -1733.10156, 9.69531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17600, 2585.25781, -1732.34375, 11.13281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17601, 2674.18750, -1860.69531, 11.21093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5151, 2674.10156, -1990.78906, 15.18750, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17500, 2478.60156, -1851.48437, 6.47656, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5128, 2516.59375, -1875.55468, 11.67968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5110, 2443.63281, -1901.32031, 18.00781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5267, 2485.76562, -1900.43750, 18.53125, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17599, 2522.19531, -1773.00000, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17548, 2482.32812, -1783.14843, 14.44531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17596, 2413.75000, -1820.83593, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17598, 2469.38281, -1732.21093, 12.57812, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17613, 2489.29687, -1668.50000, 12.29687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17617, 2502.32031, -1649.58593, 15.19531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17616, 2521.68750, -1692.85937, 14.86718, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17574, 2459.80468, -1714.88281, 12.08593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17612, 2408.09375, -1658.90625, 12.39843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17881, 2429.78906, -1681.84375, 12.64062, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17615, 2459.59375, -1695.60156, 13.59375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17654, 2556.35156, -1612.91406, 15.90625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17655, 2433.07031, -1611.55468, 12.03125, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17829, 2413.68750, -1576.64062, 16.20312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17657, 2431.03906, -1603.49218, 20.20312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17656, 2431.05468, -1677.42968, 20.31250, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17597, 2314.95312, -1741.32812, 12.48437, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17614, 2387.80468, -1695.64843, 13.74218, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17621, 2342.59375, -1682.70312, 12.09375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17620, 2281.21093, -1695.64843, 13.44531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17611, 2284.66406, -1656.71093, 13.42968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17619, 2303.41406, -1622.42187, 9.05468, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17622, 2342.60937, -1608.81250, 16.91406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17867, 2308.45312, -1599.38281, 4.63281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17866, 2339.78906, -1583.99218, 14.96093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17638, 2431.69531, -1514.35156, 22.90625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17624, 2386.78906, -1524.35937, 22.91406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17862, 2458.38281, -1532.43750, 22.99218, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17623, 2342.50000, -1534.00000, 22.89843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17639, 2490.90625, -1504.32812, 22.92187, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17921, 2560.86718, -1474.34375, 22.91406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17687, 2577.24218, -1447.23437, 30.77343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17640, 2461.39062, -1445.78125, 25.82031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17852, 2490.90625, -1474.34375, 27.34375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17920, 2295.01562, -1564.46875, 12.32031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5511, 2193.25000, -1543.54687, 9.70312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5478, 2269.08593, -1487.55468, 20.73437, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5479, 2234.16406, -1590.25781, 16.66406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17513, 2288.89843, -1525.50000, 17.89843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17610, 2224.03906, -1680.64062, 13.40625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5480, 2208.37500, -1698.24218, 13.39062, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5510, 2192.79687, -1665.03906, 13.73437, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5440, 2207.67968, -1588.39062, 19.34375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5509, 2150.39062, -1741.82812, 12.44531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5419, 2078.15625, -1847.70312, 7.76562, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5183, 2111.65625, -1873.36718, 16.39843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5180, 2163.67187, -1873.61718, 15.82031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5508, 2085.85937, -1812.77343, 13.17968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5528, 2101.29687, -1688.77343, 18.08593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5506, 2079.83593, -1699.94531, 12.46093, 0.00000, 0.00000, 275.57501);
	SnijegObjekti(5411, 2021.65625, -1810.72656, 18.60156, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5139, 2021.15625, -1893.27343, 15.17968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5404, 1952.71875, -1856.78125, 7.08593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4895, 1899.15625, -1936.33593, 14.26562, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5052, 1961.65625, -1863.11718, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5013, 1961.66406, -2001.89843, 12.54687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5186, 2014.81250, -2041.14062, 12.53906, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4807, 1964.64062, -2109.42187, 14.10937, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4808, 1892.33593, -2037.64843, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4806, 1880.33593, -2001.92187, 12.57031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4859, 1868.95312, -2003.65625, 13.75000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5064, 1855.45312, -1958.46093, 12.64843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4858, 1891.74218, -1872.28125, 14.85937, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5420, 1835.82031, -1815.14062, 7.64843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5489, 1932.59375, -1782.10156, 12.50000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5026, 1821.66406, -1872.31250, 12.40625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4819, 1815.45312, -1958.46093, 12.64843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4817, 1739.30468, -1951.95312, 12.37500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4837, 1823.00781, -2087.17187, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4849, 1892.33593, -2109.50781, 12.54687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4861, 1873.01562, -2101.83593, 15.89062, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4846, 1827.13281, -2158.85937, 14.51562, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5036, 1694.60156, -2131.11718, 12.55468, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5034, 1742.81250, -2292.75781, 3.92968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4829, 1645.38281, -2292.75781, 3.91406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4870, 1569.98437, -2194.72656, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4836, 1441.90625, -2166.64843, 13.27343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4872, 1610.92968, -2010.62500, 23.13281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5028, 1624.00000, -2113.61718, 23.10937, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4820, 1738.39062, -2117.02343, 13.93750, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4876, 1582.29687, -2002.23437, 26.60937, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4878, 1530.82812, -1969.13281, 26.39062, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4852, 1401.46093, -1994.58593, 35.43750, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4823, 1338.32812, -1976.65625, 36.60937, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4875, 1270.68750, -2196.78906, 42.56250, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4824, 1224.42968, -2037.00781, 62.92968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4851, 1182.00781, -1987.63281, 39.99218, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4810, 1095.06250, -2214.21875, 41.72656, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5046, 1105.50000, -2355.95312, 16.31250, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4809, 1036.52343, -2204.43750, 14.16406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4815, 1074.58593, -2321.74218, 10.85156, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4898, 992.85937, -2126.61718, 12.08593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4896, 981.70312, -2155.85156, 1.07031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4814, 1071.03125, -2354.00781, 1.07031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4812, 1023.39843, -2166.10156, 23.10156, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5023, 1046.05468, -2251.50781, 33.64062, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4811, 1069.67187, -2270.89843, 23.10156, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4897, 985.72656, -2050.53125, 3.04687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5021, 1044.91406, -2023.39062, 17.50781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4813, 1042.27343, -2029.80468, 23.10156, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6065, 887.46093, -1878.39062, 3.12500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6118, 1050.07812, -1864.31250, 12.39843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6117, 1109.32031, -1852.37500, 12.56250, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4168, 1217.45312, -1852.26562, 12.47656, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4108, 1177.46093, -1782.25000, 12.66406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4182, 1304.98437, -1792.28125, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4107, 1360.75781, -1802.25000, 12.49218, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4010, 1350.75781, -1802.28125, 12.69531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4165, 1469.52343, -1872.37500, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4207, 1603.81250, -1863.34375, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4133, 1625.09375, -1834.20312, 24.29687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4209, 1569.93750, -1802.28906, 12.32031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4122, 1629.46093, -1812.28906, 13.52343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4160, 1686.62500, -1806.42968, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(3991, 1608.19531, -1721.80468, 26.00000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6116, 997.56250, -1798.51562, 12.95312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6054, 1036.41406, -1689.17968, 12.60937, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6042, 952.34375, -1822.82031, 15.17968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6122, 798.09375, -1763.10156, 12.69531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6123, 917.39843, -1672.90625, 12.39843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6203, 956.19531, -1689.60156, 12.79687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6115, 1087.46093, -1712.26562, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6128, 1207.46093, -1712.19531, 12.66406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6126, 1149.89843, -1642.14843, 12.60937, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(3978, 1380.26562, -1655.53906, 10.80468, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4197, 1380.26562, -1655.53906, 10.80468, 0.00000, 0.00000, 270.00000);
	SnijegObjekti(4198, 1380.26562, -1655.53906, 10.80468, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6127, 1306.51562, -1630.35937, 12.46875, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4163, 1469.33593, -1732.28906, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4148, 1427.05468, -1662.28906, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4186, 1479.55468, -1693.14062, 19.57812, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4158, 1609.55468, -1732.32812, 12.46875, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4150, 1532.05468, -1662.28906, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4029, 1629.54687, -1756.08593, 8.09375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(3985, 1479.56250, -1631.45312, 12.07812, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4129, 1595.00000, -1603.02343, 27.03906, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(3989, 1646.00781, -1662.71875, 8.09375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(3993, 1719.93750, -1662.28906, 12.46875, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4013, 1654.59375, -1637.74218, 28.64062, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(3987, 1722.05468, -1702.28906, 12.81250, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(3992, 1755.60156, -1782.30468, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(3983, 1722.50000, -1775.39843, 14.51562, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(3977, 1384.36718, -1511.43750, 10.10937, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4146, 1371.00000, -1582.34375, 12.45312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4144, 1442.15625, -1517.53125, 12.45312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(3994, 1479.55468, -1592.28906, 12.45312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4020, 1544.83593, -1516.85156, 32.45312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4142, 1494.75781, -1410.87500, 12.45312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4139, 1406.17187, -1418.10156, 12.78906, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4712, 1546.98437, -1356.61718, 14.95312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(3990, 1593.95312, -1416.35156, 26.66406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(3996, 1596.35937, -1440.87500, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4131, 1588.44531, -1509.14062, 27.31250, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4128, 1666.91406, -1456.75000, 26.04687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4127, 1664.12500, -1560.85156, 23.35156, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4152, 1658.10937, -1516.69531, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4233, 1603.90625, -1592.29687, 12.54687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4156, 1739.81250, -1602.19531, 12.45312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4001, 1700.47656, -1517.69531, 17.93750, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4125, 1769.51562, -1509.48437, 12.44531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4154, 1706.21093, -1432.35156, 12.44531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4645, 1605.72656, -1370.82812, 15.54687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4557, 1714.74218, -1350.87500, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5498, 1849.32812, -1373.39843, 12.48437, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(3995, 1797.16406, -1464.39062, 7.99218, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5439, 1887.79687, -1536.60156, 7.89843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5501, 1884.66406, -1613.42187, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5502, 1822.89062, -1725.25781, 12.46875, 0.00000, 0.00000, 270.00000);
	SnijegObjekti(5503, 1927.70312, -1754.31250, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5441, 1941.65625, -1682.57031, 12.47656, 0.00000, 0.00000, 270.00000);
	SnijegObjekti(5505, 2002.48437, -1700.98437, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5507, 2041.66406, -1672.31250, 12.47656, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5442, 2041.72656, -1752.31250, 12.47656, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5518, 2137.98437, -1672.55468, 12.77343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5504, 2046.00000, -1613.00000, 12.00000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5512, 2069.92187, -1535.78125, 10.49218, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5471, 2088.10937, -1568.11718, 11.05468, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5472, 2117.29687, -1541.57812, 23.53906, 0.00000, 0.00000, 270.00000);
	SnijegObjekti(5391, 2148.80468, -1627.12500, 13.42968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5519, 2159.81250, -1595.92187, 12.89062, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5438, 2222.67187, -1462.91406, 22.78906, 0.00000, 0.00000, 270.00000);
	SnijegObjekti(17509, 2511.75781, -1544.31250, 18.51562, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17505, 2339.78906, -1583.99218, 12.76562, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17877, 2374.30468, -1640.43750, 12.50000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5429, 2244.69531, -1518.75000, 22.23437, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17625, 2315.35937, -1444.20312, 22.13281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17637, 2391.17968, -1414.32812, 22.92968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17636, 2411.16406, -1402.88281, 28.01562, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17645, 2481.21875, -1350.49218, 27.77343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17644, 2511.76562, -1349.52343, 30.79687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17634, 2411.02343, -1301.75000, 25.40625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17642, 2411.08593, -1235.32812, 27.80468, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17635, 2411.02343, -1352.10156, 23.70312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17630, 2371.07812, -1216.36718, 24.71093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17628, 2371.08593, -1320.45312, 22.91406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17976, 2414.39843, -1362.20312, 32.60156, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17643, 2451.01562, -1230.28906, 29.18750, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17646, 2511.00000, -1256.60156, 33.79687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17641, 2454.60156, -1350.46093, 22.82812, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17627, 2347.67187, -1384.31250, 22.92968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17545, 2337.17968, -1342.62500, 23.32812, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17626, 2303.43750, -1338.03906, 22.98437, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5674, 2286.37500, -1371.27343, 22.95312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5428, 2252.00000, -1434.14062, 23.25781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5494, 2263.21093, -1368.70312, 22.92968, 0.00000, 0.00000, 270.00000);
	SnijegObjekti(5437, 2155.00000, -1382.00000, 23.00000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5427, 2170.97656, -1461.12500, 25.08593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5496, 2120.00000, -1440.00000, 23.00000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5497, 2060.19531, -1463.40625, 18.94531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5495, 2066.00000, -1358.00000, 23.00000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5492, 2168.21093, -1300.80468, 22.89843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5477, 2287.09375, -1217.65625, 24.54687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17632, 2307.52343, -1225.10156, 23.80468, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5490, 2269.78125, -1224.53125, 24.40625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5491, 2171.39062, -1220.82031, 22.88281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5424, 2218.89062, -1260.81250, 24.28906, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5493, 2169.97656, -1260.46093, 22.91406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5482, 2172.57031, -1171.20312, 23.55468, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5459, 2123.93750, -1159.00000, 24.16406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5650, 2213.50000, -1124.90625, 24.79687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5423, 2121.10156, -1260.87500, 26.15625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5435, 2069.36718, -1260.99218, 22.89843, 0.00000, 0.00000, 90.00000);
	SnijegObjekti(5434, 1946.82812, -1260.90625, 17.67968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5499, 1944.00000, -1341.00000, 18.00000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5487, 1972.60937, -1198.31250, 23.97656, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5458, 1995.01562, -1198.35156, 21.10937, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5483, 2069.29687, -1149.20312, 22.94531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5432, 2110.09375, -1098.80468, 23.79687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5485, 1950.59375, -1135.88281, 24.02343, 0.00000, 0.00000, 180.00000);
	SnijegObjekti(5486, 2005.50000, -1081.30468, 24.19531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5443, 2019.40625, -1107.13281, 24.55468, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5481, 2023.25781, -1034.48437, 29.12500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5445, 2105.96093, -1038.55468, 40.41406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5444, 2143.05468, -1048.40625, 48.64843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5446, 2086.29687, -1077.07812, 29.05468, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5484, 2190.58593, -1063.07031, 45.14062, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5456, 2185.09375, -1013.21093, 59.19531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13706, 2372.03125, -1056.34375, 57.03906, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13823, 2284.00781, -929.46875, 88.18750, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5451, 2256.03125, -1019.92187, 59.38281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13795, 2422.11718, -1093.34375, 48.15625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17631, 2336.93750, -1153.14062, 26.62500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17669, 2378.03125, -1110.17187, 33.61718, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17906, 2440.30468, -1120.25000, 43.29687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17670, 2463.75000, -1151.64843, 34.96875, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17647, 2420.95312, -1179.13281, 31.01562, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17678, 2506.88281, -1167.06250, 46.24218, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17648, 2511.03906, -1184.53906, 48.20312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17892, 2511.02343, -1220.26562, 42.52343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17893, 2553.97656, -1205.13281, 60.65625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17894, 2524.44531, -1205.61718, 56.40625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17651, 2636.89062, -1184.08593, 64.55468, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17650, 2570.89843, -1230.30468, 52.79687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17652, 2646.79687, -1257.00000, 51.79687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17649, 2571.00000, -1350.40625, 33.89843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17679, 2540.82812, -1350.58593, 40.89843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17681, 2682.64843, -1456.39843, 29.45312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17653, 2642.78906, -1350.25781, 39.14062, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17666, 2642.67187, -1217.78125, 58.21093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17658, 2730.13281, -1445.92187, 32.68750, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17608, 2806.30468, -1488.45312, 19.58593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17556, 2804.71093, -1451.60937, 19.54687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17561, 2769.53125, -1446.67187, 22.06250, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17683, 2866.69531, -1355.90625, 15.69531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17674, 2903.42968, -1336.88281, 9.97656, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17676, 2928.05468, -1298.13281, 8.16406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17660, 2825.99218, -1386.36718, 15.17187, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17685, 2810.67187, -1263.75000, 39.12500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17589, 2801.78125, -1392.64062, 20.00000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17661, 2796.89062, -1323.23437, 32.82812, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17673, 2882.54687, -1146.64062, 10.08593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17684, 2847.09375, -1148.80468, 16.89843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17659, 2729.00000, -1330.70312, 47.29687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17663, 2730.19531, -1220.90625, 63.39843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17662, 2777.29687, -1259.00000, 52.00000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17664, 2685.25781, -1220.95312, 59.39843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17671, 2633.64843, -1152.68750, 47.90625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17696, 2690.39062, -1154.14062, 56.71093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17677, 2587.65625, -1101.25781, 56.55468, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17849, 2642.73437, -1086.32031, 66.02343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17667, 2642.71875, -1164.50000, 59.16406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17693, 2730.23437, -1117.64843, 64.17187, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17691, 2778.79687, -1099.79687, 41.39843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17672, 2789.42187, -1144.94531, 29.95312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13810, 2948.41406, -951.76562, -28.52343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13708, 2778.64843, -930.35156, 39.13281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13709, 2856.43750, -930.17968, 16.14843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13809, 2734.87500, -917.96093, 47.82031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13497, 2870.02343, -662.57812, 26.10156, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13121, 2870.02343, -662.57812, 26.10156, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(12877, 2870.77343, -677.79687, 10.67968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13120, 2629.58593, -662.28906, 89.49218, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13156, 2379.60156, -670.41406, 112.02343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13123, 2631.27343, -415.71875, 54.14843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13134, 2372.07031, -407.32812, 73.57031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13710, 2523.76562, -915.31250, 85.32812, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13707, 2563.92187, -1047.17187, 68.17187, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17692, 2681.78125, -1078.75000, 68.31250, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17694, 2704.28906, -1095.78906, 62.45312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17668, 2506.70312, -1079.83593, 54.94531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13122, 2862.23437, -413.64062, -4.21875, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(12878, 2807.10937, -480.72656, 16.26562, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(12974, 2793.53125, -447.35937, 18.17968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(12876, 2815.46875, -278.23437, 10.93750, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(12879, 2732.03906, -231.38281, 29.75781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13824, 2039.82031, -904.82031, 79.06250, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13157, 2148.91406, -662.00000, 90.57031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13158, 1941.59375, -686.10156, 75.89843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13825, 1826.08593, -882.76562, 75.32031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5433, 2044.59375, -1007.20312, 38.89843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5448, 2068.20312, -965.95312, 47.88281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5656, 2046.64843, -1009.96875, 40.89062, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4695, 1898.47656, -1016.67968, 29.50781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5431, 1914.17968, -1073.31250, 23.10156, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5668, 1928.90625, -1026.75781, 28.71875, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5457, 1923.60937, -1088.34375, 24.50781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5640, 1914.03125, -1198.32812, 19.59375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5488, 1852.26562, -1196.06250, 20.42187, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4700, 1807.28125, -1049.87500, 23.50000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4604, 1757.00781, -1127.25781, 23.09375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4658, 1810.93750, -1001.45312, 34.09375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4692, 1702.95312, -1031.42968, 39.69531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4701, 1722.28906, -1043.25000, 23.01562, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4595, 1634.42968, -1115.53125, 23.03125, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4702, 1647.33593, -1033.16406, 22.99218, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4666, 1614.67968, -1024.67968, 42.78125, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4653, 1661.97656, -910.81250, 46.05468, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4664, 1643.16406, -1128.23437, 41.56250, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4662, 1624.82031, -1229.85937, 34.08593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4656, 1693.95312, -766.04687, 50.00781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13826, 1805.02343, -699.98437, 69.79687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13672, 1700.89062, -556.53906, 38.35937, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13723, 1496.91406, -790.91406, 48.67968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13821, 1530.92187, -532.64062, 62.98437, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13751, 1650.02343, -559.67187, 42.35156, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13820, 1701.62500, -489.19531, 59.69531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13502, 1935.17968, -526.87500, 51.14062, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13146, 1935.17968, -526.87500, 51.14062, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13719, 1437.55468, -669.28906, 86.81250, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13673, 1284.30468, -677.42187, 81.37500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13674, 1411.90625, -562.96875, 67.58593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13818, 1317.85937, -474.10156, 52.21875, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13323, 1245.20312, -430.53906, 22.42187, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13237, 1148.69531, -528.16406, 57.31250, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13752, 1210.70312, -625.61718, 78.71093, 0.00000, 0.00000, 10.44999);
	SnijegObjekti(13720, 1192.34375, -669.16406, 52.32812, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4660, 1507.78125, -966.94531, 33.83593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4703, 1569.92187, -1041.07812, 22.97656, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13882, 1376.50000, -788.78906, 67.08593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4694, 1425.03906, -947.82812, 34.28125, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5803, 1376.42968, -912.18750, 36.17968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13756, 1349.29687, -809.14062, 68.88281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13801, 1341.02343, -839.93750, 58.13281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13757, 1250.80468, -833.01562, 63.37500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5845, 1323.66406, -884.63281, 36.25000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5851, 1323.66406, -884.63281, 36.25000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5744, 1268.44531, -935.32031, 37.70312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13715, 1041.32031, -707.45312, 90.02343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13718, 1063.58593, -626.98437, 112.21093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13528, 1138.66406, -311.89062, 38.21093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13212, 1138.66406, -311.89062, 38.21093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13324, 979.50781, -500.17968, 33.12500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13213, 896.94531, -285.84375, 22.55468, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13214, 871.25781, -411.43750, 38.10156, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13236, 953.02343, -569.69531, 68.14062, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13211, 594.83593, -299.83593, 6.28125, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13129, 786.71093, -539.52343, 15.25000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(12999, 681.71093, -574.88281, 15.25000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(3316, 769.21875, -558.86718, 18.67187, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(3353, 798.24218, -500.96875, 16.32812, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(3314, 815.15625, -500.96875, 16.32812, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(12998, 811.71875, -580.96875, 15.25781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(12981, 857.21093, -609.96875, 17.41406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13531, 797.70312, -707.14062, 64.24218, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13235, 797.70312, -707.14062, 64.24218, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13845, 667.54687, -853.20312, 52.79687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13704, 653.58593, -841.35156, 39.59375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13730, 767.57031, -927.32812, 48.36718, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13702, 696.50781, -849.16406, 54.88281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13726, 809.36718, -778.78125, 80.09375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(12976, 681.47656, -459.00000, 15.53125, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13001, 701.06250, -507.64062, 15.25000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13127, 631.71093, -507.64062, 15.25000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13000, 563.56250, -438.88281, 36.09375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(12989, 536.89062, -578.04687, 32.39843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13128, 640.57031, -660.17968, 12.60937, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(12971, 548.76562, -626.98437, 26.17187, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13370, 543.13281, -807.58593, 52.84375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13371, 422.06250, -782.47656, 42.61718, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13021, 387.11718, -941.69531, 51.42187, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(12864, 183.82812, -697.42968, 24.14843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13019, 141.58593, -858.93750, 5.67968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(12973, 421.21093, -570.23437, 37.92187, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13020, 317.19531, -869.16406, 33.00781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13342, 133.44531, -655.82812, 14.52343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(12970, 310.78906, -591.55468, 33.39843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13017, 155.79687, -1140.15625, 6.23437, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13683, 339.72656, -1086.42968, 73.91406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13871, 415.52343, -1080.00000, 76.90625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13789, 191.51562, -1207.74218, 52.64843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13692, 252.23437, -1211.92968, 64.96093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13685, 428.91406, -1103.67187, 77.15625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13735, 313.93750, -1203.23437, 74.50000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13678, 223.12500, -1150.96875, 64.75000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13736, 239.78906, -1283.89843, 61.64062, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13733, 329.53906, -1237.81250, 62.83593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13738, 319.97656, -1289.57031, 52.48437, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13734, 366.11718, -1226.23437, 58.15625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13732, 449.83593, -1233.48437, 33.21875, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13684, 495.02343, -1153.19531, 62.08593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13742, 508.64062, -1244.42968, 40.16406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6509, 529.00781, -1268.35937, 15.51562, 0.00000, 0.00000, 39.00000);
	SnijegObjekti(6327, 377.28909, -1362.66406, 13.58593, 0.00000, 0.00000, 30.10199);
	SnijegObjekti(6330, 525.21093, -1443.21875, 14.47656, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13741, 332.99218, -1331.38281, 32.97656, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6356, 381.28125, -1323.17187, 24.49218, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6328, 294.97656, -1366.74218, 18.92968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13740, 179.30468, -1448.42968, 28.01562, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6326, 207.59375, -1484.50781, 11.90625, 0.00000, 0.00000, 207.04595);
	SnijegObjekti(6497, 227.78906, -1423.03125, 18.60937, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13737, 252.86718, -1288.48437, 64.32812, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13739, 216.09375, -1361.97656, 49.17187, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13690, 135.64062, -1455.68750, 25.62500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13675, 116.01563, -1393.33593, 24.90625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6325, 128.12500, -1551.03125, 8.20312, 0.00000, 0.00000, 352.20999);
	SnijegObjekti(17281, -42.50780, -1476.89062, 4.31250, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17121, -65.05467, -1572.94531, -3.89843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17118, -52.24219, -1395.50781, 4.52343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17186, -39.32030, -1566.71875, 1.42187, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17279, -111.00781, -1362.33593, 5.23437, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13676, 78.41406, -1270.49218, 13.69531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13677, 92.21875, -1291.65625, 14.11718, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17301, -49.39062, -1140.86718, 5.20312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17297, -28.64842, -1020.34375, 16.39843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6292, 137.72656, -1026.68750, 24.59375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17117, 5.04687, -1000.33593, 17.08593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17305, -153.19531, -971.96093, 34.26562, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(12851, -51.97655, -842.67187, 19.74218, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17115, -283.96875, -960.07031, 33.62500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17302, -160.82812, -1100.76562, 6.42968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17296, -178.11718, -1049.76562, 14.33593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17303, -114.95313, -1179.69531, 3.14843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17119, -226.96093, -1253.90625, 7.86718, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6428, 245.19531, -1736.70312, 3.63281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6315, 205.46093, -1656.82031, 8.96875, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6416, 95.64842, -1593.14843, -19.21093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6314, 127.64842, -1659.70312, 7.42187, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6293, 125.69531, -1768.54687, -10.59375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6280, 260.02343, -1839.91406, -1.45312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6417, 156.53906, -1908.78125, -13.68750, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6427, 293.21875, -1691.21875, 7.84375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6448, 335.30468, -1711.90625, 25.62500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6449, 387.76562, -1823.63281, 12.50781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6311, 400.69531, -1755.70312, 6.50000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6297, 432.81250, -1856.28906, 1.22656, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6450, 379.72656, -1945.95312, -1.21875, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6300, 379.53906, -2050.86718, -1.21875, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6310, 437.89843, -1715.10156, 8.59375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6281, 570.74218, -1868.34375, 1.67968, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6443, 301.93750, -1657.81250, 19.64843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6313, 437.19531, -1679.44531, 19.22656, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6316, 199.40629, -1626.73437, 12.37500, 0.00000, 0.00000, 133.05000);
	SnijegObjekti(6312, 202.71093, -1580.11718, 22.47656, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6317, 270.29687, -1613.60156, 32.19531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6305, 328.57031, -1612.57812, 31.93750, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6320, 297.50000, -1490.30468, 32.09375, 0.00000, 0.00000, 31.96500);
	SnijegObjekti(6345, 236.54690, -1498.31250, 21.75000, 0.00000, 0.00000, 337.82998);
	SnijegObjekti(6347, 238.17968, -1509.85156, 22.11718, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6321, 270.69531, -1576.20312, 31.89843, 0.00000, 0.00000, 345.65499);
	SnijegObjekti(6341, 332.89062, -1500.06250, 29.87500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6323, 416.46881, -1446.08593, 30.79687, 0.00000, 0.00000, 36.04999);
	SnijegObjekti(6319, 444.21881, -1376.51562, 24.67187, 0.00000, 0.00000, 28.30500);
	SnijegObjekti(6318, 572.95312, -1328.72656, 13.07031, 0.00000, 0.00000, 14.27000);
	SnijegObjekti(6324, 632.57812, -1443.09375, 13.68750, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6508, 624.70312, -1252.11718, 14.87500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6331, 473.82031, -1437.41406, 21.69531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6302, 576.14062, -1406.25781, 13.76562, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6322, 496.27343, -1500.14062, 16.66406, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6304, 444.00000, -1521.40625, 27.19531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6303, 359.21090, -1523.76562, 31.59375, 0.00000, 0.00000, 38.40999);
	SnijegObjekti(6343, 389.48437, -1528.78906, 28.50781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6333, 422.00000, -1583.10156, 23.69531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6329, 557.53906, -1577.91406, 15.03125, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6307, 491.46875, -1630.75000, 20.07812, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6306, 428.05468, -1654.95312, 24.92187, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6308, 565.81250, -1671.28125, 16.36718, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6398, 552.53125, -1695.57812, 15.54687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6064, 688.53125, -1877.96093, 2.01562, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6309, 576.64062, -1730.42187, 11.88281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6291, 631.66406, -1647.45312, 14.38281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6225, 724.81250, -1673.65625, 11.62500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6227, 676.61718, -1668.96093, 3.85156, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6231, 753.04687, -1676.26562, 8.14062, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6119, 810.87500, -1703.42968, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6229, 773.20312, -1667.99218, 2.93750, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6188, 836.31250, -1866.75781, -0.53906, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6120, 845.66406, -1607.29687, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6189, 836.44531, -2003.52343, -2.64062, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6114, 1044.78906, -1572.26562, 12.52343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6121, 926.75000, -1572.27343, 12.51562, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6124, 742.40625, -1595.16406, 13.52343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6111, 784.50000, -1496.20312, 12.39843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6135, 764.32031, -1509.04687, 16.82812, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6094, 731.15625, -1506.53125, 3.75000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6301, 717.48437, -1362.77343, 12.51562, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6487, 713.56250, -1236.21875, 17.82031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13703, 495.41406, -957.49218, 79.33593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13872, 587.67187, -958.76562, 65.35156, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13689, 567.82812, -1031.39843, 71.59375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13688, 689.69531, -1023.00000, 50.46875, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13698, 650.87500, -1076.07812, 38.83593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5765, 819.57812, -986.02337, 35.93750, 0.00000, 0.00000, 116.42299);
	SnijegObjekti(5753, 850.82812, -1013.78125, 30.25781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5755, 796.46093, -1111.12500, 23.18750, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6507, 696.89837, -1138.50000, 18.19531, 0.00000, 0.00000, 191.77600);
	SnijegObjekti(5756, 797.91406, -1234.44531, 17.71875, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5805, 869.92187, -1144.73437, 22.75781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5871, 879.57031, -1092.87500, 26.15625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5864, 849.91406, -1196.68750, 19.40625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5865, 892.79687, -1268.61718, 19.72656, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5863, 912.88281, -1194.32812, 20.73437, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5705, 830.86718, -1269.12500, 20.85937, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5796, 859.89062, -1323.78906, 12.37500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5798, 797.35156, -1357.64062, 12.54687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5862, 847.35156, -1400.48437, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13693, 560.28125, -1184.89843, 44.22656, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13686, 553.59375, -1164.53125, 51.34375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5754, 962.60156, -1056.30468, 30.37500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5807, 1041.99218, -1039.29687, 30.19531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5875, 1022.64062, -1080.32812, 27.25781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5758, 1012.59375, -1145.08593, 22.75781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5757, 943.43750, -1220.53125, 17.61718, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5759, 1058.11718, -1234.76562, 17.60156, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5747, 1084.46875, -1048.88281, 32.07031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5748, 1133.00781, -1145.96875, 22.77343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5878, 1122.65625, -1080.45312, 26.73437, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5752, 989.11718, -966.10156, 39.50781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5866, 916.57812, -952.71093, 43.07031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5718, 901.23437, -967.47662, 47.65625, 0.00000, 0.00000, 10.00000);
	SnijegObjekti(5987, 913.71875, -918.58593, 49.34375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5853, 1018.16412, -908.97662, 43.64843, 0.00000, 0.00000, 7.71999);
	SnijegObjekti(13711, 994.05468, -841.23437, 75.50000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5802, 1124.57031, -950.24218, 41.75781, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13814, 850.87500, -912.80468, 58.14062, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13813, 817.73437, -917.84375, 54.37500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13716, 849.37500, -828.64843, 73.56250, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13713, 970.15625, -818.52343, 90.96093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13887, 967.20312, -715.27343, 107.97656, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(13804, 1077.60937, -651.60937, 114.28906, 0.00000, 0.00000, 144.86500);
	SnijegObjekti(13717, 1161.32031, -755.01562, 84.80468, 0.00000, 0.00000, 8.92500);
	SnijegObjekti(13784, 1156.85937, -852.75781, 49.35937, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5743, 1265.29687, -889.95312, 40.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5746, 1163.17187, -1046.42968, 32.29687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5745, 1262.95312, -1037.64843, 32.07031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5801, 1266.13281, -1037.72656, 28.40625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5806, 1149.63281, -1039.24218, 30.94531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5793, 1365.47656, -998.26562, 30.32812, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5887, 1212.76562, -1090.07812, 26.37500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5823, 1140.17968, -1207.25781, 18.82031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4649, 1425.16406, -1035.25781, 24.19531, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4650, 1482.25000, -1097.30468, 22.85937, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5800, 1355.72656, -1089.84375, 24.33593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5799, 1350.15625, -1170.82031, 19.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6007, 1308.24218, -1088.84375, 26.75000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4651, 1539.85937, -1087.31250, 22.72656, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4568, 1529.90625, -1096.78125, 22.40625, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4652, 1539.84375, -1161.74218, 23.00000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4567, 1646.46093, -1161.70312, 22.86718, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4710, 1762.11718, -1170.89062, 22.76562, 0.00000, 0.00000, 180.00000);
	SnijegObjekti(4591, 1753.75781, -1231.39843, 12.44531, 0.00000, 0.00000, 180.00000);
	SnijegObjekti(4654, 1715.46093, -1230.87500, 18.26562, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4643, 1654.76562, -1246.28906, 16.17187, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5436, 1987.00000, -1408.00000, 17.00000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5500, 1948.95312, -1461.20312, 12.46875, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4589, 1780.00000, -1281.00000, 13.00000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4592, 1798.46093, -1223.46093, 17.54687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4556, 1660.04687, -1340.72656, 15.63281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4646, 1650.83593, -1300.85937, 15.54687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4684, 1661.54687, -1216.45312, 16.27343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4562, 1574.59375, -1248.10156, 15.39843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4685, 1572.59375, -1216.50000, 17.50000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4565, 1513.69531, -1204.80468, 18.50000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4648, 1419.67968, -1150.12500, 22.86718, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4679, 1607.88281, -1324.62500, 32.72656, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4553, 1530.83593, -1300.85156, 15.54687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4647, 1454.75781, -1309.12500, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4551, 1410.16406, -1333.39062, 9.92187, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(4644, 1416.19531, -1210.87500, 17.59375, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5750, 1350.15625, -1250.83593, 14.13281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5859, 1350.14843, -1353.36718, 12.47656, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5751, 1283.73437, -1145.08593, 22.61718, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5804, 1213.76562, -1177.09375, 19.75000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5707, 1269.39843, -1256.96093, 14.52343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6006, 1183.69531, -1241.35937, 16.27343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5857, 1259.43750, -1246.81250, 17.10937, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5749, 1144.40625, -1251.48437, 15.10937, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5703, 998.15625, -1220.82031, 15.83593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5812, 1230.89062, -1337.98437, 12.53906, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5794, 1200.90625, -1337.99218, 12.39843, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5810, 1114.31250, -1348.10156, 17.98437, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5994, 1259.22656, -1400.40625, 10.78125, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5995, 1130.05468, -1400.70312, 12.52343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5860, 1058.14843, -1363.26562, 12.61718, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5795, 985.72656, -1324.79687, 12.45312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5732, 1014.02343, -1361.46093, 20.35156, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5808, 1255.24218, -1337.96093, 12.32812, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5809, 1281.43750, -1337.95312, 12.37500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6035, 1329.03125, -1479.07812, 12.46093, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6101, 1268.24218, -1467.84375, 11.82031, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6129, 1205.11718, -1572.27343, 12.42187, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6125, 1196.03906, -1489.07031, 12.37500, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6130, 1117.58593, -1490.00781, 32.71875, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5861, 979.94531, -1400.49218, 12.36718, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6055, 1050.08593, -1489.03906, 12.53906, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6113, 984.29687, -1491.40625, 12.50000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6152, 990.08593, -1450.08593, 12.77343, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6160, 982.61718, -1530.82812, 12.83593, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6112, 917.50000, -1489.10156, 12.29687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6217, 846.45312, -1523.52343, 12.35156, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(6059, 855.09375, -1461.80468, 12.79687, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5815, 877.16406, -1361.20312, 12.45312, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5797, 917.35937, -1361.24218, 12.38281, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5784, 988.27337, -1289.63281, 15.37500, 0.00000, 0.00000, 180.00000);
	SnijegObjekti(5760, 1016.92968, -1249.92968, 18.50000, 0.00000, 0.00000, 270.00000);
	SnijegObjekti(4879, 1374.25781, -2184.03906, 21.07812, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17665, 2604.34375, -1220.23437, 54.75000, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(17629, 2338.92968, -1299.60156, 23.03125, 0.00000, 0.00000, 0.00000);
	SnijegObjekti(5624, 2136.72656, -975.82812, 58.10937, 0.00000, 0.00000, 345.00500);
	print("Ucitani sneg objekti");
	#endif
	
// MAPE

//BANKAINTERIOR
	new bankainterior;
	bankainterior = CreateDynamicObject(19454, 1457.844360, -992.780700, 13.943711, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF000000);
	bankainterior = CreateDynamicObject(19454, 1457.844360, -992.320251, 13.943715, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF000000);
	bankainterior = CreateDynamicObject(19454, 1453.103027, -987.606079, 13.943709, 0.000000, 0.000000, -89.799911, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF000000);
	bankainterior = CreateDynamicObject(19454, 1453.117797, -997.536743, 13.933707, 0.000000, 0.000000, -89.799911, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF000000);
	bankainterior = CreateDynamicObject(19458, 1455.172607, -981.903930, 16.936452, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1476.124511, -981.903930, 16.936452, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1476.124511, -991.533569, 16.936452, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1476.124511, -1001.163879, 16.936452, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1471.244750, -1005.544433, 16.936452, 0.000000, 0.000000, 89.600021, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1461.653686, -1005.478210, 16.936452, 0.000000, 0.000000, 89.600021, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1452.053833, -1005.411132, 16.936452, 0.000000, 0.000000, 89.600021, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19454, 1478.248901, -997.478698, 13.933707, 0.000000, 0.000000, -89.799911, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF000000);
	bankainterior = CreateDynamicObject(19454, 1478.214355, -987.628479, 13.933707, 0.000000, 0.000000, -89.799911, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF000000);
	bankainterior = CreateDynamicObject(19454, 1473.492187, -992.416503, 13.933707, 0.000000, 0.000000, 0.100084, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF000000);
	bankainterior = CreateDynamicObject(19454, 1473.492187, -992.766845, 13.933707, 0.000000, 0.000000, 0.100084, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF000000);
	bankainterior = CreateDynamicObject(19458, 1455.172607, -972.293701, 16.936452, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1476.123168, -981.913818, 20.436458, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1455.172607, -972.293701, 20.436458, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1476.123168, -972.293701, 20.436458, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1476.123168, -972.293701, 16.956459, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19454, 1459.353637, -971.339233, 17.506990, 0.000000, 0.000000, 89.900009, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFF00);
	bankainterior = CreateDynamicObject(19454, 1455.314575, -970.146545, 14.780833, -90.299995, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF000000);
	bankainterior = CreateDynamicObject(19454, 1457.455078, -970.146545, 14.780833, -90.299995, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF000000);
	bankainterior = CreateDynamicObject(19454, 1459.694824, -970.146545, 14.780833, -90.299995, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF000000);
	bankainterior = CreateDynamicObject(19454, 1461.906250, -970.146545, 14.780833, -90.299995, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF000000);
	bankainterior = CreateDynamicObject(19454, 1464.236938, -970.146545, 14.780833, -90.299995, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF000000);
	bankainterior = CreateDynamicObject(19458, 1475.246582, -971.244995, 20.426454, 0.000000, 0.000000, 89.599975, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1475.246582, -971.244995, 16.946445, 0.000000, 0.000000, 89.599975, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1470.511962, -966.474426, 20.436458, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1470.511962, -966.474426, 16.946462, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1476.123168, -991.533874, 20.436458, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1476.123168, -1001.163696, 20.436458, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1455.171264, -1001.143676, 20.426458, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1455.171264, -991.533752, 20.426458, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1455.171264, -981.903808, 20.426458, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1471.244750, -1005.544433, 20.436454, 0.000000, 0.000000, 89.600021, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1461.655029, -1005.477172, 20.436454, 0.000000, 0.000000, 89.600021, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1452.054565, -1005.410156, 20.436454, 0.000000, 0.000000, 89.600021, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1455.172607, -962.664123, 20.436458, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1455.172607, -962.664123, 16.956445, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1461.902343, -965.094848, 20.436441, 0.000000, 0.000000, -90.099952, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1461.902343, -965.094848, 16.956438, 0.000000, 0.000000, -90.099952, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1452.272460, -965.078430, 16.956438, 0.000000, 0.000000, -90.099952, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1452.272460, -965.078430, 20.456441, 0.000000, 0.000000, -90.099952, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1473.082885, -965.114440, 20.456441, 0.000000, 0.000000, -90.099952, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1473.082885, -965.114440, 16.966438, 0.000000, 0.000000, -90.099952, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1468.322631, -965.095886, 22.416429, 0.000000, 0.000000, -90.099952, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19454, 1466.222412, -1000.628173, 15.169792, 0.000000, 89.899971, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF330000);
	bankainterior = CreateDynamicObject(19454, 1466.222412, -991.008239, 15.169792, 0.000000, 89.899971, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF330000);
	bankainterior = CreateDynamicObject(19454, 1466.222412, -981.388244, 15.169792, 0.000000, 89.899971, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF330000);
	bankainterior = CreateDynamicObject(19454, 1459.687866, -979.559875, 15.172887, 0.000000, 89.899971, 89.500022, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF330000);
	bankainterior = CreateDynamicObject(19454, 1472.789916, -979.673645, 15.172887, 0.000000, 89.899971, 89.500022, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF330000);
	bankainterior = CreateDynamicObject(19454, 1472.764038, -1006.705444, 15.175692, 0.000000, 89.899971, 89.500022, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF330000);
	bankainterior = CreateDynamicObject(19454, 1459.714355, -1006.601867, 15.155674, 0.000000, 89.899971, 89.500022, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF330000);
	bankainterior = CreateDynamicObject(19454, 1453.981567, -1000.628173, 15.148422, 0.000000, 89.899971, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF330000);
	bankainterior = CreateDynamicObject(19454, 1453.981567, -985.357788, 15.148422, 0.000000, 89.899971, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF330000);
	bankainterior = CreateDynamicObject(19454, 1477.331909, -985.357788, 15.189187, 0.000000, 89.899971, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF330000);
	bankainterior = CreateDynamicObject(19454, 1477.331909, -1000.737976, 15.189187, 0.000000, 89.899971, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFF330000);
	bankainterior = CreateDynamicObject(19458, 1470.511962, -956.864379, 16.946462, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1470.511962, -956.864379, 20.426456, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1468.496826, -958.238037, 19.746437, 0.000000, 0.000000, 89.500030, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1455.736572, -958.127319, 19.746437, 0.000000, 0.000000, 89.500030, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1455.736572, -958.127319, 23.246442, 0.000000, 0.000000, 89.500030, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1465.285888, -958.210876, 22.556427, 0.000000, 0.000000, 89.500030, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	bankainterior = CreateDynamicObject(19458, 1474.926635, -958.293762, 23.226448, 0.000000, 0.000000, 89.500030, -1, -1, -1, 200.00, 200.00);
	SetDynamicObjectMaterial(bankainterior, 0, -1, "none", "none", 0xFFFFFFFF);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bankainterior = CreateDynamicObject(19375, 1470.930908, -1001.138549, 15.150217, 0.000000, -90.100013, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19375, 1460.451782, -1001.138549, 15.131925, 0.000000, -90.100013, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19375, 1460.451782, -991.518920, 15.131925, 0.000000, -90.100013, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19375, 1470.930908, -991.508728, 15.150217, 0.000000, -90.100013, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19375, 1460.451782, -981.909057, 15.131925, 0.000000, -90.100013, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19375, 1470.931030, -981.909057, 15.150214, 0.000000, -90.100013, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19859, 1464.736816, -1005.406799, 16.428606, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19859, 1467.717529, -1005.408630, 16.428606, 0.000000, 0.000000, 179.800033, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19603, 1455.424926, -990.060241, 15.606301, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19603, 1455.424926, -995.060363, 15.606301, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19603, 1455.424926, -995.060363, 15.606301, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19603, 1455.424926, -990.060241, 15.606301, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19603, 1476.015258, -995.060363, 15.606301, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19603, 1476.015258, -995.060363, 15.606301, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19603, 1476.015258, -990.071105, 15.606301, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19603, 1476.015258, -990.071105, 15.606301, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19458, 1455.172607, -1001.143920, 16.936452, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19458, 1455.172607, -991.533691, 16.936452, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(14394, 1467.202270, -979.667480, 15.957322, 0.000000, 0.000000, 90.099952, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(14394, 1459.212646, -979.681396, 15.957322, 0.000000, 0.000000, 90.099952, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(14394, 1475.191772, -979.653564, 15.957322, 0.000000, 0.000000, 90.099952, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(14394, 1459.209228, -977.761474, 17.347339, 0.000000, 0.000000, 90.099952, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(14394, 1467.169799, -977.747619, 17.347339, 0.000000, 0.000000, 90.099952, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(14394, 1475.139770, -977.733825, 17.347339, 0.000000, 0.000000, 90.099952, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19375, 1470.926757, -971.848327, 18.100217, 0.000000, -90.100013, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19375, 1460.425292, -971.848327, 18.081895, 0.000000, -90.100013, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19439, 1462.414428, -970.941467, 19.210439, 0.000000, 89.999992, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19439, 1458.915039, -970.941467, 19.210439, 0.000000, 89.999992, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19439, 1455.445434, -970.941467, 19.210439, 0.000000, 89.999992, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19375, 1460.425292, -962.238464, 18.081895, 0.000000, -90.100013, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19375, 1470.915405, -962.238464, 18.100210, 0.000000, -90.100013, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1470.812255, -1000.700195, 22.086702, 0.000000, -90.100006, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1470.812255, -991.070434, 22.086702, 0.000000, -90.100006, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1470.812255, -981.450622, 22.086702, 0.000000, -90.100006, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1470.812255, -971.831054, 22.086702, 0.000000, -90.100006, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1470.812255, -962.200988, 22.086702, 0.000000, -90.100006, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1460.322509, -962.200988, 22.068386, 0.000000, -90.100006, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1460.322509, -971.840942, 22.068386, 0.000000, -90.100006, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1460.322509, -981.450866, 22.068386, 0.000000, -90.100006, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1460.322509, -991.070373, 22.068386, 0.000000, -90.100006, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1460.322509, -1000.700500, 22.068386, 0.000000, -90.100006, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(3533, 1456.622680, -998.816162, 19.444520, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(3533, 1456.622680, -986.246154, 19.444520, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(3533, 1474.702880, -986.246154, 19.444520, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(3533, 1474.702880, -998.835693, 19.444520, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(2182, 1455.740356, -966.628906, 18.161060, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(2182, 1474.603271, -971.805358, 18.161060, 0.000000, 0.000000, -90.199996, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(1671, 1456.470703, -968.597106, 18.629829, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(1671, 1458.590454, -968.597106, 18.629829, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(1671, 1460.820190, -968.597106, 18.629829, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(1671, 1463.070190, -968.597106, 18.629829, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19893, 1463.060302, -970.630126, 19.283203, 0.000000, 0.000000, 179.799942, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19893, 1460.850830, -970.622680, 19.283203, 0.000000, 0.000000, 179.799942, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19893, 1458.520141, -970.614562, 19.283203, 0.000000, 0.000000, 179.799942, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19893, 1456.440063, -970.607177, 19.283203, 0.000000, 0.000000, 179.799942, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(1808, 1457.560791, -965.564392, 18.165077, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(1808, 1458.051025, -965.564392, 18.165077, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(2161, 1458.975219, -965.300231, 18.157114, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(2167, 1460.339599, -965.314025, 18.169157, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(2167, 1461.280029, -965.314025, 18.169157, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(2273, 1458.922485, -965.659118, 20.419681, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(1557, 1470.374755, -966.141296, 18.171604, 0.000000, 0.000000, -89.199951, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(1557, 1470.416259, -969.161437, 18.171604, 0.000000, 0.000000, 90.700088, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19806, 1466.210449, -1001.905883, 21.242755, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19806, 1466.210449, -985.694335, 21.242755, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19806, 1466.210449, -996.145385, 21.242755, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19806, 1466.210449, -981.114074, 21.242755, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19806, 1466.210449, -990.764709, 21.242755, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(2244, 1460.249877, -965.560424, 19.960596, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(2244, 1461.230102, -965.560424, 19.960596, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(638, 1456.759155, -982.891967, 15.872353, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(638, 1456.759155, -1001.622375, 15.872353, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(638, 1474.419189, -1001.622375, 15.872353, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(638, 1474.419189, -983.171813, 15.872353, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19172, 1476.038696, -989.469848, 17.947078, 0.000000, 0.000000, -89.999900, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19172, 1455.248779, -989.469848, 17.947078, 0.000000, 0.000000, 90.000183, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19173, 1476.041259, -992.025329, 17.562824, 0.000000, 0.000000, -89.999992, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19173, 1455.271118, -992.025329, 17.562824, 0.000000, 0.000000, -89.999992, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(2257, 1455.268066, -991.983947, 19.087335, 0.000000, 0.000000, 90.000007, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(2257, 1476.019042, -991.944091, 19.087335, 0.000000, 0.000000, -89.999992, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19173, 1455.271118, -989.745178, 19.242832, 0.000000, 0.000000, -89.999992, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19173, 1476.021240, -989.735534, 19.212818, 0.000000, 0.000000, -89.999992, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19172, 1455.248779, -994.659545, 17.947078, 0.000000, 0.000000, 90.000183, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19172, 1476.038696, -994.669982, 17.947078, 0.000000, 0.000000, -89.999900, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19173, 1455.271118, -994.395324, 19.242832, 0.000000, 0.000000, -89.999992, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19173, 1476.021240, -994.395568, 19.212818, 0.000000, 0.000000, -89.999992, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(2614, 1466.230102, -1005.372619, 18.756090, 0.000000, 0.000000, 179.699981, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(1491, 1466.711425, -965.100524, 18.179359, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19081, 1459.831787, -958.189758, 18.450147, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19081, 1459.831787, -958.189758, 18.720153, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19081, 1459.831787, -958.189758, 18.990158, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19081, 1459.831787, -958.189758, 19.250165, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19081, 1459.831787, -958.189758, 19.520172, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19081, 1459.831787, -958.189758, 19.790178, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19081, 1459.831787, -958.189758, 20.060184, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19081, 1459.831787, -958.189758, 20.320190, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19081, 1459.831787, -958.189758, 20.570196, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19302, 1460.316284, -958.252929, 19.385076, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19302, 1463.824951, -958.307128, 19.385076, 0.000000, 0.000000, 178.999984, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19302, 1460.824707, -958.277343, 21.504661, 0.000000, -89.899978, 179.599975, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19302, 1463.314331, -958.305236, 21.509008, 0.000000, -89.899978, 179.099960, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1469.819091, -953.397827, 16.884983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1469.819091, -943.778137, 16.884983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1456.688842, -953.288391, 16.884983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1456.688842, -943.668579, 16.884983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(14394, 1466.887207, -956.368164, 17.347339, 0.000000, 0.000000, -89.700065, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(14394, 1458.956909, -956.409606, 17.347339, 0.000000, 0.000000, -89.700065, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(14394, 1458.945800, -954.209350, 15.727334, 0.000000, 0.000000, -89.700065, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(14394, 1466.935668, -954.167480, 15.727334, 0.000000, 0.000000, -89.700065, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1465.151000, -952.571289, 22.076826, 0.000000, -90.100006, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1465.151000, -943.011535, 22.076826, 0.000000, -90.100006, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1454.721313, -943.011535, 22.058616, 0.000000, -90.100006, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1454.721313, -952.611389, 22.058616, 0.000000, -90.100006, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1465.149902, -939.014892, 16.884983, 0.000000, 0.000000, 89.599998, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1455.549926, -938.947753, 16.884983, 0.000000, 0.000000, 89.599998, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1465.163574, -948.391479, 14.886833, 0.000000, -90.100006, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1465.163574, -938.781494, 14.886833, 0.000000, -90.100006, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1454.743530, -938.781494, 14.868643, 0.000000, -90.100006, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1454.743530, -948.411437, 14.868643, 0.000000, -90.100006, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(1829, 1463.334472, -939.849609, 15.449419, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(2332, 1464.199218, -939.531738, 15.408843, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(2332, 1462.479370, -939.531738, 15.408843, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(1550, 1464.871337, -939.433776, 15.340068, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(1550, 1461.841308, -939.313659, 15.340068, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(1550, 1461.400878, -939.313659, 15.340068, 0.000000, 13.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(1550, 1461.633300, -939.592285, 15.268084, 0.000000, 13.000000, 81.799987, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1458.850830, -941.270935, 16.884983, 0.000000, 0.000000, 136.299957, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1467.684570, -941.588439, 16.884983, 0.000000, 0.000000, -137.699996, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(2332, 1462.479370, -939.531738, 16.338851, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(2332, 1464.169311, -939.531738, 16.338851, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(2332, 1463.328735, -939.531738, 16.398851, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19377, 1463.331909, -940.981933, 20.500568, -52.299983, -90.100006, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19913, 1489.835449, -945.055053, 20.368907, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19913, 1437.194091, -945.055053, 20.368907, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	bankainterior = CreateDynamicObject(19913, 1458.054443, -945.055053, 23.538908, 0.000000, 0.000000, 0.000000, -1, -1, -1, 200.00, 200.00);
	print("Ucitana banka");

//================================ VIP BAZA ====================================

	CreateDynamicObject(19313, 1063.35522, -1732.68469, 15.91272,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19313, 1077.43237, -1732.73010, 15.91272,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19313, 1091.42957, -1732.79102, 15.91272,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3749, 1108.06580, -1741.06543, 18.18420,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19313, 1103.07788, -1732.84436, 15.91272,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19313, 1056.35132, -1739.68530, 15.91270,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19313, 1056.37036, -1753.72620, 15.91270,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19313, 1056.34436, -1767.72729, 15.91270,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19313, 1056.34570, -1781.70496, 15.91270,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19313, 1063.33630, -1788.67505, 15.91270,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19313, 1077.30408, -1788.64551, 15.91270,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19313, 1091.20483, -1788.54883, 15.91270,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19313, 1102.88391, -1783.41162, 15.91270,   0.00000, 0.00000, 47.87996);
	CreateDynamicObject(19313, 1107.56531, -1771.20789, 15.91270,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19313, 1107.56812, -1757.21729, 15.91270,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19454, 1080.89746, -1772.28149, 10.63274,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19454, 1080.89746, -1762.68103, 10.63270,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19454, 1080.89734, -1753.05872, 10.67196,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(16001, 1093.79468, -1784.66638, 12.64197,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(16001, 1079.82581, -1784.63696, 12.64197,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(9327, 1066.01672, -1783.45447, 14.25680,   0.00000, 0.00000, 90.00000);
	print("Ucitana vip baza");
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//================================== TD ========================================
	
	IGTD0 = TextDrawCreate(872.999877, 436.225952, "usebox");
	TextDrawLetterSize(IGTD0, 0.000000, 17.422424);
	TextDrawTextSize(IGTD0, -40.000007, 0.000000);
	TextDrawAlignment(IGTD0, 1);
	TextDrawColor(IGTD0, 0);
	TextDrawUseBox(IGTD0, true);
	TextDrawBoxColor(IGTD0, 102);
	TextDrawSetShadow(IGTD0, 0);
	TextDrawSetOutline(IGTD0, 0);
	TextDrawFont(IGTD0, 0);

	IGTD1 = TextDrawCreate(-25.333372, 434.726135, "LD_SPAC:white");
	TextDrawLetterSize(IGTD1, 0.000000, 0.000000);
	TextDrawTextSize(IGTD1, 735.333129, 0.829626);
	TextDrawAlignment(IGTD1, 1);
	TextDrawColor(IGTD1, -5963521);
	TextDrawSetShadow(IGTD1, 0);
	TextDrawSetOutline(IGTD1, 0);
	TextDrawFont(IGTD1, 4);

	IGTD2 = TextDrawCreate(57.000003, 433.896270, "00:00");
	TextDrawLetterSize(IGTD2, 0.193999, 1.392591);
	TextDrawAlignment(IGTD2, 2);
	TextDrawColor(IGTD2, -1);
	TextDrawSetShadow(IGTD2, 0);
	TextDrawSetOutline(IGTD2, 0);
	TextDrawBackgroundColor(IGTD2, 51);
	TextDrawFont(IGTD2, 2);
	TextDrawSetProportional(IGTD2, 1);

	IGTD3 = TextDrawCreate(570.333129, 433.896331, "00/00/0000");
	TextDrawLetterSize(IGTD3, 0.188333, 1.421628);
	TextDrawAlignment(IGTD3, 2);
	TextDrawColor(IGTD3, -1);
	TextDrawSetShadow(IGTD3, 0);
	TextDrawSetOutline(IGTD3, 0);
	TextDrawBackgroundColor(IGTD3, 51);
	TextDrawFont(IGTD3, 2);
	TextDrawSetProportional(IGTD3, 1);

	IGTD4 = TextDrawCreate(71.000007, 435.555541, "LD_SPAC:white");
	TextDrawLetterSize(IGTD4, 0.000000, 0.000000);
	TextDrawTextSize(IGTD4, 1.000000, 44.800003);
	TextDrawAlignment(IGTD4, 1);
	TextDrawColor(IGTD4, -5963521);
	TextDrawSetShadow(IGTD4, 0);
	TextDrawSetOutline(IGTD4, 0);
	TextDrawFont(IGTD4, 4);

	IGTD5 = TextDrawCreate(540.999816, 435.140716, "LD_SPAC:white");
	TextDrawLetterSize(IGTD5, 0.000000, 0.000000);
	TextDrawTextSize(IGTD5, 1.000000, 63.881484);
	TextDrawAlignment(IGTD5, 1);
	TextDrawColor(IGTD5, -5963521);
	TextDrawSetShadow(IGTD5, 0);
	TextDrawSetOutline(IGTD5, 0);
	TextDrawFont(IGTD5, 4);

	IGTD6 = TextDrawCreate(-92.666671, 431.407348, "LD_SPAC:white");
	TextDrawLetterSize(IGTD6, 0.000000, 0.000000);
	TextDrawTextSize(IGTD6, 134.666656, 104.118515);
	TextDrawAlignment(IGTD6, 1);
	TextDrawColor(IGTD6, -5963521);
	TextDrawSetShadow(IGTD6, 0);
	TextDrawSetOutline(IGTD6, 0);
	TextDrawFont(IGTD6, 4);

	IGTD7 = TextDrawCreate(597.332946, 431.407379, "LD_SPAC:white");
	TextDrawLetterSize(IGTD7, 0.000000, 0.000000);
	TextDrawTextSize(IGTD7, 202.333328, 146.844451);
	TextDrawAlignment(IGTD7, 1);
	TextDrawColor(IGTD7, -5963521);
	TextDrawSetShadow(IGTD7, 0);
	TextDrawSetOutline(IGTD7, 0);
	TextDrawFont(IGTD7, 4);

	IGTD8 = TextDrawCreate(20.666685, 431.407348, "PC:RP");
	TextDrawLetterSize(IGTD8, 0.254999, 1.533628);
	TextDrawAlignment(IGTD8, 2);
	TextDrawColor(IGTD8, 255);
	TextDrawUseBox(IGTD8, true);
	TextDrawBoxColor(IGTD8, 0);
	TextDrawSetShadow(IGTD8, 0);
	TextDrawSetOutline(IGTD8, 0);
	TextDrawBackgroundColor(IGTD8, 51);
	TextDrawFont(IGTD8, 2);
	TextDrawSetProportional(IGTD8, 1);

	IGTD9 = TextDrawCreate(619.333190, 431.407379, "v1.0");
	TextDrawLetterSize(IGTD9, 0.277666, 1.533628);
	TextDrawAlignment(IGTD9, 2);
	TextDrawColor(IGTD9, 255);
	TextDrawSetShadow(IGTD9, 0);
	TextDrawSetOutline(IGTD9, 0);
	TextDrawBackgroundColor(IGTD9, 51);
	TextDrawFont(IGTD9, 2);
	TextDrawSetProportional(IGTD9, 1);

	IGTD10 = TextDrawCreate(326.667022, 435.555511, "Ovo je tekst na kom ce vam se stalno pojavljivati korisne stvari u vezi servera!");
	TextDrawLetterSize(IGTD10, 0.157332, 1.156148);
	TextDrawAlignment(IGTD10, 2);
	TextDrawColor(IGTD10, -1);
	TextDrawSetShadow(IGTD10, 0);
	TextDrawSetOutline(IGTD10, 1);
	TextDrawBackgroundColor(IGTD10, 51);
	TextDrawFont(IGTD10, 2);
	TextDrawSetProportional(IGTD10, 1);

	IGTD11 = TextDrawCreate(602.999816, 4.148143, "PerfectCrime");
	TextDrawLetterSize(IGTD11, 0.244665, 0.857481);
	TextDrawAlignment(IGTD11, 2);
	TextDrawColor(IGTD11, -5963521);
	TextDrawUseBox(IGTD11, true);
	TextDrawBoxColor(IGTD11, 0);
	TextDrawSetShadow(IGTD11, 0);
	TextDrawSetOutline(IGTD11, 1);
	TextDrawBackgroundColor(IGTD11, 51);
	TextDrawFont(IGTD11, 3);
	TextDrawSetProportional(IGTD11, 1);

	IGTD12 = TextDrawCreate(624.666564, 13.688865, "v1.0");
	TextDrawLetterSize(IGTD12, 0.159999, 0.749629);
	TextDrawAlignment(IGTD12, 2);
	TextDrawColor(IGTD12, -5963521);
	TextDrawSetShadow(IGTD12, 0);
	TextDrawSetOutline(IGTD12, 1);
	TextDrawBackgroundColor(IGTD12, 51);
	TextDrawFont(IGTD12, 2);
	TextDrawSetProportional(IGTD12, 1);

	IGTD13 = TextDrawCreate(74.333282, 434.311035, "Online: 100");
	TextDrawLetterSize(IGTD13, 0.151000, 1.293037);
	TextDrawAlignment(IGTD13, 1);
	TextDrawColor(IGTD13, -1);
	TextDrawSetShadow(IGTD13, 0);
	TextDrawSetOutline(IGTD13, 0);
	TextDrawBackgroundColor(IGTD13, 51);
	TextDrawFont(IGTD13, 2);
	TextDrawSetProportional(IGTD13, 1);

	IGTD14 = TextDrawCreate(113.333351, 435.140655, "LD_SPAC:white");
	TextDrawLetterSize(IGTD14, 0.000000, 0.000000);
	TextDrawTextSize(IGTD14, 0.999989, 79.229637);
	TextDrawAlignment(IGTD14, 1);
	TextDrawColor(IGTD14, -5963521);
	TextDrawSetShadow(IGTD14, 0);
	TextDrawSetOutline(IGTD14, 0);
	TextDrawFont(IGTD14, 4);

	print("Ucitani TD-ovi");
//==============================================================================
	for(new vehicleid = 0; vehicleid < MAX_VEHICLES; vehicleid++)
	{
	    VehInfo[vehicleid][vEngine] = 0;
		VehInfo[vehicleid][vLights] = 0;
		VehInfo[vehicleid][vAlarm] = 0;
		VehInfo[vehicleid][vDoor] = 0;
		VehInfo[vehicleid][vBonnet] = 0;
		VehInfo[vehicleid][vObj] = 0;
		VehInfo[vehicleid][vFuel] = 60;
		SetVehicleParamsEx(vehicleid, 0, VehInfo[vehicleid][vEngine], VehInfo[vehicleid][vLights], VehInfo[vehicleid][vAlarm], VehInfo[vehicleid][vDoor], VehInfo[vehicleid][vBonnet], VehInfo[vehicleid][vObj]);
	}
	print("Ucitan sistem za vozila");
//===============================================BUS STANICE=========================================
	//====StaniceGanton
	CreateDynamicObject(1257, 1812.663696, -1918.751220, 13.812520, 0.000000, 0.000000, 180.000000);
	CreateDynamicObject(1257, 2025.822631, -1946.279541, 13.757586, 0.000000, 0.000000, 270.000000);
	CreateDynamicObject(1257, 2261.015136, -1903.274658, 13.781888, 0.000000, 0.000000, 270.000000);
	CreateDynamicObject(1257, 2388.850341, -1981.269897, 13.707318, 0.000000, 0.000000, 270.000000);
	CreateDynamicObject(1257, 2500.457275, -1941.177246, 13.768292, 0.000000, 0.000000, 270.000000);
	CreateDynamicObject(1257, 2460.287597, -1723.396240, 13.821391, 0.000000, 0.000000, 90.000000);
	CreateDynamicObject(1257, 2228.167236, -1696.907348, 13.970689, 0.000000, 0.000000, -6.599997);
	CreateDynamicObject(1257, 2107.859130, -1604.719604, 13.773658, 0.000000, 0.000000, 84.400024);
	CreateDynamicObject(1257, 1992.828735, -1682.632690, 13.796389, 0.000000, 0.000000, 180.000000);
	CreateDynamicObject(1257, 1917.549072, -1743.331176, 13.774445, 0.000000, 0.000000, 90.000000);
	CreateDynamicObject(1257, 1812.766723, -1874.982055, 13.765649, 0.000000, 0.000000, 180.000000);
//===================================================================================================
	return 1;
}

public OnGameModeExit()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    SavePlayer(i);
	}
	for(new i = 0; i < MAX_HOUSES; i++)
	{
	    SaveHouse(i);
	}
	for(new i = 0; i < MAX_ORGS; i++)
	{
	    SaveOrg(i);
	}
	for(new i = 0; i < MAX_PORTS; i++)
	{
	    SavePort(i);
	}
	for(new i = 0; i < MAX_PROMOTERS; i++)
	{
	    SavePromoter(i);
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], 1126.4000,-2036.9590,69.8837, 270, 0, 0, 0, 0, 0, 0);
	TogglePlayerSpectating(playerid, false);
	SpawnPlayer(playerid);
	return 1;
}

public OnPlayerConnect(playerid)
{
	SetTimer("TDStatus", 3000, true);
    new ime[128];
	GetPlayerName(playerid, ime, 128);

	lastMoney[playerid] = 0;
	ulogovan[playerid] = 0;

	for(new i = 0; i < MAX_PROMOTERS; i++)
	{
	 	if(!strcmp(PromoterInfo[i][promName], ime))
	 	{
	 	    PromoterInfo[i][promNeaktivnost] = 0;
	 	    SavePromoter(i);
	 	    break;
	 	}
	}

	editagate[playerid] = 0;
	editagateid[playerid] = 0;
	gatefaza[playerid] = 0;
	editing[playerid] = 0;

	TogglePlayerSpectating(playerid, true);

	pADuty[playerid] = 0;
	
	for(new i = 0; i < MAX_ADMINS; i++)
	{
	    if(!strcmp(AdminInfo[i][aName], ime))
	    {
	        AdminInfo[i][aNeaktivnost] = 0;
	        SaveAdmin(i);
	        break;
	    }
	}

	SetTimer("CarUpdate", 100, true);

	editaorg[playerid] = -1;

    Speedometer0[playerid] = CreatePlayerTextDraw(playerid, 621.666809, 388.107513, "usebox");
	PlayerTextDrawLetterSize(playerid, Speedometer0[playerid], 0.000000, 0.052058);
	PlayerTextDrawTextSize(playerid, Speedometer0[playerid], 484.333251, 0.000000);
	PlayerTextDrawAlignment(playerid, Speedometer0[playerid], 1);
	PlayerTextDrawColor(playerid, Speedometer0[playerid], 0);
	PlayerTextDrawUseBox(playerid, Speedometer0[playerid], true);
	PlayerTextDrawBoxColor(playerid, Speedometer0[playerid], 102);
	PlayerTextDrawSetShadow(playerid, Speedometer0[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Speedometer0[playerid], 0);
	PlayerTextDrawFont(playerid, Speedometer0[playerid], 0);

	Speedometer1[playerid] = CreatePlayerTextDraw(playerid, 625.333374, 369.440826, "usebox");
	PlayerTextDrawLetterSize(playerid, Speedometer1[playerid], 0.000000, 4.286630);
	PlayerTextDrawTextSize(playerid, Speedometer1[playerid], 619.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Speedometer1[playerid], 1);
	PlayerTextDrawColor(playerid, Speedometer1[playerid], 0);
	PlayerTextDrawUseBox(playerid, Speedometer1[playerid], true);
	PlayerTextDrawBoxColor(playerid, Speedometer1[playerid], 102);
	PlayerTextDrawSetShadow(playerid, Speedometer1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Speedometer1[playerid], 0);
	PlayerTextDrawFont(playerid, Speedometer1[playerid], 0);

	Speedometer2[playerid] = CreatePlayerTextDraw(playerid, 503.999908, 374.992584, "carname");
	PlayerTextDrawLetterSize(playerid, Speedometer2[playerid], 0.253000, 1.069036);
	PlayerTextDrawAlignment(playerid, Speedometer2[playerid], 2);
	PlayerTextDrawColor(playerid, Speedometer2[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Speedometer2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Speedometer2[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Speedometer2[playerid], 51);
	PlayerTextDrawFont(playerid, Speedometer2[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Speedometer2[playerid], 1);

	Speedometer3[playerid] = CreatePlayerTextDraw(playerid, 487.333343, 392.829589, "100kph");
	PlayerTextDrawLetterSize(playerid, Speedometer3[playerid], 0.228000, 1.056591);
	PlayerTextDrawAlignment(playerid, Speedometer3[playerid], 1);
	PlayerTextDrawColor(playerid, Speedometer3[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Speedometer3[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Speedometer3[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Speedometer3[playerid], 51);
	PlayerTextDrawFont(playerid, Speedometer3[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Speedometer3[playerid], 1);

	Speedometer4[playerid] = CreatePlayerTextDraw(playerid, 524.333374, 392.829681, "fuel: 100l");
	PlayerTextDrawLetterSize(playerid, Speedometer4[playerid], 0.225000, 1.085629);
	PlayerTextDrawAlignment(playerid, Speedometer4[playerid], 1);
	PlayerTextDrawColor(playerid, Speedometer4[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Speedometer4[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Speedometer4[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Speedometer4[playerid], 51);
	PlayerTextDrawFont(playerid, Speedometer4[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Speedometer4[playerid], 1);

	Speedometer5[playerid] = CreatePlayerTextDraw(playerid, 571.666748, 393.244415, "hp: 1000.0");
	PlayerTextDrawLetterSize(playerid, Speedometer5[playerid], 0.224666, 1.064888);
	PlayerTextDrawAlignment(playerid, Speedometer5[playerid], 1);
	PlayerTextDrawColor(playerid, Speedometer5[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Speedometer5[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Speedometer5[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Speedometer5[playerid], 51);
	PlayerTextDrawFont(playerid, Speedometer5[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Speedometer5[playerid], 1);

	Speedometer6[playerid] = CreatePlayerTextDraw(playerid, 522.999877, 391.840637, "usebox");
	PlayerTextDrawLetterSize(playerid, Speedometer6[playerid], 0.000000, 1.711318);
	PlayerTextDrawTextSize(playerid, Speedometer6[playerid], 516.999877, 0.000000);
	PlayerTextDrawAlignment(playerid, Speedometer6[playerid], 1);
	PlayerTextDrawColor(playerid, Speedometer6[playerid], 0);
	PlayerTextDrawUseBox(playerid, Speedometer6[playerid], true);
	PlayerTextDrawBoxColor(playerid, Speedometer6[playerid], 102);
	PlayerTextDrawSetShadow(playerid, Speedometer6[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Speedometer6[playerid], 0);
	PlayerTextDrawFont(playerid, Speedometer6[playerid], 0);

	Speedometer7[playerid] = CreatePlayerTextDraw(playerid, 569.999877, 391.840759, "usebox");
	PlayerTextDrawLetterSize(playerid, Speedometer7[playerid], 0.000000, 1.757406);
	PlayerTextDrawTextSize(playerid, Speedometer7[playerid], 563.999877, 0.000000);
	PlayerTextDrawAlignment(playerid, Speedometer7[playerid], 1);
	PlayerTextDrawColor(playerid, Speedometer7[playerid], 0);
	PlayerTextDrawUseBox(playerid, Speedometer7[playerid], true);
	PlayerTextDrawBoxColor(playerid, Speedometer7[playerid], 102);
	PlayerTextDrawSetShadow(playerid, Speedometer7[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Speedometer7[playerid], 0);
	PlayerTextDrawFont(playerid, Speedometer7[playerid], 0);

	Speedometer8[playerid] = CreatePlayerTextDraw(playerid, 554.666625, 347.199981, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, Speedometer8[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Speedometer8[playerid], 63.666625, 37.333343);
	PlayerTextDrawAlignment(playerid, Speedometer8[playerid], 1);
	PlayerTextDrawColor(playerid, Speedometer8[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Speedometer8[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Speedometer8[playerid], 0);
	PlayerTextDrawFont(playerid, Speedometer8[playerid], 4);


//============================= REMOVE =========================================

//VIP BAZA

	RemoveBuildingForPlayer(playerid, 1280, 1074.9609, -1783.0781, 13.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1065.3125, -1783.0781, 13.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1084.6094, -1783.0781, 13.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 1290, 1080.8438, -1777.4922, 18.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1094.2656, -1783.0781, 13.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1107.6250, -1779.8359, 13.9766, 0.25);

//
	RemoveBuildingForPlayer(playerid, 691, 1208.6484, -2000.0703, 67.3906, 0.25);
	RemoveBuildingForPlayer(playerid, 691, 1205.2734, -1987.8203, 63.7891, 0.25);
//==============================================================================

	SetTimer("TDUpdate", 1000, true);

	radi[playerid] = 0;
	jobprogress[playerid] = 0;
	
	renta[playerid] = -1;
	
	SendClientMessage(playerid, -1, "Dobrodosli na server!");
	if(fexist(UserPath(playerid)))
	{
	    INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra=true, .extra=playerid);
	    new reason[128];
	    format(reason, sizeof(reason), "Razlog: {FFFFFF}%s", PlayerInfo[playerid][pBanRazlog]);
	    if(PlayerInfo[playerid][pBan] == 0)
	    {
		    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Unesite vasu lozinku:", "Prijavi se", "Odustani");
		    PlayerInfo[playerid][pNeededRep]=(PlayerInfo[playerid][pLevel]*2+4)*100;
		    logintimer[playerid] = SetTimer("LoginTimer", 30000, false);
		    SCM(playerid, COLOR_RED, "[PC]: {FFFFFF}Imate 30 sekundi da se prijavite!");
	    }
	    else
	    {
	        SetTimerEx("BanMessage", 3000, false, "i", playerid);
	    }
	}
	else
 	{
 		TutorijalProgres[playerid] = 0;
        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Register", "Unesite vasu lozinku:", "Registruj se", "Odustani");
 	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	SavePlayer(playerid);
	if(sneg[playerid] == 1) DestroyPlayerObject(playerid, snegobj[playerid]);
	new rentid;
	rentid = renta[playerid];
	rented[rentid] = 0;
	SetVehicleToRespawn(rentid);
	return 1;
}
public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	if(editing[playerid] == 1)
	{
	    if(gatefaza[playerid] == 1)
	    {
	        if(response == EDIT_RESPONSE_FINAL)
	        {
	            if(editagate[playerid] != 0)
	            {
	                new i = editagate[playerid];
	                GateInfo[i][gX] = fX;
	                GateInfo[i][gY] = fY;
	                GateInfo[i][gZ] = fZ;
	                GateInfo[i][gRX] = fRotX;
	                GateInfo[i][gRY] = fRotY;
	                GateInfo[i][gRZ] = fRotZ;
                    GateInfo[i][gObjID] = editagateid[playerid];
                    SaveGate(i);
                    SCM(playerid, COLOR_RED, "{DAA520}[Server]: {FFFFFF}Uspesno ste sacuvali poziiju zatvorenog gate!");
                    editing[playerid] = 0;
                    gatefaza[playerid] = 0;
                    SPD(playerid, DIALOG_GATEPERM, DIALOG_STYLE_LIST, "{DAA520}Permisije", "{FFFFFF}1 - {DAA520}Svi igraci\n{FFFFFF}2 - {DAA520}Samo Promoteri\n{FFFFFF}3 - {DAA520}Samo VIP\n{FFFFFF}4 - {DAA520}Organizacija\n{FFFFFF}5 - {DAA520}Supporter\n{FFFFFF}6 - {DAA520}Admin", "Potvrdi", "");
					return 1;
				}
	        }
	        if(response == EDIT_RESPONSE_CANCEL)
	        {
	            if(editagate[playerid] != 0)
	            {
	                new i = editagate[playerid];
	                GateInfo[i][gX] = fX;
	                GateInfo[i][gY] = fY;
	                GateInfo[i][gZ] = fZ;
	                GateInfo[i][gRX] = fRotX;
	                GateInfo[i][gRY] = fRotY;
	                GateInfo[i][gRZ] = fRotZ;
                    GateInfo[i][gObjID] = editagateid[playerid];
                    SaveGate(i);
                    SCM(playerid, COLOR_RED, "{DAA520}[Server]: {FFFFFF}Uspesno ste sacuvali poziiju zatvorenog gate!");
                    editing[playerid] = 0;
                    gatefaza[playerid] = 0;
                    SPD(playerid, DIALOG_GATEPERM, DIALOG_STYLE_LIST, "{DAA520}Permisije", "{FFFFFF}1 - {DAA520}Svi igraci\n{FFFFFF}2 - {DAA520}Samo Promoteri\n{FFFFFF}3 - {DAA520}Samo VIP\n{FFFFFF}4 - {DAA520}Organizacija\n{FFFFFF}5 - {DAA520}Supporter\n{FFFFFF}6 - {DAA520}Admin", "Potvrdi", "");
                    return 1;
				}
	        }
	    }
	}
	if(editing[playerid] == 2)
	{
	    if(gatefaza[playerid] == 2)
	    {
	        if(response == EDIT_RESPONSE_FINAL)
	        {
	            if(editagate[playerid] != 0)
	            {
	                new i = editagate[playerid], gfile[64];
	                format(gfile, sizeof(gfile), GATEPATH, i);
	                GateInfo[i][gOX] = fX;
	                GateInfo[i][gOY] = fY;
	                GateInfo[i][gOZ] = fZ;
                    DestroyObject(gateObj[i]);
                    SaveGate(i);
                    INI_ParseFile(gfile, "LoadGates", .bExtra = true, .extra = i);
                    gate[i] = CreateDynamicObject(GateInfo[i][gObjID], GateInfo[i][gX], GateInfo[i][gY], GateInfo[i][gZ], GateInfo[i][gRX], GateInfo[i][gRY], GateInfo[i][gRZ]);
                    SCM(playerid, COLOR_RED, "{DAA520}[Server]: {FFFFFF}Uspesno ste napravili gate!");
                    editing[playerid] = 0;
                    gatefaza[playerid] = 0;
                    editagate[playerid] = 0;
                    editagateid[playerid] = 0;
                    return 1;
	            }
	        }
	        if(response == EDIT_RESPONSE_CANCEL)
	        {
	            if(editagate[playerid] != 0)
	            {
	                new i = editagate[playerid], gfile[64];
	                format(gfile, sizeof(gfile), GATEPATH, i);
	                GateInfo[i][gOX] = fX;
	                GateInfo[i][gOY] = fY;
	                GateInfo[i][gOZ] = fZ;
                    DestroyObject(gateObj[i]);
                    SaveGate(i);
                    INI_ParseFile(gfile, "LoadGates", .bExtra = true, .extra = i);
                    gate[i] = CreateDynamicObject(GateInfo[i][gObjID], GateInfo[i][gX], GateInfo[i][gY], GateInfo[i][gZ], GateInfo[i][gRX], GateInfo[i][gRY], GateInfo[i][gRZ]);
                    SCM(playerid, COLOR_RED, "{DAA520}[Server]: {FFFFFF}Uspesno ste napravili gate!");
                    editing[playerid] = 0;
                    gatefaza[playerid] = 0;
                    editagate[playerid] = 0;
                    editagateid[playerid] = 0;
                    return 1;
             	}
	        }
	    }
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	SetCameraBehindPlayer(playerid);
	PrikaziTD(playerid);
	new RandomPoruka = random(sizeof(NasumicnePoruke));
	TextDrawSetString(IGTD10, NasumicnePoruke[RandomPoruka]);
	TextDrawShowForPlayer(playerid, IGTD10);
	return 1;
}
/*==============================================SVE KOMANDE============================================*/

/*==============================================ADMIN KOMANDE============================================*/


/*==============================================CIVILI KOMANDE============================================*/
CMD:gps(playerid, params[])
{
	if(brojgps < 1) return SendClientMessage(playerid, COLOR_RED, "[Server]: {FFFFFF}Na serveru jos uvek nema GPS-a!");
	new string[2048], text[64];
	for(new i = 1; i <= brojgps; i++)
	{
		format(text, 64, "{DAA520}[{FFFFFF}%d{DAA520}]{FFFFFF} - %s\n", i, GPSInfo[i][gpsIme]);
		strcat(string, text);
	}
	ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "{DAA520}GPS", string, "{DAA520}Izaberi", "{DAA520}Napusti");
	return 1;
}
CMD:napravigps(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, COLOR_RED, "[Server]: {FFFFFF}Niste ovlasceni!");
	new ime[128], Float:X, Float:Y, Float:Z, i = NewID(7), gps_file[64];
	if(sscanf(params, "s[128]", ime)) return SendClientMessage(playerid, COLOR_RED, "[Usage]: {FFFFFF}/napravigps [ime]");
	GetPlayerPos(playerid, X, Y, Z);
	GPSInfo[i][gpsIme] = ime;
	GPSInfo[i][gpsX] = X;
	GPSInfo[i][gpsY] = Y;
	GPSInfo[i][gpsZ] = Z;
	SaveGPS(i);
	SendClientMessage(playerid, -1, "{DAA520}[GPS]: {FFFFFF}Uspesno ste napravili novi GPS!");
	format(gps_file, 64, GPSPATH, i);
	INI_ParseFile(gps_file, "LoadGPS", .bExtra = true, .extra = i);
	brojgps++;
	return 1;
}

CMD:house(playerid, params[])
{
	if(PlayerInfo[playerid][pKuca] == 9999) return SCM(playerid, COLOR_RED, "[House]: {FFFFFF}Vi nemate kucu!");
	ShowPlayerDialog(playerid, DIALOG_HOUSE, DIALOG_STYLE_LIST, "{DAA520}House menu", "{FFFFFF}Informacije\nLociraj kucu\nZakljucaj/Otkljucaj kucu\nProdaj kucu drzavi\nProdaj kucu igracu\nSef\nPodesi iznajmljivanje sobe\nPodesi cenu iznajmljivanja sobe", "{DAA520}Izaberi", "{DAA520}Odustani");
	return 1;
}
CMD:radio(playerid, params[])
{
	ShowPlayerDialog(playerid, DIALOG_RADIO, DIALOG_STYLE_LIST, "{DAA520}Radio stanice", "{FFFFFF}Naxi Radio\nRock Radio\nPlay Radio\nRadio Karolina\nRadio Morava\nUgasi radio", "{DAA520}Izaberi", "{DAA520}Napusti");
	return 1;
}
CMD:legitnovac(playerid, params[])
{
	AC_GivePlayerMoney(playerid, 1000000);
	return 1;
}
CMD:novacnakvarno(playerid, params[])
{
	GivePlayerMoney(playerid, 1000);
	return 1;
}
CMD:napravivozilo(playerid, params[])
{
	new id, own, cena, posao, org, r, adm, vip, prom, b1, b2, doz, i = NewID(5);
	if(PlayerInfo[playerid][pAdmin] < 6) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Niste ovlasceni!");
	if(sscanf(params, "iiiiiiiiiiii", id, own, cena, posao, org, r, adm, vip, prom, b1, b2, doz)) return SCM(playerid, COLOR_RED, "[USAGE]: {FFFFFF}/napravivozilo [id] [ownable] [cena] [posao] [org] [rent] [admin] [vip] [promoter] [boja 1] [boja 2] [dozvola]");
	if(pEditujeVozilo[playerid] != 0) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Vec editujete vozilo!");
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	probnovozilo[playerid] = CreateVehicle(id, X, Y, Z, 0.0, b1, b2, -1, 0);
	pEditujeVozilo[playerid] = i;
	PutPlayerInVehicle(playerid, probnovozilo[playerid], 0);
	VoziloInfo[i][vID] = id;
	VoziloInfo[i][vOwnable] = own;
	VoziloInfo[i][vCena] = cena;
	VoziloInfo[i][vPosaoID] = posao;
	VoziloInfo[i][vOrgID] = org;
	VoziloInfo[i][vRent] = r;
	VoziloInfo[i][vAdmin] = adm;
	VoziloInfo[i][vVip] = vip;
	VoziloInfo[i][vPromoter] = prom;
	VoziloInfo[i][vBoja] = b1;
	VoziloInfo[i][vBoja2] = b2;
	VoziloInfo[i][vDozvola] = doz;
	VoziloInfo[i][vID] = id;
	VoziloInfo[i][vX] = X;
	VoziloInfo[i][vY] = Y;
	VoziloInfo[i][vZ] = Z;
	SaveVozilo(i);
	SCM(playerid, -1, "{DAA520}[Server]: {FFFFFF}Uspesno ste kreirali vozilo!");
	SCM(playerid, -1, "{DAA520}[Server]: {FFFFFF}Kada uparkirate vozilo, ukucajte /sacuvajvozilo!");
	return 1;
}
CMD:sacuvajvozilo(playerid, params[])
{
	if(pEditujeVozilo[playerid] != 0)
	{
		new Float:X, Float:Y, Float:Z, Float:R, i = pEditujeVozilo[playerid];
		GetVehiclePos(probnovozilo[playerid], X, Y, Z);
		GetVehicleZAngle(probnovozilo[playerid], R);
		VoziloInfo[i][vX] = X;
		VoziloInfo[i][vY] = Y;
		VoziloInfo[i][vZ] = Z;
		VoziloInfo[i][vRot] = R;
		SaveVozilo(i);
		SCM(playerid, -1, "{DAA520}[Server]: {FFFFFF}Uspesno ste parkirali vozilo, vozilo je sacuvano!");
		RemovePlayerFromVehicle(playerid);
		DestroyVehicle(probnovozilo[playerid]);
		new vozilo = AddStaticVehicle(VoziloInfo[i][vID], VoziloInfo[i][vX], VoziloInfo[i][vY], VoziloInfo[i][vZ], VoziloInfo[i][vRot], VoziloInfo[i][vBoja], VoziloInfo[i][vBoja2]);
		StaviLabel(i, vozilo);
		pEditujeVozilo[playerid] = 0;
	}
	return 1;
}
CMD:me(playerid, params[])
{
	new txt[128], str[256], name[64];
	if(sscanf(params, "s[128]", txt)) return SCM(playerid, COLOR_RED, "[USAGE]: {FFFFFF}/me [text]!");
	GetPlayerName(playerid, name, sizeof(name));
	format(str, sizeof(str), "{FF99FF}%s %s", name, txt);
	SendMes(20.0, playerid, COLOR_RED, str);
	return 1;
}
CMD:b(playerid, params[])
{
	new txt[128], str[256], name[64];
	if(sscanf(params, "s[128]", txt)) return SCM(playerid, COLOR_RED, "[USAGE]: {FFFFFF}/b [text]");
	GetPlayerName(playerid, name, sizeof(name));
	format(str, sizeof(str), "{DAA520}-|  [{FFFFFF}OOC{DAA520}] %s{FFFFFF}: %s  {DAA520}|-", name, txt);
	SendMes(20.0, playerid, COLOR_RED, str);
	return 1;
}
CMD:fv(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) return SCM(playerid, COLOR_RED, "[SERVER]: {FFFFFF}Niste ovlasceni!");
	if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "[SERVER]: {FFFFFF}Niste u vozilu!");
	RepairVehicle(GetPlayerVehicleID(playerid));
	SCM(playerid, COLOR_RED, "{DAA520}[SERVER]: {FFFFFF}Uspesno ste popravili vozilo!");
	return 1;
}
CMD:afv(playerid, params[])
{
	new id, vid;
	if(PlayerInfo[playerid][pAdmin] < 1) return SCM(playerid, COLOR_RED, "[SERVER]: {FFFFFF}Niste ovlasceni!");
	if(sscanf(params, "u", id)) return SCM(playerid, COLOR_RED, "[USAGE]: {FFFFFF}/afv [id igraca]");
	if(!IsPlayerConnected(id)) return SCM(playerid, COLOR_RED, "[SERVER]: {FFFFFFIgrac nije povezan!");
	if(!IsPlayerInAnyVehicle(id)) return SCM(playerid, COLOR_RED, "[SERVER]: {FFFFFF}Igrac nije u vozilu!");
	vid = GetPlayerVehicleID(id);
	RepairVehicle(vid);
	SCM(playerid, COLOR_RED, "{DAA520}[SERVER]: {FFFFFF}Uspesno ste popravili necije vozilo!");
	SCM(id, COLOR_RED, "{DAA520}[SERVER]: {FFFFFF}Admin vam je popravio vozilo!");
	return 1;
}
CMD:promoteri(playerid, params[])
{
	new string[3400], str[256], onl[64];
	for(new i = 0; i < MAX_PROMOTERS; i++)
	{
	    if(GetPlayerID(PromoterInfo[i][promName]) == -1)
	    {
	        format(onl, sizeof(onl), "{8B8989}Offline");
	    }
	    else
	    {
	        format(onl, sizeof(onl), "{7FFF00}Online");
	    }
	    format(str, sizeof(str), "{DAA520}[{FFFFFF}%d{DAA520}] - {FFFFFF}Ime: {DAA520}%s {FFFFFF}| {DAA520}%s {FFFFFF}| {FFFFFF}Neaktivnost: {DAA520}%d{FFFFFF}min \n", i, PromoterInfo[i][promName], onl, PromoterInfo[i][promNeaktivnost]);
		strcat(string, str);
	}
	SPD(playerid, DIALOG_PROMLIST, DIALOG_STYLE_MSGBOX, "{DAA520}Promoter Lista", string, "{DAA520}Potvrdi", "");
	return true;
}
CMD:skinipromotera(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) return SCM(playerid, COLOR_RED, "[SERVER]: {FFFFFF}Niste ovlasceni!");
	new slot, pfile[128], pid, plfile[128], niko[128], poruka[128], adm[64], ime[128];
	if(sscanf(params, "i", slot)) return SCM(playerid, COLOR_RED, "[USAGE]: {FFFFFF}/skinipromotera [slot]");
	if(slot < 0 && slot > 19) return SCM(playerid, COLOR_RED, "[SERVER]: {FFFFFF}Slot mora biti izmedju 0 i 19!");
	format(pfile, 128, PROMPATH, slot);
	format(niko, 128, "Niko");
	if(!UzetPromSlot(slot)) return SCM(playerid, COLOR_RED, "[SERVER]: {FFFFFF}Slot nije uzet!");
	format(ime, 128, PromoterInfo[slot][promName]);
	pid = GetPlayerID(ime);
	if(pid == -1)
	{
	    format(plfile, 128, PATH, ime);
	    INI_ParseFile(plfile, "LoadUser_%s", .bExtra = true, .extra = SKIDANJEID);
	    PlayerInfo[SKIDANJEID][pPromoter] = 0;
	    PromoterInfo[slot][promName] = niko;
	    PromoterInfo[slot][promNeaktivnost] = 0;
	    Sacuvaj(SKIDANJEID, ime);
	    SavePromoter(slot);
	}
	else
	{
	    PlayerInfo[pid][pPromoter] = 0;
	    PromoterInfo[slot][promName] = niko;
	    PromoterInfo[slot][promNeaktivnost] = 0;
	    SavePlayer(pid);
	    SavePromoter(slot);
	    GetPlayerName(playerid, adm, sizeof(adm));
	    format(poruka, sizeof(poruka), "{DAA520}[PROMOTER]: {FFFFFF}Skinut vam je promoter od strane admina {DAA520}%s!", adm);
	    SCM(pid, -1, poruka);
	}
 	format(poruka, sizeof(poruka), "{DAA520}[PROMOTER]: {FFFFFF}Uspesno ste skinuli promotera sa slota {DAA520}%d{FFFFFF}! Ime: {DAA520}%s", slot, ime);
 	SCM(playerid, -1, poruka);
	return 1;
}
CMD:makepromoter(playerid, params[])
{
	if(IsPlayerAdmin(playerid) || PlayerInfo[playerid][pAdmin] > 0)
	{
	    new id, slot;
	    if(sscanf(params, "ui", id, slot)) return SCM(playerid, COLOR_RED, "[USAGE]: {FFFFFF}/makepromoter [id] [slot]");
	    else if(slot < 0 && slot > 19) return SCM(playerid, COLOR_RED, "[SERVER]: {FFFFFF}Slot mora biti izmedju 0 i 19!");
	    else if(UzetPromSlot(slot)) return SCM(playerid, COLOR_RED, "[SERVER]: {FFFFFF}Slot je vec uzet!");
	    else
	    {
	        new ime[128];
	        PlayerInfo[id][pPromoter] = 1;
	        GetPlayerName(id, ime, sizeof(ime));
	        PromoterInfo[slot][promName] = ime;
	        PromoterInfo[slot][promNeaktivnost] = 0;
	        SavePromoter(slot);
	    }
	}
	else
	{
	    SCM(playerid, COLOR_RED, "[SERVER]: {FFFFFF}Niste ovlasceni!");
	}
	return true;
}
CMD:ban(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Niste ovlasceni da koristite komandu!");
	new id, dan, razlog[128], pName[128], adm[128], poruka[256];
	if(sscanf(params, "us[128]i", id, razlog, dan)) return SCM(playerid, COLOR_RED, "[Usage]: {FFFFFF}/ban [id] [razlog] [broj dana (101-perm)]!");
	if(!IsPlayerConnected(id)) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}NIgrac nije povezan!");
	if(!((dan >= 1 && dan <= 30) || dan == 101)) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Dan mora biti izmedju 1 i 30 (101 za perma ban)!");
	GetPlayerName(id, pName, sizeof(pName));
	GetPlayerName(playerid, adm, sizeof(adm));
	if(dan >= 1 && dan <= 30)
	{
	    PlayerInfo[id][pBan] = dan;
	    format(poruka, sizeof(poruka), "Admin {DAA520}%s {FFFFFF}je banovao igraca {DAA520}%s {FFFFFF}na {DAA520}%d {FFFFFF}dana! Razlog: {DAA520}%s", adm, pName, dan, razlog);
	}
	if(dan == 101)
	{
	    PlayerInfo[id][pBan] = dan;
	    format(poruka, sizeof(poruka), "Admin {DAA520}%s {FFFFFF}je banovao igraca {DAA520}%s zauvek{FFFFFF}! Razlog: {DAA520}%s", adm, pName, razlog);
	}
	PlayerInfo[id][pBanRazlog] = razlog;
	SendClientMessageToAll(-1, poruka);
	SetTimerEx("KickPlayer", 500, false, "i", id);
	return 1;
}
CMD:napravigate(playerid, params[])
{
	new id, Float:X, Float:Y, Float:Z, i = NewID(4);
	if(PlayerInfo[playerid][pAdmin] < 6) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Niste ovlasceni da koristite komandu!");
	if(sscanf(params, "i", id)) return SCM(playerid, COLOR_RED, "[Usage]: {FFFFFF}/napravigate [id] <- id objekta!");
	if(editagate[playerid] != 0 || editing[playerid] != 0) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Vec editujete neki gate/objekat!");
	GetPlayerPos(playerid, X, Y, Z);
	gateObj[i] = CreateObject(id, X+1, Y+1, Z+1, 0.0, 0.0, 0.0, 300.0);
	editagate[playerid] = i;
	editagateid[playerid] = id;
	SCM(playerid, COLOR_RED, "{DAA520}[Server]: {FFFFFF}Poceli ste pravljenje gate-a!");
	editing[playerid] = 1;
	EditObject(playerid, gateObj[i]);
	gatefaza[playerid] = 1;
	SCM(playerid, COLOR_RED, "{DAA520}[Server]: {FFFFFF}Stavite gate tako da bude zatvoren!");
	return 1;
}

CMD:aduty(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Niste ovlasceni da koristite komandu!");
    new string[128], ime[64];
    if(pADuty[playerid] == 0)
    {
        pADuty[playerid] = 1;
        SetPlayerHealth(playerid, 250.0);
        SetPlayerArmour(playerid,100.0);
        GetPlayerName(playerid, ime, sizeof(ime));
        format(string, sizeof(string), "{DAA520}[DUTY]: {FFFFFF}Admin {DAA520}%s {FFFFFF}je sada na duznosti!", ime);
        SendClientMessageToAll(-1, string);
    }
    else
    {
        pADuty[playerid] = 0;
        SetPlayerHealth(playerid, 100);
        GetPlayerName(playerid, ime, sizeof(ime));
        format(string, sizeof(string), "{DAA520}[DUTY]: {FFFFFF}Admin {DAA520}%s {FFFFFF}vise nije na duznost!", ime);
        SendClientMessageToAll(-1, string);
    }
	return 1;
}
CMD:admini(playerid, params[])
{
	new string[3500], str[256], onl[64];
	for(new i = 0; i < MAX_ADMINS; i++)
	{
	    if(GetPlayerID(AdminInfo[i][aName]) == -1)
	    {
	        format(onl, sizeof(onl), "{8B8989}Offline");
	    }
	    else
	    {
	        format(onl, sizeof(onl), "{7FFF00}Online");
	    }
	    format(str, sizeof(str), "{DAA520}[{FFFFFF}%d{DAA520}] {FFFFFF}- Ime: {DAA520}%s {FFFFFF}| %s {FFFFFF}| Neaktivnost: {DAA520}%d{FFFFFF}min | Duty Time: {DAA520}%d{FFFFFF}min \n", i+1, AdminInfo[i][aName], onl, AdminInfo[i][aNeaktivnost], AdminInfo[i][aDuty]);
	    strcat(string, str);
	}
	SPD(playerid, DIALOG_ALIST, DIALOG_STYLE_MSGBOX, "{DAA520}Lista Admina", string, "{DAA520}Potvrdi", "");
	return 1;
}
CMD:skinilidera(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 4) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Niste ovlasceni da koristite komandu!");
    new id, orgfile[128], pid, pfile[128], niko[128], poruka[128], adm[128];
    if(sscanf(params, "i", id)) return SCM(playerid, COLOR_RED, "[USAGE]: {FFFFFF}/skinilidera [id]!");
    format(orgfile, sizeof(orgfile), ORGPATH, id);
    format(niko, sizeof(niko), "Niko");
    if(!fexist(orgfile)) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Ova organizacija ne postoji!");
    pid = GetPlayerID(OrgInfo[id][orgLeader]);
    if(pid == -1)
    {
        new ime[128];
        format(ime, sizeof(ime), OrgInfo[id][orgLeader]);
        format(pfile, sizeof(pfile), PATH, ime);
        INI_ParseFile(pfile, "LoadUser_%s", .bExtra = true, .extra = SKIDANJEID);
        PlayerInfo[SKIDANJEID][pLeader] = 0;
        OrgInfo[id][orgLeader] = niko;
        RefreshPickupLabel(id, 2);
        Sacuvaj(SKIDANJEID, ime);
        SaveOrg(id);
    }
    else
    {
        PlayerInfo[pid][pLeader] = 0;
        OrgInfo[id][orgLeader] = niko;
        GetPlayerName(playerid, adm, sizeof(adm));
        format(poruka, sizeof(poruka), "{DAA520}[Leader]: {FFFFFF}Skinut vam je lider organizacije {DAA520}%s {FFFFFF}od strane admina {DAA520}%s!", OrgInfo[id][orgIme], adm);
        RefreshPickupLabel(id, 2);
        SavePlayer(pid);
        SaveOrg(id);
    }
    format(poruka, sizeof(poruka), "{DAA520}[Server]: {FFFFFF}Uspesno ste skinuli lidera organizacije {DAA520}%s{FFFFFF}!", OrgInfo[id][orgIme]);
    SCM(playerid, -1, poruka);
	return 1;
}
CMD:changename(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Niste ovlasceni da koristite komandu!");
	new id, novoime[128], ime[128], file[128], string[128];
	if(sscanf(params, "us[128]", id, novoime)) return SCM(playerid, COLOR_RED, "[USAGE]: {FFFFFF}/changename [id] [ime]!");
	if(!IsPlayerConnected(id))  return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Igrac nije na serveru!");
	GetPlayerName(id, ime, sizeof(ime));
	format(file, sizeof(file), PATH, novoime);
	if(fexist(file)) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}To ime je vec iskorisceno!");
	format(file, sizeof(file), PATH, ime);
	SetPlayerName(id, novoime);
	SavePlayer(id);
	fremove(file);
	if(PlayerInfo[id][pKuca] != 9999)
	{
	    HouseInfo[PlayerInfo[id][pKuca]][hOwner] = novoime;
	    SaveHouse(PlayerInfo[id][pKuca]);
	    RefreshPickupLabel(PlayerInfo[id][pKuca], 1);
	}
	if(PlayerInfo[id][pLeader] != 0)
	{
	    OrgInfo[PlayerInfo[id][pLeader]][orgLeader] = novoime;
	    SaveOrg(PlayerInfo[id][pLeader]);
	    RefreshPickupLabel(PlayerInfo[id][pLeader], 2);
	}
	format(string, sizeof(string), "{DAA520}[Server]: {FFFFFF}Uspesno ste promenili ime igracu {DAA520}%s {FFFFFF}u {DAA520}%s!", ime, novoime);
	SCM(playerid, -1, string);
	return 1;
}
CMD:refresh(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Niste ovlasceni da koristite komandu!");
	new id, tip;
	if(sscanf(params, "ii", id, tip)) return SCM(playerid, COLOR_RED, "[USAGE]: {FFFFFF}/refresh [id] [tip]!");
	if(tip < 1 || tip > 2) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Tip mora biti 1 ili 2 (1 - house | 2 - org)!");
	if(tip == 1)
	{
	    if(id < 0 || id > MAX_HOUSES) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}ID nije validan!");
	    RefreshPickupLabel(id, tip);
	}
	if(tip == 2)
	{
	    if(id < 0 || id > brojorg) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}ID nije validan!");
	    RefreshPickupLabel(id, tip);
	}
	SCM(playerid, -1, "{DAA520}[Server]: {FFFFFF}Uspesno ste refresh-ovali server.");
	return 1;
}
CMD:port(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Niste ovlasceni da koristite komandu!");
	if(brojportova < 1) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Portovi jos nisu napravljeni!");
	new string[2048], text[128];
	for(new i = 1; i <= brojportova; i++)
	{
	    format(text, sizeof(text), "{DAA520}[{FFFFFF}%d{DAA520}] - {FFFFFF}%s\n", i, PortInfo[i][portIme]);
	    strcat(string, text);
	}
	ShowPlayerDialog(playerid, DIALOG_PORT, DIALOG_STYLE_LIST, "{DAA520}Port", string, "{DAA520}Izaberi", "{DAA520}Odustani");
	return 1;
}
CMD:napraviport(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Niste ovlasceni da koristite komandu!");
	new ime[128], Float:X, Float:Y, Float:Z, i = NewID(3), portfile[64];
	if(sscanf(params, "s[128]", ime)) return SCM(playerid, COLOR_RED, "[USAGE]: {FFFFFF}/napraviport [ime]");
	GetPlayerPos(playerid, X, Y, Z);
	PortInfo[i][portIme] = ime;
	PortInfo[i][portX] = X;
	PortInfo[i][portZ] = Y;
	PortInfo[i][portY] = Z;
	SavePort(i);
	SCM(playerid, -1, "{DAA520}[Server]: {FFFFFF}Uspesno ste napravili port!");
	format(portfile, sizeof(portfile), PORTPATH, i);
 	INI_ParseFile(portfile, "LoadPorts", .bExtra = true, .extra = i);
 	brojportova++;
	return 1;
}
CMD:organizacije(playerid, params[])
{
	new lista[1024], text[128];
	if(brojorg < 1) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Organizacije jos uvek nisu napravljene!");
	for(new i = 1; i <= brojorg; i++)
	{
	    format(text, sizeof(text), "{DAA520}[{FFFFFF}%d{DAA520}] - {FFFFFF}%s\n", i, OrgInfo[i][orgIme]);
	    strcat(lista, text);
	}
	ShowPlayerDialog(playerid, DIALOG_ORGLIST, DIALOG_STYLE_MSGBOX, "{DAA520}Lista Organizacija", lista, "{DAA520}Napusti", "");
	return 1;
}
CMD:lideri(playerid, params[])
{
	new lista[2048], text[128];
	if(brojorg < 1) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Organizacije jos uvek nisu napravljene!");
	for(new i = 1; i <= brojorg; i++)
	{
	    format(text, sizeof(text), "{DAA520}[{FFFFFF}%d{DAA520}] - {DAA520}Ime: {FFFFFF}%s - {DAA520}Leader: {FFFFFF}%s\n", i, OrgInfo[i][orgIme], OrgInfo[i][orgLeader]);
	    strcat(lista, text);
	}
	ShowPlayerDialog(playerid, DIALOG_ORGLEADERS, DIALOG_STYLE_MSGBOX, "{DAA520}Lista OLidera", lista, "{DAA520}Napusti", "");
	return 1;
}
CMD:makeleader(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Niste ovlasceni da koristite ovu komandu!");
	if(brojorg < 1) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Organizacije jos uvek nisu napravljene!");
	new id, orgid, ime[128], string[128];
	if(sscanf(params, "ui", id, orgid)) return SCM(playerid, COLOR_RED, "[Usage]: {FFFFFF}/makeleader [id] [orgid]");
	if(PlayerInfo[id][pLeader] != 0) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Igrac je vec lider neke organizacije!");
	if(orgid < 1 || orgid > brojorg) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Netacan ID organizacije!");
	GetPlayerName(id, ime, sizeof(ime));
	PlayerInfo[id][pLeader] = orgid;
	OrgInfo[orgid][orgLeader] = ime;
	SavePlayer(id);
	SaveOrg(orgid);
	format(string, sizeof(string), "{DAA520}[Server]: {FFFFFF}Uspesno ste postavili lidera organizacije {DAA520}%s{FFFFFF} igracu {DAA520}%s!", OrgInfo[orgid][orgIme], ime);
	SCM(playerid, -1, string);
	Delete3DTextLabel(orgLabel[orgid]);
	format(string, sizeof(string), "{DAA520}[ {FFFFFF}%s {DAA520}]\n{FFFFFF}Leader: {DAA520}%s", OrgInfo[orgid][orgIme], OrgInfo[orgid][orgLeader]);
	orgLabel[orgid] = Create3DTextLabel(string, COLOR_BLACK, OrgInfo[orgid][orgX], OrgInfo[orgid][orgY], OrgInfo[orgid][orgZ], 20.0, 0, 0);
	return 1;
}
CMD:napraviorg(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Niste ovlasceni!");
	if(editaorg[playerid] != -1) return SCM(playerid, COLOR_RED, "[Server]: {FFFFFF}Vec pravite/editujete organizaciju!");
	new Float:X, Float:Y, Float:Z, i = NewID(2), nikostring[128];
	format(nikostring, sizeof(nikostring), "Niko");
	editaorg[playerid] = i;
	OrgInfo[i][orgLeader] = nikostring;
	OrgInfo[i][orgMember1] = nikostring;
	OrgInfo[i][orgMember2] = nikostring;
	OrgInfo[i][orgMember3] = nikostring;
	OrgInfo[i][orgMember4] = nikostring;
	OrgInfo[i][orgMember5] = nikostring;
	OrgInfo[i][orgMember6] = nikostring;
	OrgInfo[i][orgMember7] = nikostring;
	OrgInfo[i][orgMember8] = nikostring;
	OrgInfo[i][orgMember9] = nikostring;
	OrgInfo[i][orgMember10] = nikostring;
	OrgInfo[i][orgMember11] = nikostring;
	OrgInfo[i][orgMember12] = nikostring;
	OrgInfo[i][orgMember13] = nikostring;
	OrgInfo[i][orgMember14] = nikostring;
	OrgInfo[i][orgMember15] = nikostring;
	OrgInfo[i][orgMember16] = nikostring;
	OrgInfo[i][orgMember17] = nikostring;
	OrgInfo[i][orgMember18] = nikostring;
	OrgInfo[i][orgMember19] = nikostring;
	OrgInfo[i][orgMember20] = nikostring;
	OrgInfo[i][orgSefMoney] = 0;
	OrgInfo[i][orgSefMats] = 0;
	OrgInfo[i][orgSefDrugs] = 0;
 	GetPlayerPos(playerid, X, Y, Z);
 	OrgInfo[i][orgX] = X;
 	OrgInfo[i][orgY] = Y;
 	OrgInfo[i][orgZ] = Z;
 	orgPickup[i] = CreatePickup(19132, 1, X, Y, Z);
 	SCM(playerid, COLOR_ORANGE, "{DAA520}[Server]: {FFFFFF}Uspesno ste zapoceli pravljenje organizacije!");
 	ShowPlayerDialog(playerid, DIALOG_ORGIME, DIALOG_STYLE_INPUT, "{DAA520}Ime organizacije", "{FFFFFF}Unesite zeljeno ime organizacije!", "Potvrdi", "Odustani");
 	brojorg++;
	return 1;
}
CMD:rtcall(playerid, params[])
{
	RespawnVozila();
	SCM(playerid, COLOR_LIGHTBLUE, "[Respawn Vozila]: {FFFFFF}Uspesno ste odradili respawn svih vozila!");
	return 1;
}
CMD:kupikucu(playerid, params[])
{
	if(PlayerInfo[playerid][pKuca] != 9999) return SCM(playerid, COLOR_RED, "[HOUSE]: {FFFFFF}Vec imate kucu!");
	new Float:X, Float:Y, Float:Z;
	for(new hid = 0; hid < MAX_HOUSES; hid++)
	{
	    X=Float:HouseInfo[hid][hX];
	    Y=Float:HouseInfo[hid][hY];
	    Z=Float:HouseInfo[hid][hZ];
	    if(IsPlayerInRangeOfPoint(playerid, 2.0, Float:X, Float:Y, Float:Z))
	    {
	        if(HouseInfo[hid][hOwned] == 1) return SCM(playerid, COLOR_RED, "[HOUSE]: {FFFFFF}Kuca je vec kupljena!");
	        if(GetPlayerMoney(playerid) < HouseInfo[hid][hCena]) return SCM(playerid, COLOR_RED, "[HOUSE]: {FFFFFF}Nemate dovoljno novca da kupite kucu!");
	        if(PlayerInfo[playerid][pLevel] < HouseInfo[hid][hLevel]) return SCM(playerid, COLOR_RED, "[HOUSE]: {FFFFFF}Niste dovoljan level!");
	        AC_GivePlayerMoney(playerid, -HouseInfo[hid][hCena]);
	        new ime[128];
	        GetPlayerName(playerid, ime, sizeof(ime));
	        PlayerInfo[playerid][pKuca] = hid;
	        HouseInfo[hid][hOwner] = ime;
	        HouseInfo[hid][hOwned] = 1;
	        Delete3DTextLabel(hLabel[hid]);
	        DestroyPickup(hPickup[hid]);
	        new string[512], str[32];
	        if(HouseInfo[hid][hTip] == 1) { format(str, sizeof(str), "Stan"); }
			if(HouseInfo[hid][hTip] == 2) { format(str, sizeof(str), "Mala Kuca"); }
			if(HouseInfo[hid][hTip] == 3) { format(str, sizeof(str), "Srednja Kuca"); }
			if(HouseInfo[hid][hTip] == 4) { format(str, sizeof(str), "Velika Kuca"); }
			if(HouseInfo[hid][hTip] == 5) { format(str, sizeof(str), "Vila"); }
		    format(string, sizeof(string), "{4682B4}Kuca na prodaju\nOwner: {FFFFFF}%s\n{4682B4}Cena: {FFFFFF}%d\n{4682B4}Level: {FFFFFF}%d\n{4682B4}Tip: {FFFFFF}%s\n{4682B4}Adresa: {FFFFFF}%d", HouseInfo[hid][hOwner], HouseInfo[hid][hCena], HouseInfo[hid][hLevel], str, hid);
		    hPickup[hid] = CreatePickup(1272, 1, HouseInfo[hid][hX], HouseInfo[hid][hY], HouseInfo[hid][hZ]);
		    hLabel[hid] = Create3DTextLabel(string, COLOR_WHITE, HouseInfo[hid][hX], HouseInfo[hid][hY], HouseInfo[hid][hZ], 10.0, 0, 0);
			SaveHouse(hid);
		    SavePlayer(playerid);
		    SCM(playerid, COLOR_LIGHTBLUE, "[HOUSE]: {FFFFFF}Uspesno ste kupili kucu! Cestitamo!");
	    }
	}
    return 1;
}
CMD:napravikucu(playerid, params[])
{
	new cena, level, tip;
	if(sscanf(params, "iii", cena, level, tip)) return SCM(playerid, COLOR_RED, "[USAGE]: {FFFFFF}/napravikucu [cena] [level] [tip]!");
	if(PlayerInfo[playerid][pAdmin] != 6) return SCM(playerid, COLOR_RED, "[HOUSE]: {FFFFFF}Niste ovlasceni da koristite ovu komandu!");
	new Float:X, Float:Y, Float:Z, i=NewID(1);
	GetPlayerPos(playerid, X, Y, Z);
	HouseInfo[i][hOwned] = 0;
	HouseInfo[i][hCena] = cena;
	HouseInfo[i][hLevel] = level;
	HouseInfo[i][hNeaktivnost] = 0;
	HouseInfo[i][hTip] = tip;
	HouseInfo[i][hX] = X;
	HouseInfo[i][hY] = Y;
	HouseInfo[i][hZ] = Z;
	HouseInfo[i][hSefNovac] = 0;
	HouseInfo[i][hSefDroga] = 0;
	new string[512], str[32];
	if(tip == 1) { format(str, sizeof(str), "Stan"); }
	if(tip == 2) { format(str, sizeof(str), "Mala Kuca"); }
	if(tip == 3) { format(str, sizeof(str), "Srednja Kuca"); }
	if(tip == 4) { format(str, sizeof(str), "Velika Kuca"); }
	if(tip == 5) { format(str, sizeof(str), "Vila"); }
	format(string, sizeof(string), "{4682B4}Kuca na prodaju\nOwner: {FFFFFF}Niko\n{4682B4}Cena: {FFFFFF}%d\n{4682B4}Level: {FFFFFF}%d\n{4682B4}Tip: {FFFFFF}%s\n{4682B4}Adresa: {FFFFFF}%d\n{4682B4}/kupikucu", HouseInfo[i][hCena], HouseInfo[i][hLevel], str, i);
    hPickup[i] = CreatePickup(1273, 1, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ]);
    hLabel[i] = Create3DTextLabel(string, COLOR_WHITE, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ], 10.0, 0, 0);
    SaveHouse(i);
    SCM(playerid, COLOR_LIGHTBLUE, "[HOUSE]: {FFFFFF}Uspesno ste napravili kucu!");
    return true;
}
CMD:napravifirmu(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] != 6) return SCM(playerid, COLOR_RED, "[HOUSE]: {FFFFFF}Niste ovlasceni da koristite ovu komandu!");
	pID[playerid] = NewID(6);
	ShowPlayerDialog(playerid, DIALOG_NAPRAVIFIRMU, DIALOG_STYLE_LIST, "{FFFFFF}Izaberite tip firme", "Mali Restoran\nVeliki Restoran\nProdavnica\nGun Shop","{FFFFFF}Izaberi", "{FFFFFF}Odustani");
    return true;
}
CMD:payday(playerid, params[])
{
	PayDay();
	return 1;
}
CMD:transfer(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 1458.5801,-972.6403,19.1646))
	{
		if(PlayerInfo[playerid][pRacun] == 1)
		{
		    new id, pare, string[128];
			if(sscanf(params, "ii", pare)) return SCM(playerid, COLOR_RED, "[USAGE]: {FFFFFF}/transfer [id] [novac]!");
			if(!IsPlayerConnected(id)) return SCM(playerid, COLOR_RED, "[BANK]: {FFFFFF}Igrac nije povezan!");
			if(pare > 100000 || pare < 5000) return SCM(playerid, COLOR_RED, "[BANK]: {FFFFFF}Ne mozete manje od $5000 i vise od $100000!");
			PlayerInfo[playerid][pBanka]-=pare;
			PlayerInfo[id][pBanka]+=pare;
			format(string, sizeof(string), "[BANK]: {FFFFFF}Uspesno ste prebacili $%d drugom igracu!", pare);
			SCM(playerid, COLOR_LIGHTBLUE, string);
		}
		else
		{
		    SCM(playerid, COLOR_RED, "[BANK]: {FFFFFF}Nemate racun u banci!");
		}
 	}
	return 1;
}
CMD:kredit(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 1458.5801,-972.6403,19.1646))
	{
		if(PlayerInfo[playerid][pRacun] == 1)
		{
		    new pare, string[128];
			if(sscanf(params, "i", pare)) return SCM(playerid, COLOR_RED, "[USAGE]: {FFFFFF}/kredit [novac]!");
			if(pare > 100000 || pare < 20000) return SCM(playerid, COLOR_RED, "[BANK]: {FFFFFF}Ne mozete manje od $20000 i vise od $100000!");
			if(PlayerInfo[playerid][pRate] > 0) return SCM(playerid, COLOR_RED, "[BANK]: {FFFFFF}Vec imate neisplacen kredit!");
			PlayerInfo[playerid][pRate] = 10;
			PlayerInfo[playerid][pKredit] = pare;
			AC_GivePlayerMoney(playerid, pare);
			format(string, sizeof(string), "[BANK]: {FFFFFF}Uspesno ste uzeli kredit od $%d!", pare);
			SCM(playerid, COLOR_LIGHTBLUE, string);
		}
		else
		{
		    SCM(playerid, COLOR_RED, "[BANK]: {FFFFFF}Nemate racun u banci!");
		}
 	}
	return 1;
}
CMD:napraviracun(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 2.0, 1456.4519,-972.4586,19.1609))
	{
		if(PlayerInfo[playerid][pRacun] == 0)
		{
	        PlayerInfo[playerid][pRacun] = 1;
	        SCM(playerid, COLOR_LIGHTBLUE, "[BANK]: {FFFFFF}Uspesno ste otvorili racun u banci!");
		}
	}
	return 1;
}
CMD:deposit(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 2.0, 1460.8018,-972.6647,19.1685))
	{
		if(PlayerInfo[playerid][pRacun] == 1)
		{
		    new pare;
			if(sscanf(params, "i", pare)) return SCM(playerid, COLOR_RED, "[USAGE]: {FFFFFF}/deposit [novac]!");
			if(pare > GetPlayerMoney(playerid)) return SCM(playerid, COLOR_RED, "[BANK]: {FFFFFF}Nemate dovoljno novca!");
			if(pare > 99999 || pare < 1) return SCM(playerid, COLOR_RED, "[BANK]: {FFFFFF}Ne mozete manje od $1 i vise od $99999!");
			AC_GivePlayerMoney(playerid, -pare);
			PlayerInfo[playerid][pBanka]+=pare;
			SCM(playerid, COLOR_LIGHTBLUE, "[BANK]: {FFFFFF}Uspesno ste prebacili novac u banku!");
		}
		else
		{
		    SCM(playerid, COLOR_RED, "[BANK]: {FFFFFF}Nemate racun u banci!");
		}
	}
	return 1;
}
CMD:podigni(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 2.0, 1463.0957,-972.5809,19.1725))
	{
		if(PlayerInfo[playerid][pRacun] == 1)
		{
		    new pare;
			if(sscanf(params, "i", pare)) return SCM(playerid, COLOR_RED, "[USAGE]: {FFFFFF}podigni [novac]!");
			if(pare > PlayerInfo[playerid][pBanka]) return SCM(playerid, COLOR_RED, "[BANK]: {FFFFFF}Nemate dovoljno novca u banci!");
			if(pare > 99999 || pare < 1) return SCM(playerid, COLOR_RED, "[BANK]: {FFFFFF}Ne mozete manje od $1 i vise od $99999!");
			AC_GivePlayerMoney(playerid, pare);
			PlayerInfo[playerid][pBanka]-=pare;
			SCM(playerid, COLOR_LIGHTBLUE, "[BANK]: {FFFFFF}Uspesno ste podigli novac iz banke!");
		}
		else
		{
		    SCM(playerid, COLOR_RED, "[BANK]: {FFFFFF}Nemate racun u banci!");
		}
	}
	return 1;
}
CMD:jp(playerid, params[])
{
	if(!IsPlayerConnected(playerid)) return SCM(playerid, COLOR_RED, "[SERVER]: {FFFFFF}Niste povezani na server!");
	if(PlayerInfo[playerid][pAdmin] < 1) return SCM(playerid, COLOR_RED, "[SERVER]: {FFFFFF}Niste ovlasceni!");
	if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_USEJETPACK)
	{
	    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
	    SCM(playerid, COLOR_AQUA, "[SERVER]: {FFFFFF}Uspesno ste uzeli jetpack!");
	}
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
	{
	    new Float:X, Float:Y, Float:Z;
	    GetPlayerPos(playerid, X, Y, Z);
	    SetPlayerPos(playerid, X, Y, Z);
	    SCM(playerid, COLOR_AQUA, "[SERVER]: {FFFFFF}Uspesno ste skinuli jetpack!");
	}
	return 1;
}
CMD:zaposlise(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 1752.7542,-1894.1619,13.5573))
	{
	    if(PlayerInfo[playerid][pPosao] == 0)
	    {
	        PlayerInfo[playerid][pPosao] = 1;
	        SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Uspesno ste se zaposlili kao bus vozac!");
	    }
	    else
	    {
	        SCM(playerid, COLOR_RED, "[POSAO]: {FFFFFF}Vec imate posao!");
	    }
	}
	else
	{
	    SCM(playerid, COLOR_RED, "[POSAO]: {FFFFFF}Niste na mestu uzimanja posla!");
	}
	return 1;
}
CMD:otkaz(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 1752.7542,-1894.1619,13.5573))
	{
	    if(PlayerInfo[playerid][pPosao] == 1)
	    {
	        PlayerInfo[playerid][pPosao] = 0;
	        SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Uspesno ste dali otkaz!");
	        jobprogress[playerid] = 0;
	        radi[playerid] = 0;
	    }
	    else
	    {
	        SCM(playerid, COLOR_RED, "[POSAO]: {FFFFFF}Nemate posao!");
	    }
	}
	else
	{
	    SCM(playerid, COLOR_RED, "[POSAO]: {FFFFFF}Niste na mestu davanja otkaza!");
	}
	return 1;
}
CMD:posao(playerid, params[])
{
	if(PlayerInfo[playerid][pPosao] == 1)
	{
		new vehid = GetPlayerVehicleID(playerid);
		if(PosaoUniforma[playerid] != 1) return SCM(playerid, COLOR_RED, "[POSAO]: {FFFFFF}Niste uzeli uniformu,prvo uzmite uniformu za posao u garderobi!");
		if(GetVehicleModel(vehid) != 431) return SCM(playerid, COLOR_RED, "[POSAO]: {FFFFFF}Niste u autobusu!");
		if(radi[playerid] != 0) return SCM(playerid, COLOR_RED, "[POSAO]: {FFFFFF}Vec radite neki posao, prvo ga prekinite!");
		SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Uspesno ste pokrenuli posao, pratite markere!");
		SetPlayerCheckpoint(playerid, 1818.7036,-1914.9390,13.4804, 5.0);
		radi[playerid] = 1;
		jobprogress[playerid] = 1;
		TogglePlayerControllable(playerid, 1);
	}
	else
	{
		SCM(playerid, COLOR_RED, "[POSAO]: {FFFFFF}Niste zaposleni kao vozac busa!");
	}
	return 1;
}
CMD:prekiniposao(playerid, params[])
{
	if(radi[playerid] == 0) return SCM(playerid, COLOR_RED, "[POSAO]: {FFFFFF}Ne radite nikakav posao!");
	SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Uspesno ste prekinuli posao!");
	DisablePlayerCheckpoint(playerid);
	radi[playerid] = 0;
	jobprogress[playerid] = 0;
	TogglePlayerControllable(playerid, 1);
	return 1;
}
CMD:exitveh(playerid, params[])
{
	RemovePlayerFromVehicle(playerid);
	ClearAnimations(playerid);
	TogglePlayerControllable(playerid, 1);
	return 1;
}
CMD:rent(playerid, params[])
{
	new vreme, cena;
	if(sscanf(params, "i", vreme)) return SCM(playerid, COLOR_RED, "[USAGE]: {FFFFFF}/rent [vreme] - minut - $20 - min 5 minuta!");
	cena=vreme*20;
	new urentu[MAX_PLAYERS] = 0;
	for(new i = 0; i < 10; i++)
	{
	    if(IsPlayerInVehicle(playerid, rent[i]))
	    {
	        urentu[playerid] = 1;
	    }
	}
	if(urentu[playerid] != 1) return SCM(playerid, COLOR_RED, "[RENT]: {FFFFFF}Niste u rent vozilu!");
	else if(vreme < 5 || vreme > 30) return SCM(playerid, COLOR_RED, "[RENT]: {FFFFFF}Ne mozete manje od 5 i vise od 30 minuta!");
	else if(GetPlayerMoney(playerid) < cena) return SCM(playerid, COLOR_RED, "[RENT]: {FFFFFF}Nemate dovoljno novca!");
	else if(renta[playerid] != -1) return SCM(playerid, COLOR_RED, "[RENT]: {FFFFFF}Vec rentate vozilo!");
	else
	{
	    new vehid = GetPlayerVehicleID(playerid), string[128];
	    rentvreme[playerid] = vreme;
	    TogglePlayerControllable(playerid, 1);
	    renta[playerid] = vehid;
	    rented[vehid] = 1;
	    AC_GivePlayerMoney(playerid, -cena);
	    format(string, sizeof(string), "[RENT]: {FFFFFF}Uspesno ste rentali vozilo na %d minuta za $%d", vreme, cena);
	    SCM(playerid, COLOR_LIGHTBLUE, string);
	}
	return 1;
}
CMD:unrent(playerid, params[])
{
	if(renta[playerid] == -1)
	{
		SCM(playerid, COLOR_RED, "[RENT]: {FFFFFF}Ne rentate vozilo!");
 	}
	else
	{
	    new vehid = renta[playerid];
	    SetVehicleToRespawn(vehid);
	    rented[vehid] = 0;
	    renta[playerid] = -1;
	    SCM(playerid, COLOR_LIGHTBLUE, "[RENT]: {FFFFFF}Uspesno ste unrentali vozilo!");
	}
	return 1;
}
CMD:nerentaj(playerid, params[])
{
 	new urentu[MAX_PLAYERS] = 0;
	for(new i = 0; i < 10; i++)
	{
	    if(IsPlayerInVehicle(playerid, rent[i]))
	    {
	        urentu[playerid] = 1;
	    }
	}
	if(urentu[playerid] == 1)
	{
	    RemovePlayerFromVehicle(playerid);
	    TogglePlayerControllable(playerid, 1);
	    SCM(playerid, COLOR_LIGHTBLUE, "[RENT]: {FFFFFF}Uspesno ste izasli iz rent vozila!");
	}
	return 1;
}

CMD:restart(playerid, params[])
{
    if(IsPlayerAdmin(playerid) || PlayerInfo[playerid][pAdmin] > 5)
	{
	    SetTimer("rst", 10000, false);
	    SendClientMessage(playerid, COLOR_RED, "SERVER-RESTART: {FFFFFF}Uspesno ste pokrenuli restartovanje servera!");
	    SendClientMessageToAll(COLOR_RED, "SERVER-RESTART: {FFFFFF}Admin je pokrenuo restartovanje servera! Server ce se restartovati za 10 sekundi!");
	}
	return 1;
}

CMD:skinipremium(playerid, params[])
{
	if(IsPlayerAdmin(playerid) || PlayerInfo[playerid][pAdmin] > 0)
	{
	    new id;
	    if(sscanf(params, "uii", id)) return SCM(playerid, COLOR_RED, "USAGE: {FFFFFF}/skinipremium [id]");
	    else
	    {
	        new ime[128];
	        PlayerInfo[id][pPremium] = 0;
	        SCM(playerid, COLOR_LIGHTBLUE, "ADMIN: {FFFFFF}Uspesno ste skinuli premium racun igracu!");
	        SCM(id, COLOR_LIGHTBLUE, "ADMIN: {FFFFFF}Vas Premium racun je istekao! Zelimo vam ugodnu igru!");
	        GetPlayerName(id, ime, 128);
	        SavePlayer(id);
	    }
	}
	else
	{
	    SCM(playerid, COLOR_RED, "SERVER: {FFFFFF}Nemate dozvolu da koristite tu komandu!");
	}
	return true;
}
CMD:dajpremium(playerid, params[])
{
	if(IsPlayerAdmin(playerid) || PlayerInfo[playerid][pAdmin] > 0)
	{
	    new id;
	    if(sscanf(params, "uii", id)) return SCM(playerid, COLOR_RED, "USAGE: {FFFFFF}/dajpremium [id]");
	    else
	    {
	        new ime[128];
	        PlayerInfo[id][pPremium] = 1;
	        SCM(playerid, COLOR_LIGHTBLUE, "ADMIN: {FFFFFF}Uspesno ste postavili premium racun!");
	        SCM(id, COLOR_LIGHTBLUE, "ADMIN: {FFFFFF}Cestitamo, postavljen vam je Premium Racun! Zelimo vam ugodnu igru!");
	        GetPlayerName(id, ime, 128);
	        SavePlayer(id);
	    }
	}
	else
	{
	    SCM(playerid, COLOR_RED, "SERVER: {FFFFFF}Nemate dozvolu da koristite tu komandu!");
	}
	return true;
}
CMD:dajadmina(playerid, params[])
{
	if(IsPlayerAdmin(playerid) || PlayerInfo[playerid][pAdmin] > 0)
	{
	    new id, lvl, slot;
	    if(sscanf(params, "uii", id, lvl, slot)) return SCM(playerid, COLOR_RED, "USAGE: {FFFFFF}/dajadmina [id] [level] [slot]");
	    else if(lvl < 1 || lvl > 1337) return SCM(playerid, COLOR_RED, "SERVER: {FFFFFF}Ne mozete lvl manji od 0 i veci od 6 (1337)");
	    else if(lvl > 6 && lvl != 1337) return SCM(playerid, COLOR_RED, "SERVER: {FFFFFF}Ne mozete lvl veci od 6 (1337)");
	    else if(slot < 1 || slot > 20) return SCM(playerid, COLOR_RED, "SERVER: {FFFFFF}Slot moze biti izmedju 1 i 20!");
	    else if(UzetSlot(slot)) return SCM(playerid, COLOR_RED, "SERVER: {FFFFFF}Slot je vec uzet!");
	    else
	    {
	        new ime[128];
	        PlayerInfo[id][pAdmin] = lvl;
	        SCM(playerid, COLOR_LIGHTBLUE, "ADMIN: {FFFFFF}Uspesno ste postavili novog admina!");
	        SCM(id, COLOR_LIGHTBLUE, "ADMIN: {FFFFFF}Cestitamo, postali ste admin! Zelimo vam ugodnu igru!");
	        GetPlayerName(id, ime, 128);
	        AdminInfo[slot-1][aName] = ime;
	        AdminInfo[slot-1][aNeaktivnost] = 0;
	        AdminInfo[slot-1][aDuty] = 0;
	        SaveAdmin(slot-1);
	        SavePlayer(id);
	    }
	}
	else
	{
	    SCM(playerid, COLOR_RED, "SERVER: {FFFFFF}Nemate dozvolu da koristite tu komandu!");
	}
	return true;
}
CMD:skiniadmina(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 6) return SCM(playerid, COLOR_RED, "[Server] {FFFFFF}Niste ovlasceni!");
    new slot, afile[128], pid, pfile[128], niko[128], poruka[128], adm[64], ime[128];
    if(sscanf(params, "i", slot)) return SCM(playerid, COLOR_RED, "[USAGE] {FFFFFF}/skiniadmina [slot]");
    if(slot < 1 || slot > 20) return SCM(playerid, COLOR_RED, "[Server] {FFFFFF}Slot moze biti izmedju 1 i 20!");
	format(afile, sizeof(afile), ADMINPATH, slot-1);
	format(niko, 128, "Niko");
	if(!strcmp(niko, AdminInfo[slot-1][aName])) return SCM(playerid, COLOR_RED, "[Server] {FFFFFF}Slot nije zauzet!");
	pid = GetPlayerID(AdminInfo[slot-1][aName]);
 	format(ime, sizeof(ime), AdminInfo[slot-1][aName]);
	if(pid == -1)
	{
	    format(pfile, sizeof(pfile), PATH, ime);
	    INI_ParseFile(pfile, "LoadUser_%s", .bExtra = true, .extra = SKIDANJEID);
	    PlayerInfo[SKIDANJEID][pAdmin] = 0;
	    AdminInfo[slot-1][aName] = niko;
	    AdminInfo[slot-1][aNeaktivnost] = 0;
	    AdminInfo[slot-1][aDuty] = 0;
	    Sacuvaj(SKIDANJEID, ime);
	    SaveAdmin(slot-1);
	}
	else
	{
	    PlayerInfo[pid][pAdmin] = 0;
	    AdminInfo[slot-1][aName] = niko;
	    AdminInfo[slot-1][aNeaktivnost] = 0;
	    AdminInfo[slot-1][aDuty] = 0;
	    SavePlayer(pid);
	    SaveAdmin(slot-1);
	    GetPlayerName(playerid, adm, sizeof(adm));
	    format(poruka, sizeof(poruka), "{DAA520}[Admin]: {FFFFFF}Skinut vam je admin od strane admina {DAA520}%s{FFFFFF}!", adm);
	    SCM(pid, -1, poruka);
	}
	format(poruka, sizeof(poruka), "{DAA520}[Admin]: {FFFFFF}Uspesno ste skinuli admina sa slota {DAA520}%d{FFFFFF}! Ime: {DAA520}%s", slot, ime);
	SCM(playerid, -1, poruka);
	return 1;
}

CMD:stats(playerid, params[])
{
	new diastr[2048], str[64];
	strcat(diastr, "{FFFFFF}====== {0066FF}STATS {FFFFFF}======\n", sizeof(diastr));
	format(str, sizeof(str), "{0066FF}Premium Racun: {FFFFFF}%d\n", PlayerInfo[playerid][pPremium]);
	strcat(diastr, str, sizeof(diastr));
 	format(str, sizeof(str), "{0066FF}Novac: {FFFFFF}%d\n", GetPlayerMoney(playerid));
	strcat(diastr, str, sizeof(diastr));
	format(str, sizeof(str), "{0066FF}Novac u banci: {FFFFFF}%d\n", PlayerInfo[playerid][pBanka]);
	strcat(diastr, str, sizeof(diastr));
	format(str, sizeof(str), "{0066FF}Level: {FFFFFF}%d\n", PlayerInfo[playerid][pLevel]);
	strcat(diastr, str, sizeof(diastr));
	format(str, sizeof(str), "{0066FF}Do plate: {FFFFFF}%dmin\n", PlayerInfo[playerid][pDoPlate]);
	strcat(diastr, str, sizeof(diastr));
	format(str, sizeof(str), "{0066FF}Respekti: {FFFFFF}%d/%dxp\n", PlayerInfo[playerid][pRespekti], PlayerInfo[playerid][pNeededRep]);
	strcat(diastr, str, sizeof(diastr));
	format(str, sizeof(str), "{0066FF}Admin: {FFFFFF}%d\n", PlayerInfo[playerid][pAdmin]);
	strcat(diastr, str, sizeof(diastr));
	format(str, sizeof(str), "{0066FF}Posao: {FFFFFF}%d\n", PlayerInfo[playerid][pPosao]);
	strcat(diastr, str, sizeof(diastr));
	format(str, sizeof(str), "{0066FF}Rate Kredita: {FFFFFF}%d\n", PlayerInfo[playerid][pRate]);
	strcat(diastr, str, sizeof(diastr));
	format(str, sizeof(str), "{0066FF}Vrednost Kredita: {FFFFFF}%d\n", PlayerInfo[playerid][pKredit]);
	strcat(diastr, str, sizeof(diastr));
	format(str, sizeof(str), "{0066FF}Adresa Kuce: {FFFFFF}%d\n", PlayerInfo[playerid][pKuca]);
	strcat(diastr, str, sizeof(diastr));
	if(PlayerInfo[playerid][pVozilo1] != 0) format(str, sizeof(str), "{0066FF}Vozilo 1: {FFFFFF}%d | %s\n", PlayerInfo[playerid][pVozilo1], ImenaVozila[GetVehicleModel(PlayerInfo[playerid][pVozilo1])-400]);
	else format(str, sizeof(str), "{0066FF}Vozilo 1: {FFFFFF}Nemate\n");
	strcat(diastr, str, sizeof(diastr));
	if(PlayerInfo[playerid][pVozilo2] != 0) format(str, sizeof(str), "{0066FF}Vozilo 2: {FFFFFF}%d | %s\n", PlayerInfo[playerid][pVozilo2], ImenaVozila[GetVehicleModel(PlayerInfo[playerid][pVozilo2])-400]);
	else format(str, sizeof(str), "{0066FF}Vozilo 2: {FFFFFF}Nemate\n");
	strcat(diastr, str, sizeof(diastr));
	if(PlayerInfo[playerid][pVozilo3] != 0) format(str, sizeof(str), "{0066FF}Vozilo 3: {FFFFFF}%d | %s\n", PlayerInfo[playerid][pVozilo3], ImenaVozila[GetVehicleModel(PlayerInfo[playerid][pVozilo3])-400]);
	else format(str, sizeof(str), "{0066FF}Vozilo 3: {FFFFFF}Nemate\n");
	strcat(diastr, str, sizeof(diastr));
	if(PlayerInfo[playerid][pVozilo4] != 0) format(str, sizeof(str), "{0066FF}Vozilo 4: {FFFFFF}%d | %s\n", PlayerInfo[playerid][pVozilo4], ImenaVozila[GetVehicleModel(PlayerInfo[playerid][pVozilo4])-400]);
	else format(str, sizeof(str), "{0066FF}Vozilo 4: {FFFFFF}Nemate\n");
	strcat(diastr, str, sizeof(diastr));
	if(PlayerInfo[playerid][pVozilo5] != 0) format(str, sizeof(str), "{0066FF}Vozilo 5: {FFFFFF}%d | %s\n", PlayerInfo[playerid][pVozilo5], ImenaVozila[GetVehicleModel(PlayerInfo[playerid][pVozilo5])-400]);
	else format(str, sizeof(str), "{0066FF}Vozilo 5: {FFFFFF}Nemate\n");
	strcat(diastr, str, sizeof(diastr));
	ShowPlayerDialog(playerid, DIALOG_STATS, DIALOG_STYLE_MSGBOX, "{0066FF}Stats", diastr, "{0066FF}OK", "");
	return 1;
}

CMD:kupipasos(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 3.0, 362.1759,173.6288,1008.3828))
	{
	    if(PlayerInfo[playerid][pPasos] == 0)
	    {
	        AC_GivePlayerMoney(playerid, -1000);
	        PlayerInfo[playerid][pPasos] = 1;
	        SCM(playerid, COLOR_LIGHTBLUE, "SERVER: {FFFFFF}Kupili ste pasos za $1000!");
	    }
	    else
	    {
	        SCM(playerid, COLOR_RED, "SERVER: {FFFFFF}Vec imate pasos!");
	    }
	}
	return 1;
}

CMD:kick(playerid, params[])
{
	new id, string[256], razlog[64], pName[MAX_PLAYER_NAME], pKickName[MAX_PLAYER_NAME];
	if(PlayerInfo[playerid][pAdmin] < 1) return SCM(playerid, -1, "Niste admin!");
	if(sscanf(params, "is", id, razlog)) return SCM(playerid, -1, "Komanda: /kick [id] [razlog]");
	if(!IsPlayerConnected(id)) return SCM(playerid, -1, "Igrac nije povezan na server!");
	if(PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) return SCM(playerid, -1, "Ne mozete admina veceg od sebe!");
	GetPlayerName(playerid, pName, sizeof(pName));
	GetPlayerName(id, pKickName, sizeof(pKickName));
	format(string, sizeof(string), "Igrac %s je kickovan od strane admina %s, razlog: %s", pName, pKickName, razlog);
	SendClientMessageToAll(-1, string);
	Kick(id);
	return 1;
}

CMD:uniforma(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1752.8622,-1902.9866,13.5631)) return SendClientMessage(playerid, COLOR_RED, "[POSAO]: {FFFFFF}Niste u garderobi!");
    if(PlayerInfo[playerid][pPosao] == 0) return SendClientMessage(playerid, COLOR_RED, "[POSAO]: {FFFFFF}Nemate posao!");
	if(PlayerInfo[playerid][pPosao] == 1)
	{
		if(PosaoUniforma[playerid] == 0)
	    {
            SetPlayerSkin(playerid, 61);
			SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Uzeli ste uniformu za posao, da je skinte kucajte ponovo /uniforma!");
			PosaoUniforma[playerid] = 1;
		}
		else
		{
			SetPlayerSkin(playerid, GetPVarInt(playerid, "Char"));
			SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Skinuli ste uniformu za posao, da je uzmete kucajte ponovo /uniforma!");
			PosaoUniforma[playerid] = 0;
		}
	}
	return 1;
}

CMD:engine(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid))
	{
	    new vehid = GetPlayerVehicleID(playerid);
	    if(VehInfo[vehid][vEngine] == 0)
	    {
	        VehInfo[vehid][vEngine] = 1;
            SetVehicleParamsEx(vehid, 1, VehInfo[vehid][vEngine], VehInfo[vehid][vLights], VehInfo[vehid][vAlarm], VehInfo[vehid][vDoor], VehInfo[vehid][vBonnet], VehInfo[vehid][vObj]);
            SCM(playerid, COLOR_LIGHTBLUE, "[SERVER]: {FFFFFF}Uspesno ste upalili motor!");
	    }
	    else
	    {
	        VehInfo[vehid][vEngine] = 0;
            SetVehicleParamsEx(vehid, 0, VehInfo[vehid][vEngine], VehInfo[vehid][vLights], VehInfo[vehid][vAlarm], VehInfo[vehid][vDoor], VehInfo[vehid][vBonnet], VehInfo[vehid][vObj]);
            SCM(playerid, COLOR_LIGHTBLUE, "[SERVER]: {FFFFFF}Uspesno ste ugasili motor!");
	    }
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	PlayerTextDrawHide(playerid, Speedometer0[playerid]);
	PlayerTextDrawHide(playerid, Speedometer1[playerid]);
	PlayerTextDrawHide(playerid, Speedometer2[playerid]);
	PlayerTextDrawHide(playerid, Speedometer3[playerid]);
	PlayerTextDrawHide(playerid, Speedometer4[playerid]);
	PlayerTextDrawHide(playerid, Speedometer5[playerid]);
	PlayerTextDrawHide(playerid, Speedometer6[playerid]);
	PlayerTextDrawHide(playerid, Speedometer7[playerid]);
	PlayerTextDrawHide(playerid, Speedometer8[playerid]);
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
    VehInfo[vehicleid][vEngine] = 0;
	VehInfo[vehicleid][vLights] = 0;
	VehInfo[vehicleid][vAlarm] = 0;
	VehInfo[vehicleid][vDoor] = 0;
	VehInfo[vehicleid][vBonnet] = 0;
	VehInfo[vehicleid][vObj] = 0;
	SetVehicleParamsEx(vehicleid, 0, VehInfo[vehicleid][vEngine], VehInfo[vehicleid][vLights], VehInfo[vehicleid][vAlarm], VehInfo[vehicleid][vDoor], VehInfo[vehicleid][vBonnet], VehInfo[vehicleid][vObj]);
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	if(Indicators[vehicleid][2]) DestroyObject(Indicators[vehicleid][2]), DestroyObject(Indicators[vehicleid][3]), DestroyObject(Indicators[vehicleid][5]), Indicators[vehicleid][2] = 0;
	if(Indicators[vehicleid][0]) DestroyObject(Indicators[vehicleid][0]), DestroyObject(Indicators[vehicleid][1]), DestroyObject(Indicators[vehicleid][4]), Indicators[vehicleid][0] = 0;
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(!strcmp(text, nagradnaPoruka))
	{
	    if(igraTraje == 1)
	    {
	        new str[128], pName[64];
	        GetPlayerName(playerid, pName, sizeof(pName));
	        igraTraje = 0;
	        PlayerInfo[playerid][pNagradniPoeni]++;
	        AC_GivePlayerMoney(playerid, 1000);
	        format(str, sizeof(str), "{DAA520}Nagradna igra: {FFFFFF}%s je prvi uneo %s i dobio $1000 i nagradni poen!", pName, nagradnaPoruka);
	        SCMTA(COLOR_RED, str);
	    }
	}
	new str[256], pName[MAX_PLAYER_NAME + 1];
	GetPlayerName(playerid, pName, sizeof(pName));
	format(str, sizeof(str), "{0066FF}%s {FFFFFF}kaze: %s", pName, text);
	SendMes(20.0, playerid, COLOR_RED, str);
	return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	for(new i = 0; i < 2; i++)
	{
		if(vehicleid == adminveh[i] && !ispassenger)
		{
		    if(PlayerInfo[playerid][pAdmin] < 1)
		    {
		        ClearAnimations(playerid);
		        SendClientMessage(playerid, -1, "Ne mozete to niste admin!");
		    }
		}
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
	{

		new str[128];
		format(str, 128, "");
		if(VoziloInfo[GetPlayerVehicleID(playerid)][vOwnable] == 1 && !strcmp(VoziloInfo[GetPlayerVehicleID(playerid)][vOwner], str))
		{
			new string[256], i = GetPlayerVehicleID(playerid), modelid = GetVehicleModel(i);
			if(VoziloInfo[i][vDozvola] == 1) { format(str, 128, "A Kategorija"); }
			if(VoziloInfo[i][vDozvola] == 2) { format(str, 128, "B Kategorija"); }
			if(VoziloInfo[i][vDozvola] == 3) { format(str, 128, "C Kategorija"); }
			if(VoziloInfo[i][vDozvola] == 4) { format(str, 128, "D Kategorija"); }
			if(VoziloInfo[i][vDozvola] == 5) { format(str, 128, "F Kategorija"); }
			format(string, 256, "{FFFFFF}Da li zelite da kupite vozilo?\nMarka: {DAA520}%s\n{FFFFFF}Cena: {DAA520}$%d\n{FFFFFF}Dozvola: {DAA520}%s", ImenaVozila[modelid-400], VoziloInfo[i][vCena], str);
			ShowPlayerDialog(playerid, DIALOG_KUPIVOZILO, DIALOG_STYLE_MSGBOX, "{FFFFFF}Kupovina vozila", string, "{DAA520}Kupi", "{DAA520}Odustani");
			TogglePlayerControllable(playerid, 0);
			return 1;
		}
	    PlayerTextDrawShow(playerid, Speedometer0[playerid]);
	    PlayerTextDrawShow(playerid, Speedometer1[playerid]);
	    PlayerTextDrawShow(playerid, Speedometer2[playerid]);
	    PlayerTextDrawShow(playerid, Speedometer3[playerid]);
	    PlayerTextDrawShow(playerid, Speedometer4[playerid]);
	    PlayerTextDrawShow(playerid, Speedometer5[playerid]);
	    PlayerTextDrawShow(playerid, Speedometer6[playerid]);
	    PlayerTextDrawShow(playerid, Speedometer7[playerid]);
	    PlayerTextDrawShow(playerid, Speedometer8[playerid]);
	    new vehid = GetPlayerVehicleID(playerid);
	    if(VehInfo[vehid][vEngine] == 0)
	    {
	        SCM(playerid, COLOR_LIGHTBLUE, "[SERVER]: {FFFFFF}Ako zelite da upalite motor pritisnite 2 ili ukucajte /engine!");
	    }
	    if(vehid == rent[0] || vehid == rent[1] || vehid == rent[2] || vehid == rent[3] || vehid == rent[4] || vehid == rent[5] || vehid == rent[6] || vehid == rent[7] || vehid == rent[8] || vehid == rent[9])
	    {
	        if(renta[playerid] != -1)
	        {
	            if(vehid != renta[playerid])
	            {
	                RemovePlayerFromVehicle(playerid);
	                SCM(playerid, COLOR_RED, "[RENT]: {FFFFFF}Ovo vozilo nije vas rent!");
	            }
	        }
	        else
	        {
	        	if(rented[vehid] == 1)
	            {  
	                RemovePlayerFromVehicle(playerid);
	                SCM(playerid, COLOR_RED, "[RENT]: {FFFFFF}Ovo vozilo je rentano");
	            }
	            else
	            {
	                TogglePlayerControllable(playerid, 0);
	                SCM(playerid, COLOR_LIGHTBLUE, "[RENT]: {FFFFFF}Ako zelite da rentate vozilo /rent! Ako zelite da izadjete /nerentaj!");
	            }
	        }
	    }
	}
	if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT)
	{
		PlayerTextDrawHide(playerid, Speedometer0[playerid]);
		PlayerTextDrawHide(playerid, Speedometer1[playerid]);
		PlayerTextDrawHide(playerid, Speedometer2[playerid]);
		PlayerTextDrawHide(playerid, Speedometer3[playerid]);
		PlayerTextDrawHide(playerid, Speedometer4[playerid]);
		PlayerTextDrawHide(playerid, Speedometer5[playerid]);
		PlayerTextDrawHide(playerid, Speedometer6[playerid]);
		PlayerTextDrawHide(playerid, Speedometer7[playerid]);
		PlayerTextDrawHide(playerid, Speedometer8[playerid]);
   	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(PlayerInfo[playerid][pPosao] == 1)
	{
	    new vehid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehid) == 431)
		{
		    DisablePlayerCheckpoint(playerid);
		    SetTimer("bustimer", 1000, false);
			jobprogress[playerid]++;
			SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Sacekajte da se putnici ukrcaju/iskrcaju!");
			TogglePlayerControllable(playerid, 0);
		}
	}
	DisablePlayerCheckpoint(playerid);
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_SECONDARY_ATTACK)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, 1481.1208,-1771.8009,18.7958)) //OPSTINA
	    {
	        SetPlayerInterior(playerid, 3);
	        SetPlayerPos(playerid, 384.808624,173.804992,1008.382812);
	        SetPlayerFacingAngle(playerid, 90);
	        SetCameraBehindPlayer(playerid);
	        InteriorTimer(playerid);
	    }
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, 384.808624,173.804992,1008.382812))
	    {
	        SetPlayerInterior(playerid, 0);
	        SetPlayerPos(playerid, 1481.1208,-1771.8009,18.7958);
	        SetPlayerFacingAngle(playerid, 0);
	        SetCameraBehindPlayer(playerid);
	        InteriorTimer(playerid);
	    }
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, 1467.2875,-1010.2311,26.8438)) //BANKA
	    {
	        SetPlayerInterior(playerid, 3);
	        SetPlayerPos(playerid, 1466.1982,-1004.7651,16.2557);
	        SetPlayerFacingAngle(playerid, 0);
	        SetCameraBehindPlayer(playerid);
	        InteriorTimer(playerid);
	    }
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, 1466.1982,-1004.7651,16.2557)) 
	    {
	        SetPlayerInterior(playerid, 0);
	        SetPlayerPos(playerid, 1467.2875,-1010.2311,26.8438);
	        SetPlayerFacingAngle(playerid, 180);
	        SetCameraBehindPlayer(playerid);
	        InteriorTimer(playerid);
	    }
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, 245.23,304.76,999.14) || IsPlayerInRangeOfPoint(playerid, 3.0, 2282.97,-1140.28,1050.89) || IsPlayerInRangeOfPoint(playerid, 3.0, 2365.10,-1133.07,1050.87) || IsPlayerInRangeOfPoint(playerid, 3.0, 2319.12,-1023.95,1050.21) || IsPlayerInRangeOfPoint(playerid, 3.0, 2324.38,-1148.48,1050.71))
	    {
	    	new i = GetPlayerVirtualWorld(playerid);
	    	SetPlayerPos(playerid, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ]);
	    	SetPlayerInterior(playerid, 0);
	    	InteriorTimer(playerid);
	    	SetPlayerVirtualWorld(playerid, 0);
	    }
	    for(new i = 0; i < MAX_HOUSES; i++)
	    {
	    	if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ]))
	    	{
	    		if(PlayerInfo[playerid][pKuca] == i)
	    		{
	    			if(HouseInfo[i][hTip] == 1)
	    			{
	    				SetPlayerPos(playerid, 245.23,304.76,999.14);
	    				SetPlayerInterior(playerid, 1);
	    				InteriorTimer(playerid);
	    			}
	    			if(HouseInfo[i][hTip] == 2)
	    			{
	    				SetPlayerPos(playerid, 2282.97,-1140.28,1050.89);
	    				SetPlayerInterior(playerid, 11);
	    				InteriorTimer(playerid);
	    			}
	    			if(HouseInfo[i][hTip] == 3)
	    			{
	    				SetPlayerPos(playerid, 2365.10,-1133.07,1050.87);
	    				SetPlayerInterior(playerid, 8);
	    				InteriorTimer(playerid);
	    			}
	    			if(HouseInfo[i][hTip] == 4)
	    			{
	    				SetPlayerPos(playerid, 2319.12,-1023.95,1050.21);
	    				SetPlayerInterior(playerid, 9);
	    				InteriorTimer(playerid);
	    			}
	    			if(HouseInfo[i][hTip] == 5)
	    			{
	    				SetPlayerPos(playerid, 2324.38,-1148.48,1050.71);
	    				SetPlayerInterior(playerid, 12);
	    				InteriorTimer(playerid);
	    			}
	    			SetPlayerVirtualWorld(playerid, i);
	    		}
	    		else
	    		{
	    			if(HouseInfo[i][hZakljucana] != 1 || PlayerInfo[playerid][pAdmin] > 0)
	    			{
	    				if(HouseInfo[i][hTip] == 1)
		    			{
		    				SetPlayerPos(playerid, 245.23,304.76,999.14);
		    				SetPlayerInterior(playerid, 1);
		    				InteriorTimer(playerid);
		    			}
		    			if(HouseInfo[i][hTip] == 2)
		    			{
		    				SetPlayerPos(playerid, 2282.97,-1140.28,1050.89);
		    				SetPlayerInterior(playerid, 11);
		    				InteriorTimer(playerid);
		    			}
		    			if(HouseInfo[i][hTip] == 3)
		    			{
		    				SetPlayerPos(playerid, 2365.10,-1133.07,1050.87);
		    				SetPlayerInterior(playerid, 8);
		    				InteriorTimer(playerid);
		    			}
		    			if(HouseInfo[i][hTip] == 4)
		    			{
		    				SetPlayerPos(playerid, 2319.12,-1023.95,1050.21);
		    				SetPlayerInterior(playerid, 9);
		    				InteriorTimer(playerid);
		    			}
		    			if(HouseInfo[i][hTip] == 5)
		    			{
		    				SetPlayerPos(playerid, 2324.38,-1148.48,1050.71);
		    				SetPlayerInterior(playerid, 12);
		    				InteriorTimer(playerid);
		    			}
		    			SetPlayerVirtualWorld(playerid, i);
	    			}
	    		}
	    	}
	    }
	}
	if(newkeys & KEY_LOOK_BEHIND)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        new vehid = GetPlayerVehicleID(playerid);
	        if(VehInfo[vehid][vEngine] == 0)
	        {
	            SetTimer("UpaliAuto", 3000, false);
	            GameTextForPlayer(playerid, "Motor se pali...", 3000, 3);
	            TogglePlayerControllable(playerid, 0);
	        }
	        
	        
            //VehInfo[vehid][vEngine] = 1;
            //SetVehicleParamsEx(vehid, 1, VehInfo[vehid][vEngine], VehInfo[vehid][vLights], VehInfo[vehid][vAlarm], VehInfo[vehid][vDoor], VehInfo[vehid][vBonnet], VehInfo[vehid][vObj]);
	    }
	}
	if(newkeys & KEY_CROUCH)
	{
	    for(new i = 0; i < MAX_GATES; i++)
	    {
		    if(IsPlayerInRangeOfPoint(playerid, 13.0, GateInfo[i][gX], GateInfo[i][gY], GateInfo[i][gZ]))
		    {
				OtvoriGate(i);
				SCM(playerid, -1, "{DAA520}Otvorili ste gate!");
				break;
		    }
	    }
	}
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == 2)
	{
		if(!IsAPlane(GetPlayerVehicleID(playerid)) && !IsABoat(GetPlayerVehicleID(playerid)))
		{
			new vid = GetPlayerVehicleID(playerid);
			if(newkeys & ( KEY_LOOK_LEFT ) && newkeys & ( KEY_LOOK_RIGHT ))
			{
				if(Indicators[vid][2]) DestroyObject(Indicators[vid][2]), DestroyObject(Indicators[vid][3]), DestroyObject(Indicators[vid][5]), Indicators[vid][2] = 0;
				else if (Indicators[vid][0]) DestroyObject(Indicators[vid][0]), DestroyObject(Indicators[vid][1]), DestroyObject(Indicators[vid][4]), Indicators[vid][0] = 0;
				else
				SetVehicleIndicator(vid, 1, 1);
				return 1;
			}
			if(newkeys & KEY_LOOK_RIGHT)
			{
				if(Indicators[vid][0]) DestroyObject(Indicators[vid][0]), DestroyObject(Indicators[vid][1]), DestroyObject(Indicators[vid][4]), Indicators[vid][0] = 0;
				else if (Indicators[vid][2]) DestroyObject(Indicators[vid][2]), DestroyObject(Indicators[vid][3]), DestroyObject(Indicators[vid][5]), Indicators[vid][2] = 0;
				else
				SetVehicleIndicator(vid, 0, 1);
				return 1;
			}
			if(newkeys & KEY_LOOK_LEFT)
			{
				if(Indicators[vid][2]) DestroyObject(Indicators[vid][2]), DestroyObject(Indicators[vid][3]), DestroyObject(Indicators[vid][5]), Indicators[vid][2] = 0;
				else if (Indicators[vid][0]) DestroyObject(Indicators[vid][0]), DestroyObject(Indicators[vid][1]), DestroyObject(Indicators[vid][4]), Indicators[vid][0] = 0;
				else
				SetVehicleIndicator(vid, 1, 0);
				return 1;
			}
		}
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	new Float:X, Float:Y, Float:Z;
	if(sneg[playerid] == 1)
 	{
 	    GetPlayerCameraPos(playerid, X, Y, Z);
 	    MovePlayerObject(playerid,snegobj[playerid], X-0.5, Y+0.5, Z-5.5, 4000.0, 10, 10, 10);
 	}
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_GPS:
		{
			if(response)
			{
				new id = listitem+1, string[128];
				SetPlayerCheckpoint(playerid, GPSInfo[id][gpsX], GPSInfo[id][gpsY], GPSInfo[id][gpsZ], 2.0);
				format(string, 128, "{DAA520}[GPS]: {FFFFFF}Uspesno ste postavili GPS na lokaciju {DAA520}%s!", GPSInfo[id][gpsIme]);
				SendClientMessage(playerid, -1, string);
			}
		}
		case DIALOG_HOUSE:
		{
			if(response)
			{
				new i = PlayerInfo[playerid][pKuca];
				if(listitem == 0)
				{
					new string[256];
					format(string, sizeof(string), "{FFFFFF}Adresa kuce: {DAA520}%d\n{FFFFFF}Cena kuce {DAA520}$%d\n{FFFFFF}Level kuce {DAA520}%d\n{FFFFFF}Novac u sefu {DAA520}$%d\n{FFFFFF}Droga u sefu {DAA520}%dg", i, HouseInfo[i][hCena], HouseInfo[i][hLevel], HouseInfo[i][hSefNovac], HouseInfo[i][hSefDroga]);
					ShowPlayerDialog(playerid, DIALOG_HOUSEINFO, DIALOG_STYLE_MSGBOX, "{DAA520}Informacije o kuci", string, "{DAA520}U redu", "");
				}
				if(listitem == 1)
				{
					SetPlayerCheckpoint(playerid, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ], 2.0);
					SCM(playerid, -1, "{DAA520}[House]: {FFFFFF}Uspesno ste locirali kucu!");
				}
				if(listitem == 2)
				{
					if(HouseInfo[i][hZakljucana] == 1) { HouseInfo[i][hZakljucana] = 0; GameTextForPlayer(playerid, "~g~Uspesno ste otkljucali kucu!", 3000, 3); }
					else { HouseInfo[i][hZakljucana] = 1; GameTextForPlayer(playerid, "~r~Uspesno ste zakljucali kucu!", 3000, 3); }
				}
				if(listitem == 3)
				{
					new string[128];
					format(string, 128, "{FFFFFF}Zelite li da prodate kucu drzavi?\nCena: {DAA520}$%d", ((HouseInfo[i][hCena]/4)*3));
					ShowPlayerDialog(playerid, DIALOG_HOUSEPRODAJ, DIALOG_STYLE_MSGBOX, "{DAA520}Prodaja kuce drzavi", string, "{DAA520}Prodaj", "{DAA520}Odustani");
				}
				if(listitem == 4)
				{
					SCM(playerid, -1, "{DAA520}[House]: {FFFFFF}Komanda: /prodajkucu [id igraca] [cena]!");
				}
				if(listitem == 5)
				{
					new string[128];
					format(string, 128, "{DAA520}[House]: {FFFFFF}Novac u sefu: {DAA520}$%d {FFFFFF}| Droga u sefu: {DAA520}%dg", HouseInfo[i][hSefNovac], HouseInfo[i][hSefDroga]);
					SCM(playerid, -1, string);
					SCM(playerid, -1, "{DAA520}[House]: {FFFFFF}Komande: /sefuzmi [novac/droga] [kolicina] | /sefostavi [novac/droga] [kolicina]!");
				}
				if(listitem == 6)
				{
					ShowPlayerDialog(playerid, DIALOG_HOUSERENT, DIALOG_STYLE_MSGBOX, "{DAA520}Rentiranje sobe", "{FFFFFF}Da li zelite da iznajmljujete sobu?", "{DAA520}Da", "{DAA520}Ne");
				}
				if(listitem == 7)
				{
					ShowPlayerDialog(playerid, DIALOG_HOUSERENTC, DIALOG_STYLE_INPUT, "{DAA520}Rentiranje sobe", "{FFFFFF}Unesite cenu rentiranja sobe?", "{DAA520}Potvrdi", "{DAA520}Odustani");
				}
			}
		}
		case DIALOG_HOUSEPRODAJ:
		{
			if(response)
			{
				SCM(playerid, -1, "{DAA520}[House]: {FFFFFF}Uspesno ste prodali kucu drzavi!");
				AC_GivePlayerMoney(playerid, ((HouseInfo[PlayerInfo[playerid][pKuca]][hCena]/4)*3));
				format(HouseInfo[PlayerInfo[playerid][pKuca]][hOwner], 128, "");
				HouseInfo[PlayerInfo[playerid][pKuca]][hOwned] = 0;
				SaveHouse(PlayerInfo[playerid][pKuca]);
				RefreshPickupLabel(PlayerInfo[playerid][pKuca], 1);
				PlayerInfo[playerid][pKuca] = 9999;
				SavePlayer(playerid);
			}
		}
		case DIALOG_RADIO:
		{
			if(response)
			{
				if(listitem == 0) { PlayAudioStreamForPlayer(playerid, "https://naxi128.streaming.rs:9152/;*.mp3", 0.0, 0.0, 0.0, 1.0, 0); SendClientMessage(playerid, -1, "{DAA520}[Radio]: {FFFFFF}Uspesno ste pustili {DAA520}Naxi Radio{FFFFFF}!"); }
				if(listitem == 1) { PlayAudioStreamForPlayer(playerid, "https://edge9.pink.rs/rockstream", 0.0, 0.0, 0.0, 1.0, 0); SendClientMessage(playerid, -1, "{DAA520}[Radio]: {FFFFFF}Uspesno ste pustili {DAA520}Rock Radio{FFFFFF}!"); }
				if(listitem == 2) { PlayAudioStreamForPlayer(playerid, "https://stream.playradio.rs:8443/play.mp3", 0.0, 0.0, 0.0, 1.0, 0); SendClientMessage(playerid, -1, "{DAA520}[Radio]: {FFFFFF}Uspesno ste pustili {DAA520}Play Radio{FFFFFF}!");}
				if(listitem == 3) { PlayAudioStreamForPlayer(playerid, "https://streaming.karolina.rs/karolina.mp3", 0.0, 0.0, 0.0, 1.0, 0); SendClientMessage(playerid, -1, "{DAA520}[Radio]: {FFFFFF}Uspesno ste pustili {DAA520}Radio Karolina{FFFFFF}!"); }
				if(listitem == 4) { PlayAudioStreamForPlayer(playerid, "https://e3.radiomorava.rs/radio/8000/radiomorava128.mp3", 0.0, 0.0, 0.0, 1.0, 0); SendClientMessage(playerid, -1, "{DAA520}[Radio]: {FFFFFF}Uspesno ste pustili {DAA520}Radio Morava{FFFFFF}!"); }
				if(listitem == 5) { StopAudioStreamForPlayer(playerid); SendClientMessage(playerid, -1, "{DAA520}[Radio]: {FFFFFF}Uspesno ste ugasili radio!");}
			}
		}
		case DIALOG_NAPRAVIFIRMU:
		{
			if(!response) return SendClientMessage(playerid, COLOR_RED, "[Firma]: {FFFFFF}Odustali ste od pravljenja firme!");
			else
			{
				FirmaInfo[pID[playerid]][fiTip] = listitem;
				ShowPlayerDialog(playerid, DIALOG_CENAFIRME, DIALOG_STYLE_INPUT, "{FFFFFF}Cena firme", "{FFFFFF}Napisite cenu firme:", "{FFFFFF}Potvrdi", "{FFFFFF}Odustani");
			}
		}
		case DIALOG_CENAFIRME:
		{
			if(!response) return SendClientMessage(playerid, COLOR_RED, "[Firma]: {FFFFFF}Odustali ste od pravljenja firme!");
			else
			{
				FirmaInfo[pID[playerid]][fiCena] = strval(inputtext);
				ShowPlayerDialog(playerid, DIALOG_LEVELFIRME, DIALOG_STYLE_INPUT, "{FFFFFF}Level firme", "{FFFFFF}Napisite level potreban da se kupi firma:", "{FFFFFF}Potvrdi", "{FFFFFF}Odustani");
			}
		}
		case DIALOG_LEVELFIRME:
		{
			if(!response) return SendClientMessage(playerid, COLOR_RED, "[Firma]: {FFFFFF}Odustali ste od pravljenja firme!");
			else
			{
				FirmaInfo[pID[playerid]][fiLevel] = strval(inputtext);
				new Float:X, Float:Y, Float:Z;
				GetPlayerPos(playerid, X, Y, Z);
				FirmaInfo[pID[playerid]][fiOwned] = 0;
				FirmaInfo[pID[playerid]][fiNeaktivnost] = 0;
				FirmaInfo[pID[playerid]][fiX] = X;
				FirmaInfo[pID[playerid]][fiY] = Y;
				FirmaInfo[pID[playerid]][fiZ] = Z;
				FirmaInfo[pID[playerid]][fiKasa] = 0;
				FirmaInfo[pID[playerid]][fiZalihe] = 100;
				new str[32], string[512];
	        	if(FirmaInfo[pID[playerid]][fiTip] == 0) { format(str, sizeof(str), "Mali Restoran"); }
	        	else if(FirmaInfo[pID[playerid]][fiTip] == 1) { format(str, sizeof(str), "Veliki Restoran"); }
				else if(FirmaInfo[pID[playerid]][fiTip] == 2) { format(str, sizeof(str), "Prodavnica"); }
				else if(FirmaInfo[pID[playerid]][fiTip] == 3) { format(str, sizeof(str), "Gun Shop"); }
				else { format(str, sizeof(str), "Nepoznato"); }
			    format(string, sizeof(string), "{4682B4}Firma na prodaju\nOwner: {FFFFFF}Niko\n{4682B4}Cena: {FFFFFF}$%d\n{4682B4}Level: {FFFFFF}%d\n{4682B4}Tip: {FFFFFF}%s\n{4682B4}Adresa: {FFFFFF}%d\n{4682B4}/kupifirmu", FirmaInfo[pID[playerid]][fiCena], FirmaInfo[pID[playerid]][fiLevel], str, pID[playerid]);
			    fiPickup[pID[playerid]] = CreatePickup(1274, 1, FirmaInfo[pID[playerid]][fiX], FirmaInfo[pID[playerid]][fiY], FirmaInfo[pID[playerid]][fiZ]);
			    fiLabel[pID[playerid]] = Create3DTextLabel(string, COLOR_WHITE, FirmaInfo[pID[playerid]][fiX], FirmaInfo[pID[playerid]][fiY], FirmaInfo[pID[playerid]][fiZ], 10.0, 0, 0);
			    SaveFirma(pID[playerid]);
			    SCM(playerid, COLOR_LIGHTBLUE, "{DAA520}[Firma]: {FFFFFF}Uspesno ste napravili firmu!");
			}
		}
		case DIALOG_KUPIVOZILO:
	    {
	        if(!response)
	        {
	        	SCM(playerid, COLOR_RED, "[Kupovina vozila]: {FFFFFF}Odustali ste od kupovine vozila!");
	        	RemovePlayerFromVehicle(playerid);
	        	SetCameraBehindPlayer(playerid);
	        	TogglePlayerControllable(playerid, 1);
	        }
	        else
	        {
	        	new i = GetPlayerVehicleID(playerid), string[160];
	        	if(PlayerInfo[playerid][pLevel] < 3) { SCM(playerid, COLOR_RED, "[Kupovina vozila]: {FFFFFF}Morate biti bar level 3!"); RemovePlayerFromVehicle(playerid); SetCameraBehindPlayer(playerid); return TogglePlayerControllable(playerid, 1); }
	        	if(VoziloInfo[i][vCena] > GetPlayerMoney(playerid)) { SCM(playerid, COLOR_RED, "[Kupovina vozila]: {FFFFFF}Nemate dovoljno novca kod sebe!"); RemovePlayerFromVehicle(playerid); SetCameraBehindPlayer(playerid); return TogglePlayerControllable(playerid, 1); }
	        	if(PlayerInfo[playerid][pVozilo1] == 0)
	        	{ PlayerInfo[playerid][pVozilo1] = i; }
	        	else if(PlayerInfo[playerid][pVozilo2] == 0)
	        	{ PlayerInfo[playerid][pVozilo2] = i; }
	        	else if(PlayerInfo[playerid][pVozilo3] == 0)
	        	{ PlayerInfo[playerid][pVozilo3] = i; }
	        	else if(PlayerInfo[playerid][pVozilo4] == 0)
	        	{ PlayerInfo[playerid][pVozilo4] = i; }
	        	else if(PlayerInfo[playerid][pVozilo5] == 0)
	        	{ PlayerInfo[playerid][pVozilo5] = i; }
	            else
	            {
	            	SCM(playerid, COLOR_RED, "[Kupovina vozila]: {FFFFFF}Nemate nijedan slobodan slot za vozila!");
	        		RemovePlayerFromVehicle(playerid);
	        		SetCameraBehindPlayer(playerid);
	        		return TogglePlayerControllable(playerid, 1);
	            }
	            new pName[MAX_PLAYER_NAME];
	            AC_GivePlayerMoney(playerid, -VoziloInfo[i][vCena]);
	            GetPlayerName(playerid, pName, sizeof(pName));
	            new v_file[64];
				format(v_file, 64, VEHPATH, i);
				new INI:File = INI_Open(v_file);
				INI_WriteInt(File, "ID", VoziloInfo[i][vID]);
				INI_WriteInt(File, "Ownable", VoziloInfo[i][vOwnable]);
				INI_WriteString(File, "Owner", pName);
				INI_WriteInt(File, "Cena", VoziloInfo[i][vCena]);
				INI_WriteInt(File, "Neaktivnost", VoziloInfo[i][vNeaktivnost]);
				INI_WriteInt(File, "Registracija", VoziloInfo[i][vRegistracija]);
				INI_WriteInt(File, "PosaoID", VoziloInfo[i][vPosaoID]);
				INI_WriteInt(File, "OrgID", VoziloInfo[i][vOrgID]);
				INI_WriteInt(File, "Rent", VoziloInfo[i][vAdmin]);
				INI_WriteInt(File, "Vip", VoziloInfo[i][vVip]);
				INI_WriteInt(File, "Promoter", VoziloInfo[i][vPromoter]);
				INI_WriteInt(File, "Boja", VoziloInfo[i][vBoja]);
				INI_WriteInt(File, "Boja2", VoziloInfo[i][vBoja2]);
				INI_WriteFloat(File, "X", VoziloInfo[i][vX]);
				INI_WriteFloat(File, "Y", VoziloInfo[i][vY]);
				INI_WriteFloat(File, "Z", VoziloInfo[i][vZ]);
				INI_WriteFloat(File, "Rot", VoziloInfo[i][vRot]);
				INI_WriteInt(File, "Dozvola", VoziloInfo[i][vDozvola]);
				INI_Close(File);
				format(VoziloInfo[i][vOwner], 128, "%s", pName);
				new modelid = GetVehicleModel(i);
				format(string, sizeof(string), "{DAA520}[Kupovina vozila]: {FFFFFF}Cestitamo, uspesno ste kupili vozilo marke {DAA520}%s {FFFFFF}za {DAA520}$%d!", ImenaVozila[modelid-400], VoziloInfo[i][vCena]);
	        	SCM(playerid, -1, string);
	        	SavePlayer(playerid);
	        	TogglePlayerControllable(playerid, 1);
	        }
	    }
	    case DIALOG_GATEPERM:
	    {
	        if(response)
	        {
	            new id = listitem+1;
	            if(id == 4)
	            {
	                SPD(playerid, DIALOG_GATEORGID, DIALOG_STYLE_INPUT, "{DAA520}ID Organizacije", "{FFFFFF}Unesite {DAA520}id{FFFFFF} organizacije za gate:", "{DAA520}Potvrdi", "");
	            }
	            else SPD(playerid, DIALOG_GATEINFO, DIALOG_STYLE_MSGBOX, "{DAA520}Info", "{FFFFFF}Da li ste sigurni da zelite da napravite gate?", "{DAA520}Potvrdi", "");
	        }
	    }
	    case DIALOG_GATEORGID:
	    {
	        if(response)
	        {
	            new id = strval(inputtext);
	            GateInfo[editagate[playerid]][gOrgID] = id;
	            SPD(playerid, DIALOG_GATEINFO, DIALOG_STYLE_MSGBOX, "{DAA520}Info", "{FFFFFF}Da li ste sigurni da zelite da napravite gate?", "{DAA520}Potvrdi", "");
	        }
	    }
	    case DIALOG_GATEINFO:
	    {
	        if(response)
	        {
	            gatefaza[playerid] = 2;
	            editing[playerid] = 2;
	            EditObject(playerid, gateObj[editagate[playerid]]);
	            SCM(playerid, -1, "{DAA520}[Server]: {FFFFFF}Postavite gate tako da bude otvoren!");
	        }
	    }
	    case DIALOG_PORT:
	    {
	        if(response)
	        {
	            new id = listitem+1, string[128];
	            if(IsPlayerInAnyVehicle(playerid))
	            {
	                SetVehiclePos(GetPlayerVehicleID(playerid), PortInfo[id][portX], PortInfo[id][portY], PortInfo[id][portZ]);
	                PutPlayerInVehicle(playerid, GetPlayerVehicleID(playerid), 0);
	            }
	            else
	            {
	                SetPlayerPos(playerid, PortInfo[id][portX], PortInfo[id][portY], PortInfo[id][portZ]);
	            }
	            format(string, sizeof(string), "{DAA520}[Server]: {FFFFFF}Uspesno ste se portovali na likaciju %s!", PortInfo[id][portIme]);
	            SCM(playerid, -1, string);
	        }
	    }
	    case DIALOG_REGISTER:
	    {
		    if(!response) return Kick(playerid);
		    if(response)
		    {
		        if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Register", "Unesite vasu lozinku:", "Registruj se", "Odustani");
		        new INI:File = INI_Open(UserPath(playerid));
				INI_SetTag(File, "data");
				INI_WriteInt(File, "Premium", 0);
				INI_WriteInt(File, "Lozinka", udb_hash(inputtext));
				INI_WriteInt(File, "Novac", 25000);
				INI_WriteInt(File, "Level", 2);
				INI_WriteInt(File, "Respekti", 0);
				INI_WriteInt(File, "Admin", 0);
				INI_WriteInt(File, "Pasos", 0);
				INI_WriteInt(File, "NeededRep", 800);
				INI_WriteInt(File, "Posao", 0);
				INI_WriteInt(File, "Banka", 15000);
				INI_WriteInt(File, "Leader", 0);
				INI_WriteInt(File, "Racun", 0);
				INI_WriteInt(File, "Rate", 0);
				INI_WriteInt(File, "Kredit", 0);
				INI_WriteInt(File, "Kuca", 9999);
				INI_WriteInt(File, "NagradniPoeni", 0);
				INI_WriteInt(File, "Tutorijal", 0);
				INI_WriteInt(File, "Skin", 26);
				INI_Close(File);
				INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra=true, .extra=playerid);
				PrikaziTutorijal(playerid);
		    }
	    }
	    case DIALOG_LOGIN:
	    {
	        if(!response) return Kick(playerid);
		    if(response)
		    {
		        if(udb_hash(inputtext) == PlayerInfo[playerid][pLozinka])
		        {
		            INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra=true, .extra=playerid);
		            AC_GivePlayerMoney(playerid, PlayerInfo[playerid][pNovac]);
		            KillTimer(logintimer[playerid]);
		            TogglePlayerSpectating(playerid, false);
		            SpawnPlayer(playerid);
		            ulogovan[playerid] = 1;
		        }
		        else
		        {
		            ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Unesite vasu lozinku:", "Prijavi se", "Odustani");
		        }
		        return 1;
		    }
	    }
	    case DIALOG_ORGIME:
	    {
	        if(!response)
	        {
	            DestroyPickup(orgPickup[editaorg[playerid]]);
	            SCM(playerid, COLOR_RED, "{DAA520}[Server]: {FFFFFF}Prekinuli ste pravljenje organizacije!");
	            editaorg[playerid] = -1;
	        }
	        if(response)
	        {
	            new ime[128];
	            format(ime, sizeof(ime), "%s", inputtext);
	            OrgInfo[editaorg[playerid]][orgIme] = ime;
	            ShowPlayerDialog(playerid, DIALOG_ORGDRZAVNA, DIALOG_STYLE_MSGBOX, "{DAA520}Vrsta organizacije", "{FFFFFF}Izaberite vrstu organizacije!", "Drzavna", "Ilegalna");
	        }
		}
		case DIALOG_ORGDRZAVNA:
		{
		    if(!response)
		    {
		        OrgInfo[editaorg[playerid]][orgDrzavna] = 0;
		        ShowPlayerDialog(playerid, DIALOG_ORGRANK1, DIALOG_STYLE_INPUT, "{DAA520}Imena rankova", "{FFFFFF}Unesite ime za Rank 1", "Potvrdi", "Odustani");
		    }
		    if(response)
		    {
		        OrgInfo[editaorg[playerid]][orgDrzavna] = 1;
		        ShowPlayerDialog(playerid, DIALOG_ORGRANK1, DIALOG_STYLE_INPUT, "{DAA520}Imena rankova", "{FFFFFF}Unesite ime za Rank 1", "Potvrdi", "Odustani");
		    }
		}
		case DIALOG_ORGRANK1:
		{
		    if(!response)
	        {
	            DestroyPickup(orgPickup[editaorg[playerid]]);
	            SCM(playerid, COLOR_RED, "{DAA520}[Server]: {FFFFFF}Prekinuli ste pravljenje organizacije!");
	            editaorg[playerid] = -1;
	        }
	        if(response)
	        {
	            new string[128];
	            format(string, sizeof(string), "%s", inputtext);
	            OrgInfo[editaorg[playerid]][orgRank1] = string;
	            ShowPlayerDialog(playerid, DIALOG_ORGRANK2, DIALOG_STYLE_INPUT, "{DAA520}Imena rankova", "{FFFFFF}Unesite ime za Rank 2", "Potvrdi", "Odustani");
	        }
		}
		case DIALOG_ORGRANK2:
		{
		    if(!response)
	        {
	            DestroyPickup(orgPickup[editaorg[playerid]]);
	            SCM(playerid, COLOR_RED, "{DAA520}[Server]: {FFFFFF}Prekinuli ste pravljenje organizacije!");
	            editaorg[playerid] = -1;
	        }
	        if(response)
	        {
	            new string[128];
	            format(string, sizeof(string), "%s", inputtext);
	            OrgInfo[editaorg[playerid]][orgRank2] = string;
	            ShowPlayerDialog(playerid, DIALOG_ORGRANK3, DIALOG_STYLE_INPUT, "{DAA520}Imena rankova", "{FFFFFF}Unesite ime za Rank 3", "Potvrdi", "Odustani");
	        }
		}
		case DIALOG_ORGRANK3:
		{
		    if(!response)
	        {
	            DestroyPickup(orgPickup[editaorg[playerid]]);
	            SCM(playerid, COLOR_RED, "{DAA520}[Server]: {FFFFFF}Prekinuli ste pravljenje organizacije!");
	            editaorg[playerid] = -1;
	        }
	        if(response)
	        {
	            new string[128];
	            format(string, sizeof(string), "%s", inputtext);
	            OrgInfo[editaorg[playerid]][orgRank3] = string;
	            ShowPlayerDialog(playerid, DIALOG_ORGRANK4, DIALOG_STYLE_INPUT, "{DAA520}Imena rankova", "{FFFFFF}Unesite ime za Rank 4", "Potvrdi", "Odustani");
	        }
		}
		case DIALOG_ORGRANK4:
		{
		    if(!response)
	        {
	            DestroyPickup(orgPickup[editaorg[playerid]]);
	            SCM(playerid, COLOR_RED, "{DAA520}[Server]: {FFFFFF}Prekinuli ste pravljenje organizacije!");
	            editaorg[playerid] = -1;
	        }
	        if(response)
	        {
	            new string[128];
	            format(string, sizeof(string), "%s", inputtext);
	            OrgInfo[editaorg[playerid]][orgRank4] = string;
	            ShowPlayerDialog(playerid, DIALOG_ORGRANK5, DIALOG_STYLE_INPUT, "{DAA520}Imena rankova", "{FFFFFF}Unesite ime za Rank 5", "Potvrdi", "Odustani");
	        }
		}
		case DIALOG_ORGRANK5:
		{
		    if(!response)
	        {
	            DestroyPickup(orgPickup[editaorg[playerid]]);
	            SCM(playerid, COLOR_RED, "{DAA520}[Server]: {FFFFFF}Prekinuli ste pravljenje organizacije!");
	            editaorg[playerid] = -1;
	        }
	        if(response)
	        {
	            new string[128];
	            format(string, sizeof(string), "%s", inputtext);
	            OrgInfo[editaorg[playerid]][orgRank5] = string;
	            ShowPlayerDialog(playerid, DIALOG_ORGRANK6, DIALOG_STYLE_INPUT, "{DAA520}Imena rankova", "{FFFFFF}Unesite ime za Rank 6", "Potvrdi", "Odustani");
	        }
		}
		case DIALOG_ORGRANK6:
		{
		    if(!response)
	        {
	            DestroyPickup(orgPickup[editaorg[playerid]]);
	            SCM(playerid, COLOR_RED, "{DAA520}[Server]: {FFFFFF}Prekinuli ste pravljenje organizacije!");
	            editaorg[playerid] = -1;
	        }
	        if(response)
	        {
	            new string[128];
	            format(string, sizeof(string), "%s", inputtext);
	            OrgInfo[editaorg[playerid]][orgRank6] = string;
	            ShowPlayerDialog(playerid, DIALOG_ORGRANK7, DIALOG_STYLE_INPUT, "{DAA520}Imena rankova", "{FFFFFF}Unesite ime za Rank 7", "Potvrdi", "Odustani");
	        }
		}
		case DIALOG_ORGRANK7:
		{
		    if(!response)
	        {
	            DestroyPickup(orgPickup[editaorg[playerid]]);
	            SCM(playerid, COLOR_RED, "{DAA520}[Server]: {FFFFFF}Prekinuli ste pravljenje organizacije!");
	            editaorg[playerid] = -1;
	        }
	        if(response)
	        {
	            new string[128], infostring[512], drz[128], i = editaorg[playerid];
	            if(OrgInfo[i][orgDrzavna] == 0)
	            {
	                format(drz, sizeof(drz), "Ilegalna");
	            }
	            else
	            {
	                format(drz, sizeof(drz), "Drzavna");
	            }
	            format(string, sizeof(string), "%s", inputtext);
	            format(infostring, sizeof(infostring), "{DAA520}Da li ste sigurni da zelite da napravite organizaciju?\n{FFFFFF}Ime: {DAA520}%s\n{FFFFFF}Vrsta: {DAA520}%s", OrgInfo[i][orgIme], drz);
	            OrgInfo[editaorg[playerid]][orgRank7] = string;
	            ShowPlayerDialog(playerid, DIALOG_ORGINFO, DIALOG_STYLE_MSGBOX, "{DAA520}Potvrda", infostring, "Potvrdi", "Odustani");
	        }
		}
		case DIALOG_ORGINFO:
		{
		    if(!response)
	        {
	            DestroyPickup(orgPickup[editaorg[playerid]]);
	            SCM(playerid, COLOR_RED, "{DAA520}[Server]: {FFFFFF}Prekinuli ste pravljenje organizacije!");
	            editaorg[playerid] = -1;
	        }
	        if(response)
	        {
				new i = editaorg[playerid], string[128];
				SCM(playerid, COLOR_LIGHTBLUE, "{DAA520}[Server]: {FFFFFF}Uspesno ste napravili organizaciju!");
				SaveOrg(i);
        		format(string, sizeof(string), "{DAA520}[ {FFFFFF}%s {DAA520}]\n{FFFFFF}Leader: {DAA520}%s", OrgInfo[i][orgIme], OrgInfo[i][orgLeader]);
        		orgLabel[i] = Create3DTextLabel(string, COLOR_BLACK, OrgInfo[i][orgX], OrgInfo[i][orgY], OrgInfo[i][orgZ], 20.0, 0, 0);
        		editaorg[playerid] = -1;
	        }
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
forward LoadUser_data(playerid,name[],value[]);
public LoadUser_data(playerid,name[],value[])
{
	INI_Int("Premium",PlayerInfo[playerid][pPremium]);
	INI_Int("Lozinka",PlayerInfo[playerid][pLozinka]);
	INI_Int("Novac",PlayerInfo[playerid][pNovac]);
	INI_Int("Level",PlayerInfo[playerid][pLevel]);
	INI_Int("DoPlate", PlayerInfo[playerid][pDoPlate]);
	INI_Int("Respekti",PlayerInfo[playerid][pRespekti]);
	INI_Int("Admin",PlayerInfo[playerid][pAdmin]);
	INI_Int("Pasos",PlayerInfo[playerid][pPasos]);
	INI_Int("NeededRep",PlayerInfo[playerid][pNeededRep]);
	INI_Int("Posao",PlayerInfo[playerid][pPosao]);
	INI_Int("Leader",PlayerInfo[playerid][pLeader]);
	INI_Int("Racun",PlayerInfo[playerid][pRacun]);
	INI_Int("Banka",PlayerInfo[playerid][pBanka]);
	INI_Int("Rate",PlayerInfo[playerid][pRate]);
	INI_Int("Kredit",PlayerInfo[playerid][pKredit]);
	INI_Int("Kuca",PlayerInfo[playerid][pKuca]);
	INI_Int("Ban",PlayerInfo[playerid][pBan]);
	INI_String("BanRazlog",PlayerInfo[playerid][pBanRazlog], 128);
	INI_Int("Promoter",PlayerInfo[playerid][pPromoter]);
	INI_Int("NagradniPoeni",PlayerInfo[playerid][pNagradniPoeni]);
	INI_Int("Tutorijal",PlayerInfo[playerid][pTutorijal]);
	INI_Int("Skin",PlayerInfo[playerid][pSkin]);
	INI_Int("Vozilo1", PlayerInfo[playerid][pVozilo1]);
 	INI_Int("Vozilo2", PlayerInfo[playerid][pVozilo2]);
 	INI_Int("Vozilo3", PlayerInfo[playerid][pVozilo3]);
 	INI_Int("Vozilo4", PlayerInfo[playerid][pVozilo4]);
 	INI_Int("Vozilo5", PlayerInfo[playerid][pVozilo5]);
	return 1;
}


forward PosaljiPoruku();
public PosaljiPoruku()
{
	for( new i = 0; i < MAX_PLAYERS; i++ )
	{
		if(PlayerInfo[i][pTutorijal] == 1)
		{
		    new RandomPoruka = random(sizeof(NasumicnePoruke));
		    TextDrawSetString(IGTD10, NasumicnePoruke[RandomPoruka]);
		    TextDrawShowForPlayer(i, IGTD10);
		}
	}
	return 1;
}

forward PayDay();
public PayDay()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		PlayerInfo[i][pDoPlate]--;
		if(PlayerInfo[i][pDoPlate] <= 0)
		{
			PlayerInfo[i][pDoPlate] = 60;
			PlayerInfo[i][pRespekti]+=100;
			SCM(i, COLOR_GREEN, "PAYDAY: {FFFFFF}Primili ste platu u kolicini od $500! Ostatak plate vam je isplacen na racun!");
			AC_GivePlayerMoney(i, 500);
			new string[256];
			while(PlayerInfo[i][pRespekti] >= PlayerInfo[i][pNeededRep])
			{
			    PlayerInfo[i][pRespekti]-=PlayerInfo[i][pNeededRep];
			    PlayerInfo[i][pLevel]++;
		     	PlayerInfo[i][pNeededRep]=(PlayerInfo[i][pLevel]*2+4)*100;
		     	format(string, sizeof(string), "PAYDAY: {FFFFFF}Cestitamo, postali ste level %d! Sada vam je potrebno %d respekta!", PlayerInfo[i][pLevel], PlayerInfo[i][pNeededRep]);
		     	SCM(i, COLOR_GREEN, string);
		     	SCM(i, COLOR_GREEN, "PAYDAY: {FFFFFF}Za jos jednu uspesnu godinu radnog staza dobili ste nagradu od $10000!");
		     	AC_GivePlayerMoney(i, 10000);
			}
			if(PlayerInfo[i][pRate] > 0)
			{
			    new oduzmi;
			    PlayerInfo[i][pRate]--;
			    oduzmi=PlayerInfo[i][pKredit]/10;
		        PlayerInfo[i][pBanka]-=oduzmi;
		        if(PlayerInfo[i][pRate] == 0)
		        {
		            PlayerInfo[i][pKredit] = 0;
		        }
		        SCM(i, COLOR_LIGHTBLUE, "[BANK]: {FFFFFF}Sa bankovnog racuna vam je skinuta rata kredita!");
			}
		}
	}
	return 1;
}
forward RespawnVozila();
public RespawnVozila()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerInAnyVehicle(i))
	    {
	        new vehid = GetPlayerVehicleID(i);
	        excludedveh[vehid] = 1;
	    }
	}
	for(new i = 0; i < MAX_VEHICLES; i++)
	{
	    if(excludedveh[i] == 0)
	    {
	        SetVehicleToRespawn(i);
	    }
	    else
	    {
	        excludedveh[i] = 0;
	 	}
	}
	SendClientMessageToAll(COLOR_ORANGE, "AutoRespawn: {FFFFFF}Vozila su uspesno respawnovana. AutoRespawn je na svakih pola sata!");
	return 1;
}
forward rentGate1();
public rentGate1()
{
    MoveDynamicObject(rentGate, 1263.84814, -2048.43701, 60.92853, 8);
	return 1;
}
forward rst();
public rst()
{
	SendRconCommand("gmx");
	return 1;
}
forward RentTimer();
public RentTimer()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(renta[i] != -1)
	    {
	        rentvreme[i]--;
	        if(rentvreme[i] <= 0)
	        {
	            new vehid = renta[i];
	            SetVehicleToRespawn(vehid);
	            rented[vehid] = 0;
	            renta[i] = -1;
	            SCM(i, COLOR_RED, "[RENT]: {FFFFFF}Vreme renta vam je isteklo!");
	        }
	    }
	}
	return 1;
}

forward LoadHouses(id, name[], value[]);
public LoadHouses(id, name[], value[])
{
	INI_String("Owner", HouseInfo[id][hOwner], 128);
	INI_Int("Owned", HouseInfo[id][hOwned]);
	INI_Int("Cena", HouseInfo[id][hCena]);
	INI_Int("Level", HouseInfo[id][hLevel]);
	INI_Int("Neaktivnost", HouseInfo[id][hNeaktivnost]);
	INI_Int("Tip", HouseInfo[id][hTip]);
	INI_Float("X", HouseInfo[id][hX]);
	INI_Float("Y", HouseInfo[id][hY]);
	INI_Float("Z", HouseInfo[id][hZ]);
	INI_Int("SefNovac", HouseInfo[id][hSefNovac]);
	INI_Int("SefDroga", HouseInfo[id][hSefDroga]);
	INI_Int("Zakljucana", HouseInfo[id][hZakljucana]);
	return true;
}

forward LoadFirme(id, name[], value[]);
public LoadFirme(id, name[], value[])
{
	INI_String("Owner", FirmaInfo[id][fiOwner], 128);
	INI_Int("Owned", FirmaInfo[id][fiOwned]);
	INI_Int("Cena", FirmaInfo[id][fiCena]);
	INI_Int("Level", FirmaInfo[id][fiLevel]);
	INI_Int("Neaktivnost", FirmaInfo[id][fiNeaktivnost]);
	INI_Int("Tip", FirmaInfo[id][fiTip]);
	INI_Float("X", FirmaInfo[id][fiX]);
	INI_Float("Y", FirmaInfo[id][fiY]);
	INI_Float("Z", FirmaInfo[id][fiZ]);
	INI_Int("Kasa", FirmaInfo[id][fiKasa]);
	INI_Int("Zalihe", FirmaInfo[id][fiZalihe]);
	INI_Int("Zakljucana", FirmaInfo[id][fiZakljucana]);
	return true;
}

forward InteriorTimer(playerid);
public InteriorTimer(playerid)
{
	TogglePlayerControllable(playerid, 0);
	GameTextForPlayer(playerid, "UCITAVANJE OBJEKATA...", 3000, 3);
	SetTimer("InteriorTimer2", 4000, false);
	return 1;
}
forward InteriorTimer2(playerid);
public InteriorTimer2(playerid)
{
	TogglePlayerControllable(playerid, 1);
	return 1;
}

forward bustimer(playerid);
public bustimer(playerid)
{
	if(jobprogress[playerid] == 1)
	{
	    SetPlayerCheckpoint(playerid, 2022.9196,-1940.4100,13.4469, 5.0);
	    TogglePlayerControllable(playerid, 1);
	    SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Putnici su se uspesno ukrcali!");
	}
	if(jobprogress[playerid] == 2)
	{
	    SetPlayerCheckpoint(playerid, 2022.9196,-1940.4100,13.4469, 5.0);
	    TogglePlayerControllable(playerid, 1);
	    SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Putnici su se uspesno ukrcali!");
	}
	if(jobprogress[playerid] == 3)
	{
	    SetPlayerCheckpoint(playerid, 2258.0442,-1897.7400,13.4677, 5.0);
	    TogglePlayerControllable(playerid, 1);
	    SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Putnici su se uspesno ukrcali/iskrcali!");
	}
	if(jobprogress[playerid] == 4)
	{
	    SetPlayerCheckpoint(playerid, 2386.5752,-1975.8326,13.4811, 5.0);
	    TogglePlayerControllable(playerid, 1);
	    SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Putnici su se uspesno ukrcali/iskrcali!");
	}
	if(jobprogress[playerid] == 5)
	{
	    SetPlayerCheckpoint(playerid, 2497.9773,-1935.9458,13.4263, 5.0);
	    TogglePlayerControllable(playerid, 1);
	    SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Putnici su se uspesno ukrcali/iskrcali!");
	}
	if(jobprogress[playerid] == 6)
	{
	    SetPlayerCheckpoint(playerid, 2462.2026,-1729.0979,13.5137, 5.0);
	    TogglePlayerControllable(playerid, 1);
	    SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Putnici su se uspesno ukrcali/iskrcali!");
	}
	if(jobprogress[playerid] == 7)
	{
	    SetPlayerCheckpoint(playerid, 2222.5337,-1697.3308,13.7032, 5.0);
	    TogglePlayerControllable(playerid, 1);
	    SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Putnici su se uspesno ukrcali/iskrcali!");
	}
	if(jobprogress[playerid] == 8)
	{
	    SetPlayerCheckpoint(playerid, 2109.0979,-1610.8522,13.4816, 5.0);
	    TogglePlayerControllable(playerid, 1);
	    SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Putnici su se uspesno ukrcali/iskrcali!");
	}
	if(jobprogress[playerid] == 9)
	{
	    SetPlayerCheckpoint(playerid, 1998.0784,-1680.9506,13.4823, 5.0);
	    TogglePlayerControllable(playerid, 1);
	    SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Putnici su se uspesno ukrcali/iskrcali!");
	}
	if(jobprogress[playerid] == 10)
	{
	    SetPlayerCheckpoint(playerid, 1920.0400,-1748.7706,13.4818, 5.0);
	    TogglePlayerControllable(playerid, 1);
	    SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Putnici su se uspesno ukrcali/iskrcali!");
	}
	if(jobprogress[playerid] == 11)
	{
	    SetPlayerCheckpoint(playerid, 1818.1876,-1874.5861,13.5050, 5.0);
	    TogglePlayerControllable(playerid, 1);
	    SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Putnici su se uspesno ukrcali/iskrcali!");
	}
	if(jobprogress[playerid] == 12)
	{
            if(PlayerInfo[playerid][pPremium] != 1)
            {
		        new vehid = GetPlayerVehicleID(playerid);
		        AC_GivePlayerMoney(playerid, BUSPLATA);
		        jobprogress[playerid] = 0;
		        radi[playerid] = 0;
		        TogglePlayerControllable(playerid, 1);
		        SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Putnici su se uspesno iskrcali!");
		        SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Za uspesno obavljen posao dobili ste $7500!");
		        RemovePlayerFromVehicle(playerid);
		        SetVehicleToRespawn(vehid);
            }
            else
            {
	            new vehid = GetPlayerVehicleID(playerid);
		        AC_GivePlayerMoney(playerid, BUSPLATAPREMIUM);
		        jobprogress[playerid] = 0;
		        radi[playerid] = 0;
		        TogglePlayerControllable(playerid, 1);
		        SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Putnici su se uspesno iskrcali!");
		        SCM(playerid, COLOR_LIGHTBLUE, "[POSAO]: {FFFFFF}Za uspesno obavljen posao dobili ste $12500!");
		        RemovePlayerFromVehicle(playerid);
		        SetVehicleToRespawn(vehid);
            }
	}
	return 1;
}

stock SendMes(Float:Radius, playerid, color, const str[])
{
	new Float:PosX, Float:PosY, Float:PosZ;
	GetPlayerPos(playerid, PosX, PosY, PosZ);
	foreach(Player, i)
	{
	    if(IsPlayerInRangeOfPoint(i, Radius, PosX, PosY, PosZ))
	    {
	        SCM(i, color, str);
	    }
	}
	return false;
}
///SEKSI
stock PrikaziTutorijal(playerid)
{
	if(TutorijalProgres[playerid] == 0)
	{
		TutorijalProgres[playerid]++;
		TogglePlayerSpectating(playerid, true);
		ClearChat(playerid);
		SCM(playerid, -1, "{DAA520}Dobrodosli!");
		SCM(playerid, -1, "{DAA520}[Server]: {FFFFFF}Hvala vam na registraciji!");
		SCM(playerid, -1, "{DAA520}[Server]: {FFFFFF}Pre nego sto pocnete igru, sprovescemo vac kroz kratak tutorijal servera!");
		SCM(playerid, -1, "{DAA520}[Server]: {FFFFFF}Tutorijal sluzi kako bi lakse naucili stvari vezane za server!");
		SetTimerEx("TutDalje", 5000, false, "i", playerid);
	}
	else if(TutorijalProgres[playerid] == 1)
	{
		TutorijalProgres[playerid]++;
		TogglePlayerSpectating(playerid, true);
		ClearChat(playerid); 
		SCM(playerid, COLOR_RED, "{FFFFFF}========================={DAA520}[ OPSTINA ]{FFFFFF}=========================");
		SCM(playerid, COLOR_RED, "{DAA520}Opstina {FFFFFF}je najvaznije mesto za svakog igraca.");
		SCM(playerid, COLOR_RED, "{FFFFFF}U njoj pravite pasos, dajete otkaz i vrsite ostale bitne stvari...");
		SCM(playerid, COLOR_RED, "{FFFFFF}Nalazi se u samom centru grada i radi 24/7!");
		SCM(playerid, COLOR_RED, "{FFFFFF}=============================================================");
		SetPlayerCameraPos(playerid, 1520.8622, -1720.9845, 27.7675);
		SetPlayerCameraLookAt(playerid, 1520.2002, -1721.7401, 27.6225);
		InterpolateCameraPos(playerid, 1520.8622, -1720.9845, 27.7675, 1449.0204, -1729.3429, 24.1629, 15000, CAMERA_MOVE);
		InterpolateCameraLookAt(playerid, 1520.2002, -1721.7401, 27.6225, 1449.7761, -1730.0050, 24.0428, 15000, CAMERA_MOVE);
		SetTimerEx("TutDalje", 20000, false, "i", playerid);
	}
	else if(TutorijalProgres[playerid] == 2)
	{
		TutorijalProgres[playerid]++;
		TogglePlayerSpectating(playerid, true);
		ClearChat(playerid); 
		SCM(playerid, COLOR_RED, "{FFFFFF}====================={DAA520}[ POLICIJSKA STANICA ]{FFFFFF}=====================");
		SCM(playerid, COLOR_RED, "{DAA520}Policijska stanica {FFFFFF}je mesto koje vam pruza bezbednost.");
		SCM(playerid, COLOR_RED, "{FFFFFF}Beogradska policija vam pomaze da se osecate sigurno.");
		SCM(playerid, COLOR_RED, "{FFFFFF}Policija naseg grada suzbija sve vrste kriminala!");
		SCM(playerid, COLOR_RED, "{FFFFFF}===============================================================");
		SetPlayerCameraPos(playerid, 1514.7758, -1620.8800, 32.0656);
		SetPlayerCameraLookAt(playerid, 1515.5193, -1621.5577, 31.8306);
		InterpolateCameraPos(playerid, 1514.7758, -1620.8800, 32.0656, 1519.2054, -1717.3839, 26.7888, 15000, CAMERA_MOVE);
		InterpolateCameraLookAt(playerid, 1515.5193, -1621.5577, 31.8306, 1519.8237, -1716.5902, 26.6139, 15000, CAMERA_MOVE);
		SetTimerEx("TutDalje", 20000, false, "i", playerid);
	}
	else if(TutorijalProgres[playerid] == 3)
	{
		TutorijalProgres[playerid]++;
		TogglePlayerSpectating(playerid, true);
		ClearChat(playerid); 
		SCM(playerid, COLOR_RED, "{FFFFFF}========================={DAA520}[ BOLNICA ]{FFFFFF}=========================");
		SCM(playerid, COLOR_RED, "{DAA520}Bolnica {FFFFFF}je mesto namenjeno vasem zdravlju.");
		SCM(playerid, COLOR_RED, "{FFFFFF}Svaki put kada hitna dodje po vas, stvoricete se ovde!");
		SCM(playerid, COLOR_RED, "{FFFFFF}Troskovi bolnice nisu skupi i veoma su korisni.");
		SCM(playerid, COLOR_RED, "{FFFFFF}=============================================================");
		SetPlayerCameraPos(playerid, 1217.2850, -1369.7325, 26.0701);
		SetPlayerCameraLookAt(playerid, 1216.4204, -1369.2184, 25.9001);
		InterpolateCameraPos(playerid, 1217.2850, -1369.7325, 26.0701, 1210.3739, -1285.4865, 23.5513, 15000, CAMERA_MOVE);
		InterpolateCameraLookAt(playerid, 1216.4204, -1369.2184, 25.9001, 1209.6156, -1286.1475, 23.3913, 15000, CAMERA_MOVE);
		SetTimerEx("TutDalje", 20000, false, "i", playerid);
	}
	else if(TutorijalProgres[playerid] == 4)
	{
		TutorijalProgres[playerid]++;
		TogglePlayerSpectating(playerid, true);
		ClearChat(playerid); 
		SCM(playerid, COLOR_RED, "{FFFFFF}========================={DAA520}[ BANKA ]{FFFFFF}=========================");
		SCM(playerid, COLOR_RED, "{DAA520}Banka {FFFFFF}se brine o vama i vasoj zaradi.");
		SCM(playerid, COLOR_RED, "{FFFFFF}U banci mozete podici kredit, a takodje i cuvati novac.");
		SCM(playerid, COLOR_RED, "{FFFFFF}Banka vam je uvek na raspolaganju u teskim trenucima.");
		SCM(playerid, COLOR_RED, "{FFFFFF}===========================================================");
		SetPlayerCameraPos(playerid, 1430.9457, -1037.4298, 33.0350);
		SetPlayerCameraLookAt(playerid, 1431.5459, -1036.6218, 32.7951);
		InterpolateCameraPos(playerid, 1430.9457, -1037.4298, 33.0350, 1479.2679, -1036.6798, 32.0807, 15000, CAMERA_MOVE);
		InterpolateCameraLookAt(playerid, 1431.5459, -1036.6218, 32.7951, 1478.6110, -1035.9167, 31.8608, 15000, CAMERA_MOVE);
		SetTimerEx("TutDalje", 20000, false, "i", playerid);
	}
	else if(TutorijalProgres[playerid] == 5)
	{
		TutorijalProgres[playerid]++;
		TogglePlayerSpectating(playerid, true);
		ClearChat(playerid); 
		SCM(playerid, COLOR_RED, "{FFFFFF}========================={DAA520}[ GUN SHOP ]{FFFFFF}=========================");
		SCM(playerid, COLOR_RED, "{FFFFFF}Najnoviji {DAA520}Gun Shop {FFFFFF}opremljen je najboljom opremom za sve prilike.");
		SCM(playerid, COLOR_RED, "{FFFFFF}Gun Shop poseduje Target Range u kom mozete vezbati vase vestine.");
		SCM(playerid, COLOR_RED, "{FFFFFF}Ovde ne dolazite ako imate lose namere!");
		SCM(playerid, COLOR_RED, "{FFFFFF}==============================================================");
		SetPlayerCameraPos(playerid, 1354.4471, -1259.3551, 20.4787);
		SetPlayerCameraLookAt(playerid, 1355.1000, -1260.1218, 20.2438);
		InterpolateCameraPos(playerid, 1354.4471, -1259.3551, 20.4787, 1354.2303, -1307.6774, 18.0839, 15000, CAMERA_MOVE);
		InterpolateCameraLookAt(playerid, 1355.1000, -1260.1218, 20.2438, 1354.8413, -1306.8772, 17.9890, 15000, CAMERA_MOVE);
		SetTimerEx("TutDalje", 20000, false, "i", playerid);
	}
	else
	{
		TutorijalProgres[playerid]++;
		TogglePlayerSpectating(playerid, true);
		ClearChat(playerid); 
		SCM(playerid, COLOR_RED, "{FFFFFF}========================={DAA520}[ SPAWN ]{FFFFFF}=========================");
		SCM(playerid, COLOR_RED, "{DAA520}Spawn {FFFFFF}je mesto na kom ce se vas igrac stvoriti za par trenutaka.");
		SCM(playerid, COLOR_RED, "{FFFFFF}Zivecete u ovom hotelu sve dok ne kupite svoju kucu/stan/vikendicu.");
		SCM(playerid, COLOR_RED, "{FFFFFF}Ako vam je potreban prevoz, uzmite rent ili pozovite taxi!");
		SCM(playerid, COLOR_RED, "{FFFFFF}Za kraj, zelimo vam puno srece i srecnog igranja, vas {DAA520}PerfectCrime {FFFFFF}Admin tim!");
		SCM(playerid, COLOR_RED, "{FFFFFF}===========================================================");
		SetPlayerCameraPos(playerid, 1269.9066, -2037.1813, 83.5278);
		SetPlayerCameraLookAt(playerid, 1268.9016, -2037.1865, 83.4129);
		InterpolateCameraPos(playerid, 1269.9066, -2037.1813, 83.5278, 1161.3881, -2037.2179, 75.8562, 15000, CAMERA_MOVE);
		InterpolateCameraLookAt(playerid, 1268.9016, -2037.1865, 83.4129, 1160.3828, -2037.2273, 75.7513, 15000, CAMERA_MOVE);
		SetTimerEx("TutDalje", 20000, false, "i", playerid);
	}
}

forward TutDalje(playerid);
public TutDalje(playerid)
{
	if(TutorijalProgres[playerid] == 7)
	{
		Registracija(playerid);
	}
	else
	{
		PrikaziTutorijal(playerid);
	}
	return 1;
}

stock Registracija(playerid)
{
	PlayerInfo[playerid][pBanka] = 15000;
	TogglePlayerSpectating(playerid, false);
	SpawnPlayer(playerid);
	AC_GivePlayerMoney(playerid, 25000);
	SetCameraBehindPlayer(playerid);
	PlayerInfo[playerid][pLevel] = 2;
	PlayerInfo[playerid][pTutorijal] = 1;
	ulogovan[playerid] = 1;
}

forward TDUpdate(playerid);
public TDUpdate(playerid)
{
	//VREME
	new string[128], year, mounth, day, hours, minutes, sec;
	getdate(year, mounth, day), gettime(hours, minutes, sec);
	format(string, sizeof(string), "%s%d/%s%d/%s%d", ((day < 10) ? ("0") : ("")), day, ((mounth < 10) ? ("0") : ("")), mounth, ((year < 10) ? ("0") : ("")), year);
	TextDrawSetString(IGTD3, string);
	format(string, sizeof(string), "%s%d:%s%d", ((hours < 10) ? ("0") : ("")), hours, ((minutes < 10) ? ("0") : ("")), minutes);
	TextDrawSetString(IGTD2, string);
	
	//BANKA
	new bankastring[128];
	format(bankastring, sizeof(bankastring), "Banka: %d", PlayerInfo[playerid][pBanka]);
	
	for(new id = 0; id < MAX_PLAYERS; id++)
	{
		UpdateBubble(id);
	}
}

Float:GetSpeed(playerid)
{
	new veh, Float:X, Float:Y, Float:Z;
	veh = GetPlayerVehicleID(playerid);
	GetVehicleVelocity(veh, X, Y, Z);
	return floatsqroot(floatpower(X,2)+floatpower(Y,2))*180.0;
}
forward CarUpdate(playerid);
public CarUpdate(playerid)
{// 22 - dzep // 23 - banka // 24 - zlato
	if(IsPlayerInAnyVehicle(playerid))
	{
	    new vehid = GetPlayerVehicleID(playerid);
	    new modelid = GetVehicleModel(vehid);
	    new Float:speed = GetSpeed(playerid);
	    new Float:hp;
	    GetVehicleHealth(vehid, hp);
	    new ime[128], hps[128], speeds[128], fuel[128];
	    format(ime, sizeof(ime), "%s", ImenaVozila[modelid-400]);
	    format(hps, sizeof(hps), "hp:%d.0", floatround(hp, floatround_round));
	    format(speeds, sizeof(speeds), "%dkph", floatround(speed, floatround_round));
	    format(fuel, sizeof(fuel), "%dl", VehInfo[vehid][vFuel]);
	    PlayerTextDrawSetString(playerid, Speedometer2[playerid], ime);
	    PlayerTextDrawSetString(playerid, Speedometer3[playerid], speeds);
	    PlayerTextDrawSetString(playerid, Speedometer5[playerid], hps);
	    PlayerTextDrawSetString(playerid, Speedometer4[playerid], fuel);
	}
	return 1;
}
forward LoginTimer(playerid);
public LoginTimer(playerid)
{
	SCM(playerid, COLOR_RED, "[PC]: {FFFFFF}Niste se prijavili na vreme, izbaceni ste sa servera!");
	Kick(playerid);
	return 1;
}
forward ZatvoriVipGate();
public ZatvoriVipGate()
{
	MoveDynamicObject(vipgate, 1108.47034, -1741.14038, 15.23720, 2.0, 0.00000, -1.00000, 90.00000);
	return 1;
}
forward UpaliAuto(playerid);
public UpaliAuto(playerid)
{
	new broj;
	broj = random(4);
	if(broj == 1)
	{
	    GameTextForPlayer(playerid, "~r~Motor se nije upalio!", 3000, 3);
	    TogglePlayerControllable(playerid, 1);
	}
	else
	{
	    new vehid = GetPlayerVehicleID(playerid);
	    GameTextForPlayer(playerid, "~g~Motor se uspesno upalio!", 3000, 3);
	    TogglePlayerControllable(playerid, 1);
	    VehInfo[vehid][vEngine] = 1;
     	SetVehicleParamsEx(vehid, 1, VehInfo[vehid][vEngine], VehInfo[vehid][vLights], VehInfo[vehid][vAlarm], VehInfo[vehid][vDoor], VehInfo[vehid][vBonnet], VehInfo[vehid][vObj]);
	}
	return 1;
}
forward Fuel();
public Fuel()
{
	for(new i = 0; i < MAX_PROMOTERS; i++)
	{
	    new id = GetPlayerID(PromoterInfo[i][promName]), str[128];
	    format(str, 128, "Niko");
	    if(id == -1)
	    {
	        if(strcmp(PromoterInfo[i][promName], str))
	        {
	            PromoterInfo[i][promNeaktivnost]++;
	        }
	    }
	    SavePromoter(i);
	}
	for(new i = 0; i < MAX_VEHICLES; i++)
	{
	    if(VehInfo[i][vEngine] == 1)
	    {
	        VehInfo[i][vFuel]--;
	        if(VehInfo[i][vFuel] <= 0)
	        {
	            VehInfo[i][vEngine] = 0;
	            SetVehicleParamsEx(i, 1, VehInfo[i][vEngine], VehInfo[i][vLights], VehInfo[i][vAlarm], VehInfo[i][vDoor], VehInfo[i][vBonnet], VehInfo[i][vObj]);
	        }
	    }
	}
	for(new i = 0; i < MAX_ADMINS; i++)
	{
	    new id = GetPlayerID(AdminInfo[i][aName]);
	    if(id == -1)
	    {
			new str[128];
			format(str, 128, "Niko");
			if(!strcmp(str, AdminInfo[i][aName])){}
			else
			{
			    AdminInfo[i][aNeaktivnost]++;
			}
	    }
	    else
	    {
	        if(pADuty[id] == 1)
	        {
	            AdminInfo[i][aDuty]++;
	        }
	    }
	    SaveAdmin(i);
	}
	return 1;
}
forward LoadOrgs(id, name[], value[]);
public LoadOrgs(id, name[], value[])
{
	INI_String("Ime", OrgInfo[id][orgIme], 128);
	INI_String("Leader", OrgInfo[id][orgLeader], 128);
	INI_String("Member1", OrgInfo[id][orgMember1], 128);
	INI_String("Member2", OrgInfo[id][orgMember2], 128);
	INI_String("Member3", OrgInfo[id][orgMember3], 128);
	INI_String("Member4", OrgInfo[id][orgMember4], 128);
	INI_String("Member5", OrgInfo[id][orgMember5], 128);
	INI_String("Member6", OrgInfo[id][orgMember6], 128);
	INI_String("Member7", OrgInfo[id][orgMember7], 128);
	INI_String("Member8", OrgInfo[id][orgMember8], 128);
	INI_String("Member9", OrgInfo[id][orgMember9], 128);
	INI_String("Member10", OrgInfo[id][orgMember10], 128);
	INI_String("Member11", OrgInfo[id][orgMember11], 128);
	INI_String("Member12", OrgInfo[id][orgMember12], 128);
	INI_String("Member13", OrgInfo[id][orgMember13], 128);
	INI_String("Member14", OrgInfo[id][orgMember14], 128);
	INI_String("Member15", OrgInfo[id][orgMember15], 128);
	INI_String("Member16", OrgInfo[id][orgMember16], 128);
	INI_String("Member17", OrgInfo[id][orgMember17], 128);
	INI_String("Member18", OrgInfo[id][orgMember18], 128);
	INI_String("Member19", OrgInfo[id][orgMember19], 128);
	INI_String("Member20", OrgInfo[id][orgMember20], 128);
	INI_Int("SefMoney", OrgInfo[id][orgSefMoney]);
	INI_Int("SefMats", OrgInfo[id][orgSefMats]);
	INI_Int("SefDroga", OrgInfo[id][orgSefDrugs]);
	INI_Int("Drzavna", OrgInfo[id][orgDrzavna]);
	INI_String("Rank1", OrgInfo[id][orgRank1], 128);
	INI_String("Rank2", OrgInfo[id][orgRank2], 128);
	INI_String("Rank3", OrgInfo[id][orgRank3], 128);
	INI_String("Rank4", OrgInfo[id][orgRank4], 128);
	INI_String("Rank5", OrgInfo[id][orgRank5], 128);
	INI_String("Rank6", OrgInfo[id][orgRank6], 128);
	INI_String("Rank7", OrgInfo[id][orgRank7], 128);
	INI_Float("X", OrgInfo[id][orgX]);
	INI_Float("Y", OrgInfo[id][orgY]);
	INI_Float("Z", OrgInfo[id][orgZ]);
	return 1;
}
forward LoadVozila(id, name[], value[]);
public LoadVozila(id, name[], value[])
{
	INI_Int("ID", VoziloInfo[id][vID]);
	INI_Int("Ownable", VoziloInfo[id][vOwnable]);
	INI_String("Owner", VoziloInfo[id][vOwner], 128);
	INI_Int("Cena", VoziloInfo[id][vCena]);
	INI_Int("Neaktivnost", VoziloInfo[id][vNeaktivnost]);
	INI_Int("Registracija", VoziloInfo[id][vRegistracija]);
	INI_Int("PosaoID", VoziloInfo[id][vPosaoID]);
	INI_Int("OrgID", VoziloInfo[id][vOrgID]);
	INI_Int("Rent", VoziloInfo[id][vRent]);
	INI_Int("Admin", VoziloInfo[id][vAdmin]);
	INI_Int("Vip", VoziloInfo[id][vVip]);
	INI_Int("Promoter", VoziloInfo[id][vPromoter]);
	INI_Int("Boja", VoziloInfo[id][vBoja]);
	INI_Int("Boja2", VoziloInfo[id][vBoja2]);
	INI_Int("Gorivo", VoziloInfo[id][vGorivo]);
	INI_Float("X", VoziloInfo[id][vX]);
	INI_Float("Y", VoziloInfo[id][vY]);
	INI_Float("Z", VoziloInfo[id][vZ]);
	INI_Float("Rot", VoziloInfo[id][vRot]);
	INI_Int("Dozvola", VoziloInfo[id][vDozvola]);
	return 1;
}
forward PrikaziTD(playerid);
public PrikaziTD(playerid)
{
	TextDrawShowForPlayer(playerid, IGTD0);
	TextDrawShowForPlayer(playerid, IGTD1);
	TextDrawShowForPlayer(playerid, IGTD2);
	TextDrawShowForPlayer(playerid, IGTD3);
	TextDrawShowForPlayer(playerid, IGTD4);
	TextDrawShowForPlayer(playerid, IGTD5);
	TextDrawShowForPlayer(playerid, IGTD6);
	TextDrawShowForPlayer(playerid, IGTD7);
	TextDrawShowForPlayer(playerid, IGTD8);
	TextDrawShowForPlayer(playerid, IGTD9);
	TextDrawShowForPlayer(playerid, IGTD10);
	TextDrawShowForPlayer(playerid, IGTD11);
	TextDrawShowForPlayer(playerid, IGTD12);
	TextDrawShowForPlayer(playerid, IGTD13);
	TextDrawShowForPlayer(playerid, IGTD14);
	return 1;
}
forward LoadPorts(id, name[], value[]);
public LoadPorts(id, name[], value[])
{
	INI_String("Ime", PortInfo[id][portIme], 128);
	INI_Float("X", PortInfo[id][portX]);
	INI_Float("Y", PortInfo[id][portY]);
	INI_Float("Z", PortInfo[id][portZ]);
	return 1;
}

forward LoadGPS(id, name[], value[]);
public LoadGPS(id, name[], value[])
{
	INI_String("Ime", GPSInfo[id][gpsIme], 128);
	INI_Float("X", GPSInfo[id][gpsX]);
	INI_Float("Y", GPSInfo[id][gpsY]);
	INI_Float("Z", GPSInfo[id][gpsZ]);
	return 1;
}

forward RefreshPickupLabel(id, tip);
public RefreshPickupLabel(id, tip)
{
	if(id == 0)
	{
	    if(tip == 1)
	    {
		    for(new i = 0; i <= MAX_HOUSES; i++)
		    {
		        DestroyPickup(hPickup[i]);
		        Delete3DTextLabel(hLabel[i]);
		        new str[32];
		        if(HouseInfo[i][hTip] == 1) { format(str, sizeof(str), "Stan"); }
				if(HouseInfo[i][hTip] == 2) { format(str, sizeof(str), "Mala Kuca"); }
				if(HouseInfo[i][hTip] == 3) { format(str, sizeof(str), "Srednja Kuca"); }
				if(HouseInfo[i][hTip] == 4) { format(str, sizeof(str), "Velika Kuca"); }
				if(HouseInfo[i][hTip] == 5) { format(str, sizeof(str), "Vila"); }
		        if(HouseInfo[i][hOwned] == 0)
				{
				    new string[512];
				    format(string, sizeof(string), "{4682B4}Kuca na prodaju\nOwner: {FFFFFF}Niko\n{4682B4}Cena: {FFFFFF}%d\n{4682B4}Level: {FFFFFF}%d\n{4682B4}Tip: {FFFFFF}%s\n{4682B4}Adresa: {FFFFFF}%d\n{4682B4}/kupikucu", HouseInfo[i][hCena], HouseInfo[i][hLevel], str, i);
				    hPickup[i] = CreatePickup(1273, 1, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ]);
				    hLabel[i] = Create3DTextLabel(string, COLOR_WHITE, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ], 10.0, 0, 0);
				}
				else
				{
				    new string[512];
				    format(string, sizeof(string), "{4682B4}Kuca na prodaju\nOwner: {FFFFFF}%s\n{4682B4}Cena: {FFFFFF}%d\n{4682B4}Level: {FFFFFF}%d\n{4682B4}Tip: {FFFFFF}%s\n{4682B4}Adresa: {FFFFFF}%d", HouseInfo[i][hOwner], HouseInfo[i][hCena], HouseInfo[i][hLevel], str, i);
				    hPickup[i] = CreatePickup(1272, 1, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ]);
				    hLabel[i] = Create3DTextLabel(string, COLOR_WHITE, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ], 10.0, 0, 0);
				}
		    }
	    }
	    if(tip == 2)
	    {
		    for(new i = 0; i <= MAX_ORGS; i++)
		    {
		        DestroyPickup(orgPickup[i]);
		        Delete3DTextLabel(orgLabel[i]);
		        new string[128];
	        	format(string, sizeof(string), "{DAA520}[ {FFFFFF}%s {DAA520}]\n{FFFFFF}Leader: {DAA520}%s", OrgInfo[i][orgIme], OrgInfo[i][orgLeader]);
	        	orgLabel[i] = Create3DTextLabel(string, COLOR_BLACK, OrgInfo[i][orgX], OrgInfo[i][orgY], OrgInfo[i][orgZ], 20.0, 0, 0);
	        	orgPickup[i] = CreatePickup(19132, 1, OrgInfo[i][orgX], OrgInfo[i][orgY], OrgInfo[i][orgZ]);
		    }
	    }
	}
	else
	{
	    if(tip == 1)
		{
		    DestroyPickup(hPickup[id]);
      		Delete3DTextLabel(hLabel[id]);
      		new str[32];
      		if(HouseInfo[id][hTip] == 1) { format(str, sizeof(str), "Stan"); }
			if(HouseInfo[id][hTip] == 2) { format(str, sizeof(str), "Mala Kuca"); }
			if(HouseInfo[id][hTip] == 3) { format(str, sizeof(str), "Srednja Kuca"); }
			if(HouseInfo[id][hTip] == 4) { format(str, sizeof(str), "Velika Kuca"); }
			if(HouseInfo[id][hTip] == 5) { format(str, sizeof(str), "Vila"); }
      		if(HouseInfo[id][hOwned] == 0)
			{
			  	new string[512];
			  	format(string, sizeof(string), "{4682B4}Kuca na prodaju\nOwner: {FFFFFF}Niko\n{4682B4}Cena: {FFFFFF}%d\n{4682B4}Level: {FFFFFF}%d\n{4682B4}Tip: {FFFFFF}%s\n{4682B4}Adresa: {FFFFFF}%d\n{4682B4}/kupikucu", HouseInfo[id][hCena], HouseInfo[id][hLevel], str, id);
			  	hPickup[id] = CreatePickup(1273, 1, HouseInfo[id][hX], HouseInfo[id][hY], HouseInfo[id][hZ]);
			  	hLabel[id] = Create3DTextLabel(string, COLOR_WHITE, HouseInfo[id][hX], HouseInfo[id][hY], HouseInfo[id][hZ], 10.0, 0, 0);
			}
			else
			{
			  	new string[512];
			  	format(string, sizeof(string), "{4682B4}Kuca na prodaju\nOwner: {FFFFFF}%s\n{4682B4}Cena: {FFFFFF}%d\n{4682B4}Level: {FFFFFF}%d\n{4682B4}Tip: {FFFFFF}%s\n{4682B4}Adresa: {FFFFFF}%d", HouseInfo[id][hOwner], HouseInfo[id][hCena], HouseInfo[id][hLevel], str, id);
			  	hPickup[id] = CreatePickup(1272, 1, HouseInfo[id][hX], HouseInfo[id][hY], HouseInfo[id][hZ]);
			  	hLabel[id] = Create3DTextLabel(string, COLOR_WHITE, HouseInfo[id][hX], HouseInfo[id][hY], HouseInfo[id][hZ], 10.0, 0, 0);
			}
		}
		if(tip == 2)
		{
		    DestroyPickup(orgPickup[id]);
      		Delete3DTextLabel(orgLabel[id]);
      		new string[128];
	     	format(string, sizeof(string), "{DAA520}[ {FFFFFF}%s {DAA520}]\n{FFFFFF}Leader: {DAA520}%s", OrgInfo[id][orgIme], OrgInfo[id][orgLeader]);
	     	orgLabel[id] = Create3DTextLabel(string, COLOR_BLACK, OrgInfo[id][orgX], OrgInfo[id][orgY], OrgInfo[id][orgZ], 20.0, 0, 0);
	     	orgPickup[id] = CreatePickup(19132, 1, OrgInfo[id][orgX], OrgInfo[id][orgY], OrgInfo[id][orgZ]);
		}
	}
	return 1;
}
forward LoadAdmins(id, name[], value[]);
public LoadAdmins(id, name[], value[])
{
	INI_String("Name", AdminInfo[id][aName], 128);
	INI_Int("Neaktivnost", AdminInfo[id][aNeaktivnost]);
	INI_Int("Duty", AdminInfo[id][aDuty]);
	return 1;
}

forward LoadGates(id, name[], value[]);
public LoadGates(id, name[], value[])
{
	INI_Int("ObjID", GateInfo[id][gObjID]);
	INI_Float("X", GateInfo[id][gX]);
	INI_Float("Y", GateInfo[id][gY]);
	INI_Float("Z", GateInfo[id][gZ]);
	INI_Float("RX", GateInfo[id][gRX]);
	INI_Float("RY", GateInfo[id][gRY]);
	INI_Float("RZ", GateInfo[id][gRZ]);
	INI_Float("OX", GateInfo[id][gOX]);
	INI_Float("OY", GateInfo[id][gOY]);
	INI_Float("OZ", GateInfo[id][gOZ]);
	INI_Int("OrgID", GateInfo[id][gOrgID]);
	INI_Int("Perm", GateInfo[id][gPerm]);
	return 1;
}
forward OtvoriGate(id);
public OtvoriGate(id)
{
	MoveDynamicObject(gate[id], GateInfo[id][gOX], GateInfo[id][gOY], GateInfo[id][gOZ], 5, GateInfo[id][gRX], GateInfo[id][gRY], GateInfo[id][gRZ]);
	SetTimerEx("ZatvoriGate", 7000, false, "i", id);
	return 1;
}
forward ZatvoriGate(id);
public ZatvoriGate(id)
{
	MoveDynamicObject(gate[id], GateInfo[id][gX], GateInfo[id][gY], GateInfo[id][gZ], 5, GateInfo[id][gRX], GateInfo[id][gRY], GateInfo[id][gRZ]);
	return 1;
}
forward BanMessage(playerid);
public BanMessage(playerid)
{
	new reason[128];
	format(reason, sizeof(reason), "Razlog: {DAA520}%s", PlayerInfo[playerid][pBanRazlog]);
	if(PlayerInfo[playerid][pBan] == 101)
	{
	    ClearChat(playerid);
	    SCM(playerid, -1, "========================={DAA520}[ BAN ]{FFFFFF}=========================");
	    SCM(playerid, -1, "Banovani ste sa servera! Trajanje bana: {DAA520}Zauvek.");
	    SCM(playerid, -1, reason);
	    SCM(playerid, -1, "Ako mislite da je ovo greska, prijavite je na {DAA520}forum!");
	    SCM(playerid, -1, "Link: {DAA520}www.pc-rp.com/forum");
	    SCM(playerid, -1, "=========================================================");
	    SetTimerEx("KickPlayer", 500, false, "i", playerid);
	}
	else
	{
	    ClearChat(playerid);
	    new poruka[128];
	    format(poruka, sizeof(poruka), "Banovani ste sa servera! Trajanje bana: {DAA520}%d dana.", PlayerInfo[playerid][pBan]);
	    SCM(playerid, -1, "========================={DAA520}[ BAN ]{FFFFFF}=========================");
	    SCM(playerid, -1, poruka);
	    SCM(playerid, -1, reason);
	    SCM(playerid, -1, "Ako mislite da je ovo greska, prijavite je na {DAA520}forum!");
	    SCM(playerid, -1, "Link: {DAA520}www.pc-rp.com/forum");
	    SCM(playerid, -1, "=========================================================");
	    SetTimerEx("KickPlayer", 500, false, "i", playerid);
	}
	return 1;
}

forward LoadPromoters(id, name[], value[]);
public LoadPromoters(id, name[], value[])
{
	INI_String("Name", PromoterInfo[id][promName], 128);
	INI_Int("Neaktivnost", PromoterInfo[id][promNeaktivnost]);
	return 1;
}

forward NagradnaPoruka();
public NagradnaPoruka()
{
	new str[64], string[128];
	igraTraje = 1;
	for(new i = 0; i < 8; i++)
	{
	    new chr = random(sizeof(NasumicniKarakter));
	    strcat(str, NasumicniKarakter[chr]);
	}
	nagradnaPoruka = str;
	format(string, sizeof(string), "{DAA520}Nagradna igra: {FFFFFF}Igrac koji prvi ukuca {DAA520}%s {FFFFFF}dobija $1000 i nagradni poen!", nagradnaPoruka);
	SCMTA(COLOR_RED, string);
	return 1;
}

stock AC_GivePlayerMoney(playerid, money)
{
	pMoneyTokens[playerid] += 20;
	GivePlayerMoney(playerid, money);
}

forward AntiCheatTimer();
public AntiCheatTimer()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(ulogovan[i] == 1)
		{
			if(lastMoney[i] != GetPlayerMoney(i))
			{
				if(pMoneyTokens[i] == 0)
				{
					AC_GivePlayerMoney(i, -(lastMoney[i]-GetPlayerMoney(i)));
					SavePlayer(i);
					AC_Kick(i, 1);
				}
				else
				{
					pMoneyTokens[i] = 0;
					lastMoney[i] = GetPlayerMoney(i);
				}
			}
		}
	}
	return 1;
}

stock AC_Kick(playerid, id)
{
	if(id == 1)
	{
		new str[128], pName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, pName, sizeof(pName));
		format(str, 128, "Igrac %s je izbacen zbog sumnje da koristi Money Hack!", pName);
		Log(str, AC);
		ClearChat(playerid);
		SCM(playerid, COLOR_RED, "[Anti-Cheat]: {FFFFFF}Izbaceni ste sa servera zbo sumnje da koristite money hack!");
		SetTimerEx("KickPlayer", 700, false, "i", playerid);
	}
}

forward KickPlayer(id);
public KickPlayer(id)
{
	Kick(id);
	return 1;
}

stock Log(string[], id)
{
	new entry[170], h, m, s;
	gettime(h,m,s);
	format(entry, sizeof(entry), "[%d:%d:%d]: %s\n", h,m,s, string);
	new File:logFile;
	if(id == WARNING)
	{logFile = fopen("logovi/warning.log", io_append);}
	if(id == AC)
	{logFile = fopen("logovi/anticheat.log", io_append);}
	if(id == KICK)
	{logFile = fopen("logovi/kick.log", io_append);}
	if(id == BAN)
	{logFile = fopen("logovi/ban.log", io_append);}
	if(id == LOGIN)
	{logFile = fopen("logovi/login.log", io_append);}
	if(id == REGISTER)
	{logFile = fopen("logovi/register.log", io_append);}
	fwrite(logFile, entry);
	fclose(logFile);
}

stock IsAPlane(veh)
{
	new vehid = GetVehicleModel(veh);
	if(vehid == 592 || vehid == 577 || vehid == 511 || vehid == 512 || vehid == 593 || vehid == 520 || vehid == 553 || vehid == 476 || vehid == 519 || vehid == 460 || vehid == 513) return 1;
	return 0;
}
stock IsABoat(veh)
{
	new vehid = GetVehicleModel(veh);
	if(vehid == 430 || vehid == 446 || vehid == 452 || vehid == 453 || vehid == 454 || vehid == 472 || vehid == 473 || vehid == 484 || vehid == 493 || vehid == 595) return 1;
	return 0;
}
