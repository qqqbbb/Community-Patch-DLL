-- Attila

UPDATE Traits
SET LandBarbarianConversionPercent = '100'
WHERE Type = 'TRAIT_RAZE_AND_HORSES' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET RazeSpeedModifier = '0'
WHERE Type = 'TRAIT_RAZE_AND_HORSES' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Civilization_FreeTechs
WHERE TechType = 'TECH_ANIMAL_HUSBANDRY' AND CivilizationType = 'CIVILIZATION_HUNS' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Trait_ImprovementYieldChanges
WHERE TraitType = 'TRAIT_RAZE_AND_HORSES' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Eki

INSERT INTO ArtDefine_LandmarkTypes(Type, LandmarkType, FriendlyName)
SELECT 'ART_DEF_IMPROVEMENT_EKI', 'Improvement', 'Eki';

INSERT INTO ArtDefine_Landmarks(Era, State, Scale, ImprovementType, LayoutHandler, ResourceType, Model, TerrainContour)
SELECT 'Any', 'UnderConstruction', 1,  'ART_DEF_IMPROVEMENT_EKI', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'eki_UC.fxsxml', 1 UNION ALL
SELECT 'Any', 'Constructed', 1,  'ART_DEF_IMPROVEMENT_EKI', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'eki_built.fxsxml', 1 UNION ALL
SELECT 'Any', 'Pillaged', 1,  'ART_DEF_IMPROVEMENT_EKI', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'eki_PL.fxsxml', 1;

-- Boudicca -- Boost Ceilidh Hall -- Move to Medieval, add faith
UPDATE Buildings
SET PrereqTech = 'TECH_PHYSICS'
WHERE Type = 'BUILDING_CEILIDH_HALL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Buildings
SET BuildingClass = 'BUILDINGCLASS_CIRCUS'
WHERE Type = 'BUILDING_CEILIDH_HALL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Buildings 
SET Help = 'TXT_KEY_BUILDING_CEILIDH_HALL_HELP'
WHERE Type = 'BUILDING_CEILIDH_HALL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

INSERT INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT 'BUILDING_CEILIDH_HALL', 'RESOURCE_IVORY' , 'YIELD_CULTURE' , '3'
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

UPDATE Building_YieldChanges
SET Yield = '3'
WHERE BuildingType = 'BUILDING_CEILIDH_HALL' AND YieldType = 'YIELD_CULTURE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Buildings
SET Happiness = '1'
WHERE Type = 'BUILDING_CEILIDH_HALL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Buildings
SET SpecialistType = 'SPECIALIST_MUSICIAN'
WHERE Type = 'BUILDING_CEILIDH_HALL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Buildings
SET SpecialistCount = '1'
WHERE Type = 'BUILDING_CEILIDH_HALL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Civilization_BuildingClassOverrides
SET BuildingClassType = 'BUILDINGCLASS_CIRCUS'
WHERE BuildingType = 'BUILDING_CEILIDH_HALL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Building_ClassesNeededInCity
Set BuildingClassType = 'BUILDINGCLASS_COLOSSEUM'
WHERE BuildingType = 'BUILDING_CEILIDH_HALL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET UniqueBeliefsOnly = '1'
WHERE Type = 'TRAIT_FAITH_FROM_NATURE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET NoNaturalReligionSpread = '1'
WHERE Type = 'TRAIT_FAITH_FROM_NATURE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET FaithFromUnimprovedForest = '0'
WHERE Type = 'TRAIT_FAITH_FROM_NATURE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Dido -- Delete African Forest Elephant, remove mountain bonus (given to incans)

UPDATE Traits
Set CrossesMountainsAfterGreatGeneral = '0'
WHERE Type = 'TRAIT_PHOENICIAN_HERITAGE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET TradeRouteResourceModifier = '200'
WHERE Type = 'TRAIT_PHOENICIAN_HERITAGE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Gustavus Adolphus -- Remove Hakkepillita, add unique Public School

-- Remove Sweden Tundra bias

