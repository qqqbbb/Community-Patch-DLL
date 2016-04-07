#include "CvGameCoreDLLPCH.h"
#include "CvGameCoreDLLUtil.h"
#include "ICvDLLUserInterface.h"
#include "CvGameCoreUtils.h"
#include "CvInfosSerializationHelper.h"
#include "cvStopWatch.h"

// must be included after all other headers
#include "LintFree.h"

#if defined(MOD_BALANCE_CORE)

CvCorporationEntry::CvCorporationEntry(void)
{
}

CvCorporationEntry::~CvCorporationEntry(void)
{
}

BuildingClassTypes CvCorporationEntry::GetHeadquartersBuildingClass() const
{
	return m_eHeadquartersBuildingClass;
}

BuildingClassTypes CvCorporationEntry::GetOfficeBuildingClass() const
{
	return m_eOfficeBuildingClass;
}

BuildingClassTypes CvCorporationEntry::GetFranchiseBuildingClass() const
{
	return m_eFranchiseBuildingClass;
}

bool CvCorporationEntry::CacheResults(Database::Results& kResults, CvDatabaseUtility& kUtility)
{
	if(!CvBaseInfo::CacheResults(kResults, kUtility))
		return false;

	//References
	const char* szTextVal = NULL;
	szTextVal = kResults.GetText("HeadquartersBuildingClass");
	m_eHeadquartersBuildingClass = (BuildingClassTypes) GC.getInfoTypeForString(szTextVal, true);
	
	szTextVal = kResults.GetText("OfficeBuildingClass");
	m_eOfficeBuildingClass = (BuildingClassTypes) GC.getInfoTypeForString(szTextVal, true);
	
	szTextVal = kResults.GetText("FranchiseBuildingClass");
	m_eFranchiseBuildingClass = (BuildingClassTypes) GC.getInfoTypeForString(szTextVal, true);

	return true;
}

//=====================================
// CvCorporationXMLEntries
//=====================================
/// Constructor
CvCorporationXMLEntries::CvCorporationXMLEntries(void)
{

}

/// Destructor
CvCorporationXMLEntries::~CvCorporationXMLEntries(void)
{
	DeleteArray();
}

/// Returns vector of Corporation entries
std::vector<CvCorporationEntry*>& CvCorporationXMLEntries::GetCorporationEntries()
{
	return m_paCorporationEntries;
}

/// Number of defined Corporations
int CvCorporationXMLEntries::GetNumCorporations()
{
	return m_paCorporationEntries.size();
}

/// Clear Corporation entries
void CvCorporationXMLEntries::DeleteArray()
{
	for(std::vector<CvCorporationEntry*>::iterator it = m_paCorporationEntries.begin(); it != m_paCorporationEntries.end(); ++it)
	{
		SAFE_DELETE(*it);
	}

	m_paCorporationEntries.clear();
}

/// Get a specific entry
CvCorporationEntry* CvCorporationXMLEntries::GetEntry(int index)
{
	return (index != NO_CORPORATION) ? m_paCorporationEntries[index] : NULL;
}

//=====================================
// CvCorporation
//=====================================

CvCorporation::CvCorporation()
	: m_eCorporation(NO_CORPORATION)
	, m_eFounder(NO_PLAYER)
	, m_iHeadquartersCityX(-1)
	, m_iHeadquartersCityY(-1)
	, m_iTurnFounded(-1)
{

}

CvCorporation::CvCorporation(CorporationTypes eCorporation, PlayerTypes eFounder, CvCity* pHeadquarters)
	: m_eCorporation(eCorporation)
	, m_eFounder(eFounder)
	, m_iHeadquartersCityX(-1)
	, m_iHeadquartersCityY(-1)
{
	if(pHeadquarters)
	{
		m_iHeadquartersCityX = pHeadquarters->getX();
		m_iHeadquartersCityY = pHeadquarters->getY();
	}
	m_iTurnFounded = GC.getGame().getGameTurn();
}

