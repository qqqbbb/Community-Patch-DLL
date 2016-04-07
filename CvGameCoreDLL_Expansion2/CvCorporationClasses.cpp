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

#endif