DELETE FROM Civilization_Start_Region_Priority
WHERE CivilizationType = 'CIVILIZATION_SWEDEN' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET GreatPersonGiftInfluence = '0'
WHERE Type = 'TRAIT_DIPLOMACY_GREAT_PEOPLE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET DOFGreatPersonModifier = '0'
WHERE Type = 'TRAIT_DIPLOMACY_GREAT_PEOPLE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET InspirationalLeader = '1'
WHERE Type = 'TRAIT_DIPLOMACY_GREAT_PEOPLE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Selassie -- Peace Treaty Bonuss

UPDATE Traits
SET IsAdoptionFreeTech = '1'
WHERE Type = 'TRAIT_BONUS_AGAINST_TECH' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET CombatBonusVsLargerCiv = '0'
WHERE Type = 'TRAIT_BONUS_AGAINST_TECH' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Building_YieldChanges
SET Yield = '2'
WHERE BuildingType = 'BUILDING_STELE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_CITY_HAPPINESS' AND Value= 1 );

UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_STELE_HELP'
WHERE Type = 'BUILDING_STELE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_CITY_HAPPINESS' AND Value= 1 );

UPDATE Buildings
SET PlotCultureCostModifier = '-33'
WHERE Type = 'BUILDING_STELE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );
	
-- Theodora -- Basilica UB (Replace Dromon)

UPDATE Traits
SET AnyBelief = '1'
WHERE Type = 'TRAIT_EXTRA_BELIEF' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET AlwaysReligion = '1'
WHERE Type = 'TRAIT_EXTRA_BELIEF' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- William -- Change Polder (more gold, less food) -- New Trait
UPDATE Traits
SET LuxuryHappinessRetention = '0'
WHERE Type = 'TRAIT_LUXURY_RETENTION' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Improvements
SET FreshWaterMakesValid = '1'
WHERE Type = 'IMPROVEMENT_POLDER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Improvements
SET RequiresFeature = '0'
WHERE Type = 'IMPROVEMENT_POLDER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Improvement_ValidFeatures
WHERE ImprovementType = 'IMPROVEMENT_POLDER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Improvement_Yields
SET Yield = '3'
WHERE ImprovementType = 'IMPROVEMENT_POLDER' AND YieldType = 'YIELD_FOOD' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Maria Theresa -- Coffee House +2 Production, +2 Food.

UPDATE Defines SET Value = '20' WHERE Name = 'MINOR_CIV_BUYOUT_TURNS';

UPDATE Traits
SET DiplomaticMarriage = '1'
WHERE Type = 'TRAIT_ANNEX_CITY_STATE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET AbleToAnnexCityStates = '0'
WHERE Type = 'TRAIT_ANNEX_CITY_STATE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Buildings
SET BuildingProductionModifier = '0'
WHERE Type = 'BUILDING_COFFEE_HOUSE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

UPDATE Buildings
SET GreatPeopleRateModifier = '33'
WHERE Type = 'BUILDING_COFFEE_HOUSE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

UPDATE Buildings
SET FoodKept = '25'
WHERE Type = 'BUILDING_COFFEE_HOUSE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

UPDATE Building_YieldChanges
SET Yield = '3'
WHERE BuildingType = 'BUILDING_COFFEE_HOUSE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

UPDATE Building_YieldChanges
SET YieldType = 'YIELD_FOOD'
WHERE BuildingType = 'BUILDING_COFFEE_HOUSE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

UPDATE Civilization_BuildingClassOverrides
SET BuildingClassType = 'BUILDINGCLASS_GROCER'
WHERE BuildingType = 'BUILDING_COFFEE_HOUSE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Buildings
SET BuildingClass = 'BUILDINGCLASS_GROCER'
WHERE Type = 'BUILDING_COFFEE_HOUSE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Buildings
SET SpecialistType = 'SPECIALIST_MERCHANT'
WHERE Type = 'BUILDING_COFFEE_HOUSE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Buildings
SET PrereqTech = 'TECH_CHEMISTRY'
WHERE Type = 'BUILDING_COFFEE_HOUSE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Maya -- Move Pyramid to Agriculture, Bring UA back to Mathematics

UPDATE Traits
SET PrereqTech = 'TECH_MATHEMATICS'
WHERE Type = 'TRAIT_LONG_COUNT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Buff Atlatl, move to Classical Age
-- Eki