/// Serialization read
FDataStream& operator>>(FDataStream& loadFrom, CvCorporation& writeTo)
{
	uint uiVersion;
	loadFrom >> uiVersion;
	MOD_SERIALIZE_INIT_READ(loadFrom);

	loadFrom >> writeTo.m_eCorporation;
	loadFrom >> writeTo.m_eFounder;
	loadFrom >> writeTo.m_iHeadquartersCityX;
	loadFrom >> writeTo.m_iHeadquartersCityY;

	loadFrom >> writeTo.m_iTurnFounded;

	return loadFrom;
}

/// Serialization write
FDataStream& operator<<(FDataStream& saveTo, const CvCorporation& readFrom)
{
	uint uiVersion = 4;
	saveTo << uiVersion;
	MOD_SERIALIZE_INIT_WRITE(saveTo);

	saveTo << readFrom.m_eCorporation;
	saveTo << readFrom.m_eFounder;
	saveTo << readFrom.m_iHeadquartersCityX;
	saveTo << readFrom.m_iHeadquartersCityY;
	saveTo << readFrom.m_iTurnFounded;

	return saveTo;
}

// For some reason CvSerializationInfoHelpers is not working for this.
FDataStream& operator<<(FDataStream& saveTo, const CorporationTypes& readFrom)
{
	saveTo << static_cast<int>(readFrom);
	return saveTo;
}
FDataStream& operator>>(FDataStream& loadFrom, CorporationTypes& writeTo)
{
	int v;
	loadFrom >> v;
	writeTo = static_cast<CorporationTypes>(v);
	return loadFrom;
}

//=====================================
// CvPlayerCorporations
//=====================================
/// Constructor
CvPlayerCorporations::CvPlayerCorporations(void):
	m_pPlayer(NULL),
	m_eFoundedCorporation(NO_CORPORATION)
{
}

	/// Destructor
CvPlayerCorporations::~CvPlayerCorporations(void)
{
	Uninit();
}

/// Initialize class data
void CvPlayerCorporations::Init(CvPlayer* pPlayer)
{
	m_pPlayer = pPlayer;

	Reset();
}

/// Cleanup
void CvPlayerCorporations::Uninit()
{

}

/// Reset
void CvPlayerCorporations::Reset()
{
}

/// Serialization read
void CvPlayerCorporations::Read(FDataStream& kStream)
{
	// Version number to maintain backwards compatibility
	uint uiVersion;
	kStream >> uiVersion;
	MOD_SERIALIZE_INIT_READ(kStream);
}

/// Serialization write
void CvPlayerCorporations::Write(FDataStream& kStream)
{
	// Current version number
	uint uiVersion = 1;
	kStream << uiVersion;
	MOD_SERIALIZE_INIT_WRITE(kStream);
}

// Destroys all offices and franchises associated with this corporation
void CvPlayerCorporations::DestroyCorporation()
{
	if(!HasFoundedCorporation())
		return;

	CvCorporationEntry* pkCorporationInfo = GC.getCorporationInfo(m_eFoundedCorporation);
	if(pkCorporationInfo == NULL)
		return;

	BuildingClassTypes eHeadquartersClass = pkCorporationInfo->GetHeadquartersBuildingClass();
	BuildingClassTypes eOfficeClass = pkCorporationInfo->GetHeadquartersBuildingClass();
	BuildingClassTypes eFranchiseClass = pkCorporationInfo->GetHeadquartersBuildingClass();

	// Get Corporation Buildings
	BuildingTypes eHeadquarters = (BuildingTypes) m_pPlayer->getCivilizationInfo().getCivilizationBuildings(eHeadquartersClass);
	BuildingTypes eOffice = (BuildingTypes) m_pPlayer->getCivilizationInfo().getCivilizationBuildings(eOfficeClass);
	BuildingTypes eFranchise = (BuildingTypes) m_pPlayer->getCivilizationInfo().getCivilizationBuildings(eFranchiseClass);

	int iLoop = 0;
	// Destroy our headquarters and offices
	for(CvCity* pCity = m_pPlayer->firstCity(&iLoop); pCity != NULL; m_pPlayer->nextCity(&iLoop))
	{
		// City has headquarters?
		if(pCity->HasBuilding(eHeadquarters))
		{
			pCity->GetCityBuildings()->SetNumRealBuilding(eHeadquarters, 0);
		}

		// City has office?
		if(pCity->HasBuilding(eOffice))
		{
			pCity->GetCityBuildings()->SetNumRealBuilding(eOffice, 0);
		}
	}

	PlayerTypes eLoopPlayer;
	for(int iPlayerLoop=0; iPlayerLoop < MAX_CIV_PLAYERS; iPlayerLoop++)
	{
		eLoopPlayer = (PlayerTypes) iPlayerLoop;
		if(!GET_PLAYER(eLoopPlayer).isAlive()) continue;
		
		iLoop = 0;
		for(CvCity* pCity = GET_PLAYER(eLoopPlayer).firstCity(&iLoop); pCity != NULL; GET_PLAYER(eLoopPlayer).nextCity(&iLoop))
		{
			if(pCity->HasBuilding(eFranchise))
			{
				pCity->GetCityBuildings()->SetNumRealBuilding(eFranchise, 0);
			}
		}
	}

	SetFoundedCorporation(NO_CORPORATION);
}

