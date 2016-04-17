#pragma once

#ifndef CIV5_CORPORATION_CLASSES_H
#define CIV5_CORPORATION_CLASSES_H

#if defined(MOD_BALANCE_CORE)

#include "CvWeightedVector.h"

class CvCorporationEntry: public CvBaseInfo
{
public:
	CvCorporationEntry(void);
	~CvCorporationEntry(void);
	
	virtual bool CacheResults(Database::Results& kResults, CvDatabaseUtility& kUtility);

	int GetMaxFranchises() const;
	BuildingClassTypes GetHeadquartersBuildingClass() const;
	BuildingClassTypes GetOfficeBuildingClass() const;
	BuildingClassTypes GetFranchiseBuildingClass() const;

	int GetTradeRouteSpeedModifier() const;
	int GetNumFreeTradeRoutes() const;
	bool IsTradeRoutesInvulnerable() const;
	int GetTradeRouteVisionBoost() const;

	int GetResourceMonopolyAnd(int i) const;
	int GetResourceMonopolyOr(int i) const;
	int GetNumFreeResource(int i) const;

	int GetTradeRouteMod(int i) const;
protected:
	BuildingClassTypes m_eHeadquartersBuildingClass;
	BuildingClassTypes m_eOfficeBuildingClass;
	BuildingClassTypes m_eFranchiseBuildingClass;

	int m_iTradeRouteSpeedModifier;
	int m_iNumFreeTradeRoutes;
	int m_iMaxFranchises;
	int m_bTradeRoutesInvulnerable;
	int m_iTradeRouteVisionBoost;

	int* m_piResourceMonopolyAnd;
	int* m_piResourceMonopolyOrs;
	int* m_piNumFreeResource;

	int* m_piTradeRouteMod;
private:
	CvCorporationEntry(const CvCorporationEntry&);
	CvCorporationEntry& operator=(const CvCorporationEntry&);
};

class CvCorporationXMLEntries
{
public:
	CvCorporationXMLEntries(void);
	~CvCorporationXMLEntries(void);

	// Accessor functions
	std::vector<CvCorporationEntry*>& GetCorporationEntries();
	int GetNumCorporations();
	CvCorporationEntry* GetEntry(int index);

	void DeleteArray();

private:
	std::vector<CvCorporationEntry*> m_paCorporationEntries;
};

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  CLASS: CvCorporation
//!  \brief All the information about a single corporation
//
//!  Key Attributes:
//!  - Stores the founder and headquarter city
//!	 - Stores the statistics for the corporation
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class CvCorporation
{
public:
	CvCorporation();
	CvCorporation(CorporationTypes eCorporation, PlayerTypes eFounder, CvCity* pHeadquarters);

	bool IsCorporationBuilding(BuildingClassTypes eBuildingClass);

	// Public data
	CorporationTypes m_eCorporation;
	PlayerTypes m_eFounder;
	int m_iHeadquartersCityX;
	int m_iHeadquartersCityY;

	int m_iTurnFounded;
};

FDataStream& operator>>(FDataStream&, CvCorporation&);
FDataStream& operator<<(FDataStream&, const CvCorporation&);

FDataStream& operator>>(FDataStream&, CorporationTypes&);
FDataStream& operator<<(FDataStream&, const CorporationTypes&);

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  CLASS:		CvPlayerCorporations
//!  \brief		All the information about corporations for a player
//
//!  Key Attributes:
//!  - This object is created inside the CvPlayer object and accessed through CvPlayer
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
class CvPlayerCorporations
{
public:
	CvPlayerCorporations(void);
	~CvPlayerCorporations(void);
	void Init(CvPlayer* pPlayer);
	void Uninit();
	void Reset();
	void Read(FDataStream& kStream);
	void Write(FDataStream& kStream);

	CvCorporation* GetCorporation() const;

	CvCity* GetHeadquarters() const;

	void DoTurn();

	int GetAdditionalNumFranchises() const;
	void ChangeAdditionalNumFranchises(int iChange);

	int GetAdditionalNumFranchisesMod() const;
	void ChangeAdditionalNumFranchisesMod(int iChange);

	int GetMaxNumFranchises() const;
	int GetNumFranchises() const;

	int GetNumOffices() const;

	void RecalculateNumOffices();
	void RecalculateNumFranchises();

	void BuildFranchiseInCity(CvCity* pOriginCity, CvCity* pDestCity);
	void BuildRandomFranchiseInCity();

	CvString GetCurrentOfficeBenefit();

	void ClearCorporationFromCity(CvCity* pCity);

	bool HasFoundedCorporation() const;
	CorporationTypes GetFoundedCorporation() const;
	void SetFoundedCorporation(CorporationTypes eCorporation);
	void DestroyCorporation();

	bool IsCorporationOfficesAsFranchises() const;
	void SetCorporationOfficesAsFranchises(bool bValue);

	bool IsCorporationRandomForeignFranchise() const;
	void SetCorporationRandomForeignFranchise(bool bValue);

	bool IsCorporationFreeFranchiseAbovePopular() const;
	void SetCorporationFreeFranchiseAbovePopular(bool bValue);

private:
	CvPlayer* m_pPlayer;
	CorporationTypes m_eFoundedCorporation;

	int m_iNumOffices;
	int m_iNumFranchises;
	int m_iAdditionalNumFranchises;
	int m_iAdditionalNumFranchisesMod;

	bool m_bCorporationOfficesAsFranchises;
	bool m_bCorporationRandomForeignFranchise;
	bool m_bCorporationFreeFranchiseAbovePopular;
};

typedef FStaticVector<CvCorporation, 16, false, c_eCiv5GameplayDLL > CorporationList;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  CLASS:		CvGameCorporations
//!  \brief		All the information about corporations founded and active in the game
//
//!  Key Attributes:
//!  - Core data in this class is a list of CvCorporations
//!  - This object is created inside the CvGame object and accessed through CvGame
//!  - Provides convenience functions to the other game subsystems to quickly summarize
//!    information on the corporations in place
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
class CvGameCorporations
{
public:
	CvGameCorporations(void);
	~CvGameCorporations(void);

	void Init();
	void DoTurn();

	CvCorporation* GetCorporation(CorporationTypes eCorporation);
	int GetNumActiveCorporations() const;

	void DestroyCorporation(CorporationTypes eCorporation);
	void FoundCorporation(PlayerTypes ePlayer, CorporationTypes eCorporation, CvCity* pHeadquarters);
	bool CanFoundCorporation(PlayerTypes ePlayer, CorporationTypes eCorporation) const;

	bool IsCorporationFounded(CorporationTypes eCorporation) const;
	bool IsCorporationHeadquarters(CvCity* pCity) const;

	CorporationList m_ActiveCorporations;
};

FDataStream& operator>>(FDataStream&, CvGameCorporations&);
FDataStream& operator<<(FDataStream&, const CvGameCorporations&);

#endif
#endif