INSERT INTO ArtDefine_LandmarkTypes(Type, LandmarkType, FriendlyName)
SELECT 'ART_DEF_IMPROVEMENT_KUNA', 'Improvement', 'Kuna';

INSERT INTO ArtDefine_Landmarks (Era, State, Scale,	ImprovementType,					LayoutHandler,	ResourceType,					Model,						TerrainContour) VALUES
('Any', 'UnderConstruction',	0.4,  				'ART_DEF_IMPROVEMENT_KUNA',		'SNAPSHOT',		'ART_DEF_RESOURCE_ALL',		'hb_kuna.fxsxml',			1	),
('Any', 'Constructed',			0.4,  				'ART_DEF_IMPROVEMENT_KUNA',		'SNAPSHOT',		'ART_DEF_RESOURCE_ALL',		'kuna.fxsxml',				1	),
('Any', 'Pillaged',				0.4,  				'ART_DEF_IMPROVEMENT_KUNA',		'SNAPSHOT',		'ART_DEF_RESOURCE_ALL',		'pl_kuna.fxsxml',			1	);

DELETE FROM Buildings
WHERE Type = 'BUILDING_MAYA_PYRAMID';

DELETE FROM Building_YieldChanges
WHERE BuildingType = 'BUILDING_MAYA_PYRAMID';

DELETE FROM Civilization_BuildingClassOverrides
WHERE BuildingType = 'BUILDING_MAYA_PYRAMID';

UPDATE Civilization_Start_Region_Priority
SET RegionType = 'REGION_JUNGLE'
WHERE CivilizationType = 'CIVILIZATION_MAYA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- NEW
INSERT INTO Beliefs
	(Type, Description, ShortDescription, Pantheon, CivilizationType)
VALUES
	('BELIEF_MORRIGAN', 'TXT_KEY_BELIEF_MORRIGAN', 'TXT_KEY_BELIEF_MORRIGAN_SHORT', '1', 'CIVILIZATION_CELTS'),
	('BELIEF_EPONA', 'TXT_KEY_BELIEF_EPONA', 'TXT_KEY_BELIEF_EPONA_SHORT', '1', 'CIVILIZATION_CELTS'),
	('BELIEF_NUADA', 'TXT_KEY_BELIEF_NUADA', 'TXT_KEY_BELIEF_NUADA_SHORT', '1', 'CIVILIZATION_CELTS'),
	('BELIEF_CERNUNNOS', 'TXT_KEY_BELIEF_CERNUNNOS', 'TXT_KEY_BELIEF_CERNUNNOS_SHORT', '1', 'CIVILIZATION_CELTS'),
	('BELIEF_LUGH', 'TXT_KEY_BELIEF_LUGH', 'TXT_KEY_BELIEF_LUGH_SHORT', '1', 'CIVILIZATION_CELTS'),
	('BELIEF_RHIANNON', 'TXT_KEY_BELIEF_RHIANNON', 'TXT_KEY_BELIEF_RHIANNON_SHORT', '1', 'CIVILIZATION_CELTS'),
	('BELIEF_MANANNAN', 'TXT_KEY_BELIEF_MANANNAN', 'TXT_KEY_BELIEF_MANANNAN_SHORT', '1', 'CIVILIZATION_CELTS'),
	('BELIEF_OGMA', 'TXT_KEY_BELIEF_OGMA', 'TXT_KEY_BELIEF_OGMA_SHORT', '1', 'CIVILIZATION_CELTS'),
	('BELIEF_BRAN', 'TXT_KEY_BELIEF_BRAN', 'TXT_KEY_BELIEF_BRAN_SHORT', '1', 'CIVILIZATION_CELTS'),
	('BELIEF_DAGDA', 'TXT_KEY_BELIEF_DAGDA', 'TXT_KEY_BELIEF_DAGDA_SHORT', '1', 'CIVILIZATION_CELTS');

INSERT INTO Belief_YieldFromKills
	(BeliefType, YieldType, Yield)