void CvPlayerCorporations::SetFoundedCorporation(CorporationTypes eCorporation)
{
	m_eFoundedCorporation = eCorporation;
}

bool CvPlayerCorporations::HasFoundedCorporation() const
{
	return GetFoundedCorporation() != NO_CORPORATION;
}

CorporationTypes CvPlayerCorporations::GetFoundedCorporation() const
{
	return m_eFoundedCorporation;
}

//=====================================
// CvGameCorporations
//=====================================
/// Constructor
CvGameCorporations::CvGameCorporations(void)
{
}

/// Destructor
CvGameCorporations::~CvGameCorporations(void)
{

}

// Initialize class data
void CvGameCorporations::Init()
{

}

/// Handle turn-by-turn religious updates
void CvGameCorporations::DoTurn()
{
}

// Destroy eCorporation
void CvGameCorporations::DestroyCorporation(CorporationTypes eCorporation)
{
	for(std::vector<CvCorporation>::iterator it = m_ActiveCorporations.begin(); it != m_ActiveCorporations.end(); it++)
	{
		CvCorporation kCorporation = (*it);
		if(kCorporation.m_eCorporation == eCorporation)
		{
			PlayerTypes eCorporationFounder = kCorporation.m_eFounder;
			CvPlayer& kPlayer = GET_PLAYER(eCorporationFounder);

			// Destroy corporation for this player
			kPlayer.GetCorporations()->DestroyCorporation();
		}
	}
}