VALUES
	('BELIEF_MORRIGAN', 'YIELD_GOLD', 70),
	('BELIEF_MORRIGAN', 'YIELD_CULTURE', 70),
	('BELIEF_MORRIGAN', 'YIELD_GOLDEN_AGE_POINTS', 50);

INSERT INTO Belief_YieldPerBorderGrowth
	(BeliefType, YieldType, Yield)
VALUES
	('BELIEF_EPONA', 'YIELD_SCIENCE', 15),
	('BELIEF_EPONA', 'YIELD_CULTURE', 15),
	('BELIEF_EPONA', 'YIELD_FOOD', 15);

INSERT INTO Belief_YieldPerScience
	(BeliefType, YieldType, Yield)
VALUES
	('BELIEF_NUADA', 'YIELD_GOLDEN_AGE_POINTS', 10);

INSERT INTO Belief_YieldPerGPT
	(BeliefType, YieldType, Yield)
VALUES
	('BELIEF_NUADA', 'YIELD_CULTURE', 15);

INSERT INTO Belief_FeatureYieldChanges
	(BeliefType, FeatureType, YieldType, Yield)
VALUES
	('BELIEF_CERNUNNOS', 'FEATURE_FOREST', 'YIELD_FOOD', 1),
	('BELIEF_CERNUNNOS', 'FEATURE_JUNGLE', 'YIELD_PRODUCTION', 1);

INSERT INTO Belief_YieldChangeAnySpecialist
	(BeliefType, YieldType, Yield)
VALUES
	('BELIEF_LUGH', 'YIELD_CULTURE', 4),
	('BELIEF_LUGH', 'YIELD_GOLD', 4),
	('BELIEF_LUGH', 'YIELD_SCIENCE', 4);

INSERT INTO Belief_YieldChangeWorldWonder
	(BeliefType, YieldType, Yield)
VALUES
	('BELIEF_LUGH', 'YIELD_CULTURE', 1);

INSERT INTO Belief_YieldPerFollowingCity
	(BeliefType, YieldType, Yield)
VALUES
	('BELIEF_RHIANNON', 'YIELD_GOLD', 2),
	('BELIEF_RHIANNON', 'YIELD_SCIENCE', 2),
	('BELIEF_RHIANNON', 'YIELD_GOLDEN_AGE_POINTS', 2),
	('BELIEF_BRAN', 'YIELD_CULTURE', 1);

INSERT INTO Belief_CoastalCityYieldChanges
	(BeliefType, YieldType, Yield)
VALUES
	('BELIEF_MANANNAN', 'YIELD_FOOD', 2),
	('BELIEF_MANANNAN', 'YIELD_PRODUCTION', 3),
	('BELIEF_MANANNAN', 'YIELD_GOLD', 4);

INSERT INTO Belief_YieldPerPop
	(BeliefType, YieldType, Yield)
VALUES
	('BELIEF_OGMA', 'YIELD_SCIENCE', 4);

INSERT INTO Belief_YieldPerBirth
	(BeliefType, YieldType, Yield)
VALUES
	('BELIEF_OGMA', 'YIELD_CULTURE', 8);

INSERT INTO Belief_YieldPerXFollowers
	(BeliefType, YieldType, PerXFollowers)
VALUES
	('BELIEF_DAGDA', 'YIELD_GOLD', 5),
	('BELIEF_DAGDA', 'YIELD_CULTURE', 5),
	('BELIEF_DAGDA', 'YIELD_PRODUCTION', 5),
	('BELIEF_DAGDA', 'YIELD_SCIENCE', 5);


UPDATE Beliefs
SET Tooltip = 'TXT_KEY_BELIEF_MORRIGAN'
WHERE Type = 'BELIEF_MORRIGAN' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_RELIGION' AND Value= 1 );

UPDATE Beliefs
SET Tooltip = 'TXT_KEY_BELIEF_EPONA'
WHERE Type = 'BELIEF_EPONA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_RELIGION' AND Value= 1 );

UPDATE Beliefs
SET Tooltip = 'TXT_KEY_BELIEF_NUADA'
WHERE Type = 'BELIEF_NUADA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_RELIGION' AND Value= 1 );