// ePlayer founds eCorporation
void CvGameCorporations::FoundCorporation(PlayerTypes ePlayer, CorporationTypes eCorporation, CvCity* pHeadquarters)
{
	// Cannot found this corporation
	if(!CanFoundCorporation(ePlayer, eCorporation))
		return;

	// Cannot found a corporation without a headquarters!
	if(pHeadquarters == NULL || pHeadquarters->getOwner() != ePlayer)
		return;

	CvPlayer& kPlayer = GET_PLAYER(ePlayer);
	CvCorporation kCorporation = CvCorporation(eCorporation, ePlayer, pHeadquarters);
	
	// Set the player's founded corporation
	kPlayer.GetCorporations()->SetFoundedCorporation(eCorporation);
	
	// Free office in headquarters
	CvCorporationEntry* pkCorporationInfo = GC.getCorporationInfo(eCorporation);
	BuildingClassTypes eOfficeClass = pkCorporationInfo->GetOfficeBuildingClass();
	if(eOfficeClass != NO_BUILDINGCLASS)
	{
		BuildingTypes eOffice = (BuildingTypes) GET_PLAYER(ePlayer).getCivilizationInfo().getCivilizationBuildings(eOfficeClass);
		pHeadquarters->GetCityBuildings()->SetNumFreeBuilding(eOffice, 1);
	}

	// Add corporation to game active corporations
	m_ActiveCorporations.push_back(kCorporation);

	// Push notification to all players
	PlayerTypes eLoopPlayer = NO_PLAYER;
	for(int iI = 0; iI < MAX_MAJOR_CIVS; iI++)
	{
		eLoopPlayer = (PlayerTypes) iI;
			
		if(!GET_PLAYER(eLoopPlayer).isAlive())
			continue;

		CvNotifications* pNotification = GET_PLAYER(eLoopPlayer).GetNotifications();
		if(!pNotification)
			continue;

		// We founded the Corporation
		if(ePlayer == eLoopPlayer)
		{
			Localization::String strMessage;
			Localization::String strSummary;
			strMessage = Localization::Lookup("TXT_KEY_CORPORATION_FOUNDED");
			strMessage << (pkCorporationInfo->GetDescriptionKey());
			strSummary = Localization::Lookup("TXT_KEY_CORPORATION_FOUNDED_SUMMARY");
			if(pNotification)
			{
				pNotification->Add(NOTIFICATION_GENERIC, strMessage.toUTF8(), strSummary.toUTF8(), -1, -1, -1, ePlayer);
			}
		}
		// Someone else founded the Corporation
		else
		{
			Localization::String strMessage;
			Localization::String strSummary;
			strMessage = Localization::Lookup("TXT_KEY_CORPORATION_FOUNDED_OTHER_PLAYER");

			// Notify player has met this team
			if(GET_TEAM(GET_PLAYER(ePlayer).getTeam()).isHasMet(GET_PLAYER(eLoopPlayer).getTeam()))
			{
				CvPlayerAI& player = GET_PLAYER(ePlayer);
				if(GC.getGame().isGameMultiPlayer() && player.isHuman())
					strMessage << player.getNickName();
				else
					strMessage << player.getName();
			}
			// Has not met this team
			else
			{
				Localization::String unmetPlayer = Localization::Lookup("TXT_KEY_UNMET_PLAYER");
				strMessage << unmetPlayer;
			}

			strMessage << (pkCorporationInfo->GetDescriptionKey());
			strSummary = Localization::Lookup("TXT_KEY_CORPORATION_FOUNDED_OTHER_PLAYER_SUMMARY");
			if(pNotification)
			{
				pNotification->Add(NOTIFICATION_GENERIC, strMessage.toUTF8(), strSummary.toUTF8(), -1, -1, -1, ePlayer);
			}
		}
	}
}

// Can eCorporation be founded?
bool CvGameCorporations::CanFoundCorporation(PlayerTypes ePlayer, CorporationTypes eCorporation) const
{
	// Player must be alive
	if(!GET_PLAYER(ePlayer).isAlive())
		return false;

	// Only major civs
	if(GET_PLAYER(ePlayer).isMinorCiv() || GET_PLAYER(ePlayer).isBarbarian())
		return false;

	// Must be a valid corporation
	if(eCorporation < 0 || eCorporation >= GC.getNumCorporationInfos())
		return false;

	// Corporation cannot be founded
	if(IsCorporationFounded(eCorporation))
		return false;

	return true;
}

// Has eCorporation been founded yet?
bool CvGameCorporations::IsCorporationFounded(CorporationTypes eCorporation) const
{
	for(std::vector<CvCorporation>::const_iterator it = m_ActiveCorporations.begin(); it != m_ActiveCorporations.end(); it++)
	{
		if((*it).m_eCorporation == eCorporation)
			return true;
	}

	return false;
}

/// Serialization read
FDataStream& operator>>(FDataStream& loadFrom, CvGameCorporations& writeTo)
{
	uint uiVersion;

	loadFrom >> uiVersion;
	MOD_SERIALIZE_INIT_READ(loadFrom);

	int iEntriesToRead;
	CvCorporation tempItem;

	writeTo.m_ActiveCorporations.clear();
	loadFrom >> iEntriesToRead;
	for(int iI = 0; iI < iEntriesToRead; iI++)
	{
		loadFrom >> tempItem;
		writeTo.m_ActiveCorporations.push_back(tempItem);
	}

	return loadFrom;
}

/// Serialization write
FDataStream& operator<<(FDataStream& saveTo, const CvGameCorporations& readFrom)
{
	uint uiVersion = 4;
	saveTo << uiVersion;
	MOD_SERIALIZE_INIT_WRITE(saveTo);

	std::vector<CvCorporation>::const_iterator it;
	saveTo << readFrom.m_ActiveCorporations.size();
	for(it = readFrom.m_ActiveCorporations.begin(); it != readFrom.m_ActiveCorporations.end(); it++)
	{
		saveTo << *it;
	}

	return saveTo;
}

#endif