UPDATE Beliefs
SET Tooltip = 'TXT_KEY_BELIEF_CERNUNNOS'
WHERE Type = 'BELIEF_CERNUNNOS' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_RELIGION' AND Value= 1 );

UPDATE Beliefs
SET Tooltip = 'TXT_KEY_BELIEF_LUGH'
WHERE Type = 'BELIEF_LUGH' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_RELIGION' AND Value= 1 );

UPDATE Beliefs
SET Tooltip = 'TXT_KEY_BELIEF_RHIANNON'
WHERE Type = 'BELIEF_RHIANNON' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_RELIGION' AND Value= 1 );

UPDATE Beliefs
SET Tooltip = 'TXT_KEY_BELIEF_MANANNAN'
WHERE Type = 'BELIEF_MANANNAN' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_RELIGION' AND Value= 1 );

UPDATE Beliefs
SET Tooltip = 'TXT_KEY_BELIEF_OGMA'
WHERE Type = 'BELIEF_OGMA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_RELIGION' AND Value= 1 );

UPDATE Beliefs
SET Tooltip = 'TXT_KEY_BELIEF_BRAN'
WHERE Type = 'BELIEF_BRAN' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_RELIGION' AND Value= 1 );

UPDATE Beliefs
SET Tooltip = 'TXT_KEY_BELIEF_DAGDA'
WHERE Type = 'BELIEF_DAGDA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_RELIGION' AND Value= 1 );



INSERT INTO Trait_YieldFromOwnPantheon
	(TraitType, YieldType, Yield)
VALUES
	('TRAIT_FAITH_FROM_NATURE', 'YIELD_FAITH', 3);

INSERT INTO Building_YieldChanges
	(BuildingType, YieldType, Yield)
VALUES
	('BUILDING_CEILIDH_HALL', 'YIELD_FAITH', 1);

INSERT INTO Building_InstantYield
	(BuildingType, YieldType, Yield)
VALUES
	('BUILDING_CEILIDH_HALL', 'YIELD_CULTURE', 100);

INSERT INTO Improvement_Yields
	(ImprovementType, YieldType, Yield)
VALUES
	('IMPROVEMENT_POLDER', 'YIELD_GOLD', 2),
	('IMPROVEMENT_POLDER', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_EKI', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_EKI', 'YIELD_FOOD', 1),
	('IMPROVEMENT_EKI', 'YIELD_CULTURE', 1),
	('IMPROVEMENT_KUNA', 'YIELD_SCIENCE', 1),
	('IMPROVEMENT_KUNA', 'YIELD_FAITH', 2);


INSERT INTO Improvement_AdjacentImprovementYieldChanges
	(ImprovementType, OtherImprovementType, YieldType, Yield)
VALUES
	('IMPROVEMENT_POLDER', 'IMPROVEMENT_TRADING_POST', 'YIELD_GOLD', 1),
	('IMPROVEMENT_POLDER', 'IMPROVEMENT_CUSTOMS_HOUSE', 'YIELD_GOLD', 1);

INSERT INTO Civilization_Start_Along_River
	(CivilizationType, StartAlongRiver)
VALUES
	('CIVILIZATION_NETHERLANDS', 1);

INSERT INTO Trait_YieldFromImport
	(TraitType, YieldType, Yield)
VALUES
	('TRAIT_LUXURY_RETENTION', 'YIELD_CULTURE', 4);

INSERT INTO Trait_YieldFromExport
	(TraitType, YieldType, Yield)
VALUES
	('TRAIT_LUXURY_RETENTION', 'YIELD_GOLD', 4);

INSERT INTO Trait_YieldFromSettle
	(TraitType, YieldType, Yield)
VALUES
	('TRAIT_PHOENICIAN_HERITAGE', 'YIELD_GOLD', 200);

INSERT INTO Trait_TerrainClaimBoost
	(TraitType, TerrainType)
VALUES
	('TRAIT_RAZE_AND_HORSES', 'TERRAIN_GRASS'),
	('TRAIT_RAZE_AND_HORSES', 'TERRAIN_PLAINS');

INSERT INTO Building_GoldenAgeYieldMod
	(BuildingType, YieldType, Yield)
VALUES
	('BUILDING_STELE', 'YIELD_FAITH', 25);

INSERT INTO Building_ScienceFromYield
	(BuildingType, YieldType, Yield)
VALUES
	('BUILDING_COFFEE_HOUSE', 'YIELD_CULTURE', 10);

INSERT INTO Building_ClassesNeededInCity
	(BuildingType, BuildingClassType)
VALUES
	('BUILDING_COFFEE_HOUSE', 'BUILDINGCLASS_AQUEDUCT');

INSERT INTO Building_ClassesNeededInCity
	(BuildingType, BuildingClassType)
VALUES
	('BUILDING_SKOLA', 'BUILDINGCLASS_UNIVERSITY'),
	('BUILDING_BASILICA', 'BUILDINGCLASS_MONUMENT'),
	('BUILDING_GREAT_COTHON', 'BUILDINGCLASS_MARKET');

INSERT INTO Building_Flavors
	(BuildingType, FlavorType, Flavor)
VALUES
	('BUILDING_SKOLA', 'FLAVOR_SCIENCE', 100),
	('BUILDING_SKOLA', 'FLAVOR_GREAT_PEOPLE', 5),
	('BUILDING_SKOLA', 'FLAVOR_HAPPINESS', 25),
	('BUILDING_BASILICA', 'FLAVOR_RELIGION', 100),
	('BUILDING_BASILICA', 'FLAVOR_GOLD', 10),
	('BUILDING_GREAT_COTHON', 'FLAVOR_GOLD', 75),
	('BUILDING_GREAT_COTHON', 'FLAVOR_I_TRADE_ORIGIN', 75),
	('BUILDING_GREAT_COTHON', 'FLAVOR_I_TRADE_DESTINATION', 75);

INSERT INTO Civilization_BuildingClassOverrides
	(CivilizationType, BuildingClassType, BuildingType)
VALUES
	('CIVILIZATION_SWEDEN', 'BUILDINGCLASS_PUBLIC_SCHOOL', 'BUILDING_SKOLA'),
	('CIVILIZATION_BYZANTIUM', 'BUILDINGCLASS_TEMPLE', 'BUILDING_BASILICA'),
	('CIVILIZATION_CARTHAGE', 'BUILDINGCLASS_NATIONAL_TREASURY', 'BUILDING_GREAT_COTHON');

INSERT INTO Building_YieldChangesPerPop
	(BuildingType, YieldType, Yield)
VALUES
	('BUILDING_SKOLA', 'YIELD_SCIENCE', 34),
	('BUILDING_SKOLA', 'YIELD_CULTURE', 20),
	('BUILDING_BASILICA', 'YIELD_FAITH', 50);

INSERT INTO Building_ResourceYieldChanges
	(BuildingType, ResourceType, YieldType, Yield)
VALUES
	('BUILDING_BASILICA', 'RESOURCE_INCENSE', 'YIELD_CULTURE', 1),
	('BUILDING_BASILICA', 'RESOURCE_INCENSE', 'YIELD_FAITH', 1),
	('BUILDING_BASILICA', 'RESOURCE_WINE', 'YIELD_CULTURE', 1),
	('BUILDING_BASILICA', 'RESOURCE_WINE', 'YIELD_FAITH', 1);

INSERT INTO Building_BuildingClassYieldChanges
	(BuildingType, BuildingClassType, YieldType, YieldChange)
VALUES
	('BUILDING_GREAT_COTHON', 'BUILDINGCLASS_HARBOR', 'YIELD_PRODUCTION', 3);

-- New Improvements

INSERT INTO Builds
	(Type, Time, ImprovementType, PrereqTech, Description, Help, Recommendation, EntityEvent, HotKey, OrderPriority, IconIndex, IconAtlas)
VALUES
	('BUILD_EKI', 800, 'IMPROVEMENT_EKI', 'TECH_HORSEBACK_RIDING', 'TXT_KEY_BUILD_EKI', 'TXT_KEY_BUILD_EKI_HELP', 'TXT_KEY_BUILD_EKI_REC', 'ENTITY_EVENT_BUILD', 'KB_E', 1, 0, 'UNIT_ACTION_EKI'),
	('BUILD_KUNA', 700, 'IMPROVEMENT_KUNA', 'TECH_AGRICULTURE', 'TXT_KEY_BUILD_KUNA', 'TXT_KEY_BUILD_KUNA_HELP', 'TXT_KEY_BUILD_KUNA_REC', 'ENTITY_EVENT_BUILD', 'KB_E', 1, 0, 'UNIT_ACTION_KUNA');

INSERT INTO BuildFeatures
	(BuildType, FeatureType, PrereqTech, Time, Production, Remove)
VALUES
	('BUILD_EKI', 'FEATURE_JUNGLE', 'TECH_IRON_WORKING', 700, 15, 1),
	('BUILD_EKI', 'FEATURE_FOREST', 'TECH_BRONZE_WORKING', 400, 20, 1),
	('BUILD_EKI', 'FEATURE_MARSH', 'TECH_MACHINERY', 400, 0, 1);

INSERT INTO Improvements
	(Type, Description, Civilopedia, Help, ArtDefineTag, SpecificCivRequired, CivilizationType, InAdjacentFriendly, NoFreshWater, RequiresFlatlands, PortraitIndex, PillageGold, IconAtlas, NoTwoAdjacent, RequiresFeature)
VALUES
	('IMPROVEMENT_EKI', 'TXT_KEY_IMPROVEMENT_EKI', 'TXT_KEY_CIV5_IMPROVEMENTS_EKI_TEXT', 'TXT_KEY_CIV5_IMPROVEMENTS_EKI_HELP', 'ART_DEF_IMPROVEMENT_EKI', 1, 'CIVILIZATION_HUNS', 1, 1, 1, 0, 20, 'TERRAIN_IMPROVEMENT_EKI', 0, 0),
	('IMPROVEMENT_KUNA', 'TXT_KEY_IMPROVEMENT_KUNA', 'TXT_KEY_CIV5_IMPROVEMENTS_KUNA_TEXT', 'TXT_KEY_CIV5_IMPROVEMENTS_KUNA_HELP', 'ART_DEF_IMPROVEMENT_KUNA', 1, 'CIVILIZATION_MAYA', 0, 0, 0, 0, 40, 'TERRAIN_IMPROVEMENT_KUNA', 1, 1);

INSERT INTO Improvement_ValidTerrains
	(ImprovementType, TerrainType)
VALUES
	('IMPROVEMENT_EKI', 'TERRAIN_GRASS'),
	('IMPROVEMENT_EKI', 'TERRAIN_PLAINS');

INSERT INTO Improvement_ValidFeatures
	(ImprovementType, FeatureType)
VALUES
	('IMPROVEMENT_KUNA', 'FEATURE_FOREST'),
	('IMPROVEMENT_KUNA', 'FEATURE_JUNGLE');
	
INSERT INTO Improvement_YieldAdjacentTwoSameType
	(ImprovementType, YieldType, Yield)
VALUES
	('IMPROVEMENT_EKI', 'YIELD_PRODUCTION', 1);

INSERT INTO Improvement_TechYieldChanges
	(ImprovementType, TechType, YieldType, Yield)
VALUES
	('IMPROVEMENT_EKI', 'TECH_ECONOMICS', 'YIELD_GOLD', 1),
	('IMPROVEMENT_EKI', 'TECH_FERTILIZER', 'YIELD_FOOD', 1),
	('IMPROVEMENT_EKI', 'TECH_ECOLOGY', 'YIELD_PRODUCTION', 2),
	('IMPROVEMENT_KUNA', 'TECH_MATHEMATICS', 'YIELD_SCIENCE', 1),
	('IMPROVEMENT_KUNA', 'TECH_ASTRONOMY', 'YIELD_SCIENCE', 1),
	('IMPROVEMENT_KUNA', 'TECH_FLIGHT', 'YIELD_CULTURE', 2),
	('IMPROVEMENT_KUNA', 'TECH_ARCHAEOLOGY', 'YIELD_SCIENCE', 2);

INSERT INTO Unit_Builds
	(UnitType, BuildType)
VALUES
	('UNIT_WORKER', 'BUILD_EKI'),
	('UNIT_WORKER', 'BUILD_KUNA');