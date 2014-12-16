-- America -- Unique settler - Frontiersman - can defend from attacks.
DELETE FROM Units
WHERE Type = 'UNIT_AMERICAN_B17' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Civilization_UnitClassOverrides
WHERE UnitType = 'UNIT_AMERICAN_B17' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_AITypes
WHERE UnitType = 'UNIT_AMERICAN_B17' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_ClassUpgrades
WHERE UnitType = 'UNIT_AMERICAN_B17' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_FreePromotions
WHERE UnitType = 'UNIT_AMERICAN_B17' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_Flavors
WHERE UnitType = 'UNIT_AMERICAN_B17' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_ResourceQuantityRequirements
WHERE UnitType = 'UNIT_AMERICAN_B17' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM UnitGameplay2DScripts
WHERE UnitType = 'UNIT_AMERICAN_B17' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Arabia -- Faith Instead of Luxury Doubling from Bazaar -- Units move faster in Desert -- Boosted Religion over Trade route spread.
UPDATE Buildings
SET ExtraLuxuries = 'false'
WHERE Type = 'BUILDING_BAZAAR' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Provides +3 [ICON_PEACE] Faith. +1 [ICON_GOLD] Gold for every 4 [ICON_CITIZEN] Citizens in the City. Each source of [ICON_RES_OIL] Oil and each Oasis provides +2 [ICON_GOLD] Gold. Trade routes other players make to a city with a Bazaar will generate an extra 1 [ICON_GOLD] Gold for the city owner and the trade route owner gains an additional 1 [ICON_GOLD] Gold for the trade route.'
WHERE Tag = 'TXT_KEY_BUILDING_BAZAAR_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'All land military units move twice as fast in the Desert. Caravans gain 50% extended range, and your trade routes spread religion much more effectively. [ICON_OIL] Oil resources are doubled.'
WHERE Tag = 'TXT_KEY_TRAIT_LAND_TRADE_GOLD2' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_CITY_HAPPINESS' AND Value= 1 );

UPDATE Traits
SET TradeReligionModifier = '150'
WHERE Type = 'TRAIT_LAND_TRADE_GOLD' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Aztec -- Set Floating Garden to +1 Food per 4 citizens instead of +15%
UPDATE Language_en_US
SET Text = '+1 [ICON_FOOD] Food for every 4 [ICON_CITIZEN] Citizens in the City. Each worked Lake tile provides +2 [ICON_FOOD] Food.[NEWLINE][NEWLINE]City must be built next to a River or Lake.'
WHERE Tag = 'TXT_KEY_BUILDING_FLOATING_GARDENS_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_CITY_HAPPINESS' AND Value= 1 );

UPDATE Buildings
SET PrereqTech = 'TECH_CONSTRUCTION'
WHERE Type = 'BUILDING_FLOATING_GARDENS' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

-- Askia -- Boost Mosque
UPDATE Building_YieldChanges
SET Yield = '3'
WHERE BuildingType = 'BUILDING_MUD_PYRAMID_MOSQUE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Building_ClassesNeededInCity
WHERE BuildingType = 'BUILDING_MUD_PYRAMID_MOSQUE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Buildings
SET MinorityHappinessChange = '1'
WHERE Type = 'BUILDING_MUD_PYRAMID_MOSQUE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_CITY_HAPPINESS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Requires no [ICON_GOLD] Gold maintenance. Reduces [ICON_HAPPINESS_3] Religious Unrest, and grants +1 [ICON_CULTURE] Culture from [ICON_RES_INCENSE] Incense and [ICON_RES_WINE] Wine resources nearby.'
WHERE Tag = 'TXT_KEY_BUILDING_MUD_PYRAMID_MOSQUE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_CITY_HAPPINESS' AND Value= 1 );

-- Darius -- Adjust Satrap
UPDATE Language_en_US
SET Text = 'City must have a Market. +1 [ICON_GOLD] Gold for every 4 [ICON_CITIZEN] Citizens in the City. Trade routes other players make to a city with a Satraps Court will generate an extra 1 [ICON_GOLD] Gold for the city owner and the trade route owner gains an additional 1 [ICON_GOLD] Gold for the trade route.'
WHERE Tag = 'TXT_KEY_BUILDING_SATRAPS_COURT_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_CITY_HAPPINESS' AND Value= 1 );

UPDATE Buildings
SET Happiness = '1'
WHERE Type = 'BUILDING_SATRAPS_COURT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_CITY_HAPPINESS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'City must have a Market.'
WHERE Tag = 'TXT_KEY_BUILDING_SATRAPS_COURT_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_CITY_HAPPINESS' AND Value= 1 );

-- Egypt 
DELETE FROM Building_ClassesNeededInCity
WHERE BuildingType = 'BUILDING_BURIAL_TOMB' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Requires no [ICON_GOLD] Gold maintenance. Reduces [ICON_HAPPINESS_3] Religious Unrest, and grants +1 [ICON_CULTURE] Culture from [ICON_RES_INCENSE] Incense and [ICON_RES_WINE] Wine resources nearby. Receive 25 [ICON_PEACE] Faith upon construction, and 5 [ICON_GOLDEN_AGE] Golden Age points whenever you are victorious in battle. Bonuses scale with era.[NEWLINE][NEWLINE]Should this city be captured, the amount of [ICON_GOLD] Gold plundered by the enemy is doubled.'
WHERE Tag = 'TXT_KEY_BUILDING_BURIAL_TOMB_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_CITY_HAPPINESS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'The Burial Tomb is a Classical-era building which increases your output of [ICON_PEACE] Faith, and costs no maintenance for the city. However, if the city is captured, the capturing civilization will gain twice as much gold as would be the case in a city without a Burial Tomb.  It replaces the Temple.'
WHERE Tag = 'TXT_KEY_BUILDING_BURIAL_TOMB_STRATEGY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_CITY_HAPPINESS' AND Value= 1 );

UPDATE Buildings
SET Happiness = '0'
WHERE Type = 'BUILDING_BURIAL_TOMB' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_CITY_HAPPINESS' AND Value= 1 );

UPDATE Buildings
SET MinorityHappinessChange = '2'
WHERE Type = 'BUILDING_BURIAL_TOMB' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_CITY_HAPPINESS' AND Value= 1 );

INSERT INTO Building_ResourceYieldChanges (
BuildingType, ResourceType, YieldType, Yield)
SELECT 'BUILDING_BURIAL_TOMB', 'RESOURCE_INCENSE', 'YIELD_FAITH', '1'
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

INSERT INTO Building_ResourceYieldChanges (
BuildingType, ResourceType, YieldType, Yield)
SELECT 'BUILDING_BURIAL_TOMB', 'RESOURCE_WINE', 'YIELD_FAITH', '1'
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Germany -- New UA

-- Bismarck -- Hanse Yield Per Pop
UPDATE Language_en_US
SET Text = 'Unique German Bank replacement. +5% [ICON_PRODUCTION] Production for each Trade Route your civilization has with a City-State, and +1 [ICON_GOLD] Gold for every 4 [ICON_CITIZEN] Citizens in the City. Trade routes other players make to a city with a Hanse will generate an extra 1 [ICON_GOLD] Gold for the city owner and the trade route owner gains an additional 1 [ICON_GOLD] Gold for the trade route.'
WHERE Tag = 'TXT_KEY_BUILDING_HANSE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_CITY_HAPPINESS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Receive +3 [ICON_GOLD] Gold in all owned cities for every City-State you are allied with. For every 3 City-State alliances, receive 1 additional vote in the World Congress.'
WHERE Tag = 'TXT_KEY_TRAIT_CONVERTS_LAND_BARBARIANS' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Realpolitik'
WHERE Tag = 'TXT_KEY_TRAIT_CONVERTS_LAND_BARBARIANS_SHORT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET VotePerXCSAlliance = '3'
WHERE Type = 'TRAIT_CONVERTS_LAND_BARBARIANS' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET LandBarbarianConversionPercent = '0'
WHERE Type = 'TRAIT_CONVERTS_LAND_BARBARIANS' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );
UPDATE Traits
SET LandUnitMaintenanceModifier = '0'
WHERE Type = 'TRAIT_CONVERTS_LAND_BARBARIANS' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );


-- Greece -- +2 Culture per city -- Odeon
DELETE FROM Units
WHERE Type = 'UNIT_GREEK_COMPANIONCAVALRY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Civilization_UnitClassOverrides
WHERE UnitType = 'UNIT_GREEK_COMPANIONCAVALRY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_AITypes
WHERE UnitType = 'UNIT_GREEK_COMPANIONCAVALRY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_ClassUpgrades
WHERE UnitType = 'UNIT_GREEK_COMPANIONCAVALRY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_FreePromotions
WHERE UnitType = 'UNIT_GREEK_COMPANIONCAVALRY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_Flavors
WHERE UnitType = 'UNIT_GREEK_COMPANIONCAVALRY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_ResourceQuantityRequirements
WHERE UnitType = 'UNIT_GREEK_COMPANIONCAVALRY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM UnitGameplay2DScripts
WHERE UnitType = 'UNIT_GREEK_COMPANIONCAVALRY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'City-State [ICON_INFLUENCE] Influence degrades at half and recovers at twice the normal rate. +2 [ICON_CULTURE] Culture in every City.'
WHERE Tag = 'TXT_KEY_TRAIT_CITY_STATE_FRIENDSHIP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Ancient Era Unit which specializes in defeating Mounted Units. Only the Greeks may build it. This Unit has a higher [ICON_STRENGTH] Combat Strength than the Spearman which it replaces, and helps produce Great Generals more quickly.'
WHERE Tag = 'TXT_KEY_UNIT_HELP_HOPLITE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- India -- Indus Sanitation (replace Mughal Fort) -- Unhappiness from Poverty and Illiteracy reduced by 25% 
DELETE FROM Buildings
WHERE Type = 'BUILDING_MUGHAL_FORT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Civilization_BuildingClassOverrides
WHERE BuildingType = 'BUILDING_MUGHAL_FORT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Building_ClassesNeededInCity
WHERE BuildingType = 'BUILDING_MUGHAL_FORT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Building_Flavors
WHERE BuildingType = 'BUILDING_MUGHAL_FORT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

DELETE FROM Building_YieldChanges
WHERE BuildingType = 'BUILDING_MUGHAL_FORT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

DELETE FROM Building_TechEnhancedYieldChanges
WHERE BuildingType = 'BUILDING_MUGHAL_FORT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

UPDATE Traits
SET PopulationUnhappinessModifier = '0'
WHERE Type = 'TRAIT_POPULATION_GROWTH' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET CityUnhappinessModifier = '0'
WHERE Type = 'TRAIT_POPULATION_GROWTH' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET PopulationBoostReligion = 'true'
WHERE Type = 'TRAIT_POPULATION_GROWTH' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET IsNoReligiousStrife = 'true'
WHERE Type = 'TRAIT_POPULATION_GROWTH' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Cannot build Missionaries or gain [ICON_HAPPINESS_3] Unhappiness from Religious Strife. Pressure for your majority Religion increases in owned cities based on the number of [ICON_CITIZEN] Followers in them. Starts with enough [ICON_PEACE] Faith for a Pantheon.'
WHERE Tag = 'TXT_KEY_TRAIT_POPULATION_GROWTH' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Font of Dharma'
WHERE Tag = 'TXT_KEY_TRAIT_POPULATION_GROWTH_SHORT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Iroquois -- All units receive Woodsman promotion
UPDATE Language_en_US
SET Text = 'Units move through Forest and Jungle in friendly territory as if it is Road. These tiles can be used to establish [ICON_CONNECTED] Trade Routes upon researching The Wheel. All land military units receive the Woodsman promotion for free.'
WHERE Tag = 'TXT_KEY_TRAIT_IGNORE_TERRAIN_IN_FOREST' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Building_YieldChanges
SET Yield = '4'
WHERE BuildingType = 'BUILDING_LONGHOUSE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Building_YieldChanges
SET Yield = '4'
WHERE BuildingType = 'BUILDING_LONGHOUSE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Buildings
SET PrereqTech = 'TECH_STEEL'
WHERE Type = 'BUILDING_LONGHOUSE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

-- Japan -- Dojo (culture from strategic resources) -- Boost UA
DELETE FROM Units
WHERE Type = 'UNIT_JAPANESE_ZERO' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Civilization_UnitClassOverrides
WHERE UnitType = 'UNIT_JAPANESE_ZERO' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_AITypes
WHERE UnitType = 'UNIT_JAPANESE_ZERO' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_ClassUpgrades
WHERE UnitType = 'UNIT_JAPANESE_ZERO' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_FreePromotions
WHERE UnitType = 'UNIT_JAPANESE_ZERO' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_Flavors
WHERE UnitType = 'UNIT_JAPANESE_ZERO' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM UnitGameplay2DScripts
WHERE UnitType = 'UNIT_JAPANESE_ZERO' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'The [ICON_STRENGTH] Combat Strength of your units increases as they take damage. +1 [ICON_CULTURE] Culture from each Fishing Boat and +2 [ICON_CULTURE] Culture from each Atoll.'
WHERE Tag = 'TXT_KEY_TRAIT_FIGHT_WELL_DAMAGED' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Napoleon -- Plunders artwork!
UPDATE Traits
SET FreeGreatWorkOnConquest = 'true'
WHERE Type = 'TRAIT_ENHANCED_CULTURE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Theming bonuses doubled in [ICON_CAPITAL] Capital. Plunder [ICON_GREAT_WORK] Great Works of Art based on the number of empty slots in your empire. If none can be plundered, receive a temporary [ICON_CULTURE] Culture boost based on the population of the conquered city.'
WHERE Tag = 'TXT_KEY_TRAIT_ENHANCED_CULTURE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Riches of Conquest'
WHERE Tag = 'TXT_KEY_TRAIT_ENHANCED_CULTURE_SHORT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

INSERT INTO Language_en_US (Text, Tag)
SELECT 'Napoleon stole {1_Num} [ICON_GREAT_WORK] Great Work(s) of Art from you when he conquered {2_City}!' , 'TXT_KEY_ART_PLUNDERED'
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

INSERT INTO Language_en_US (Text, Tag)
SELECT 'Art stolen!' , 'TXT_KEY_ART_PLUNDERED_SUMMARY'
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

INSERT INTO Language_en_US (Text, Tag)
SELECT 'You plundered {1_Num} [ICON_GREAT_WORK] Great Work(s) of Art from the conquest of {2_City}!' , 'TXT_KEY_ART_STOLEN'
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

INSERT INTO Language_en_US (Text, Tag)
SELECT 'Art plundered!' , 'TXT_KEY_ART_STOLEN_SUMMARY'
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

INSERT INTO Language_en_US (Text, Tag)
SELECT 'The conquest of {2_City} has doubled your [ICON_CULTURE] Culture output for the next {1_Num} turn(s)!' , 'TXT_KEY_CULTURE_BOOST_ART'
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

INSERT INTO Language_en_US (Text, Tag)
SELECT 'Culture boost!' , 'TXT_KEY_CULTURE_BOOST_ART_SUMMARY'
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = '[ICON_BULLET][COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] from a temporary Cultural Boost (Turns left: {2_TurnsLeft}).'
WHERE Tag = 'TXT_KEY_TP_CULTURE_FROM_BONUS_TURNS' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Ottomans -- Receive a free Caravansary in all cities, and Trade Routes generate Golden Age points when finishing a Trade Route. 
UPDATE Traits
SET NavalUnitMaintenanceModifier = '0'
WHERE Type = 'TRAIT_CONVERTS_SEA_BARBARIANS' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET FreeBuilding = 'BUILDING_CARAVANSARY'
WHERE Type = 'TRAIT_CONVERTS_SEA_BARBARIANS' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Trait_FreePromotionUnitCombats
WHERE TraitType = 'TRAIT_CONVERTS_SEA_BARBARIANS' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Innovation Through Commerce'
WHERE Tag = 'TXT_KEY_TRAIT_CONVERTS_SEA_BARBARIANS_SHORT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Receive 40 [ICON_RESEARCH] Science and [ICON_GOLDEN_AGE] Golden Age Points every time you complete an [ICON_INTERNATIONAL_TRADE] International Trade Route, and a free Caravansary in every city.'
WHERE Tag = 'TXT_KEY_TRAIT_CONVERTS_SEA_BARBARIANS' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Rome -- Unique Monument (Triumphal Arch) -- Receive Culture boost when you conquer a City.
DELETE FROM Units
WHERE Type = 'UNIT_ROMAN_BALLISTA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Civilization_UnitClassOverrides
WHERE UnitType = 'UNIT_ROMAN_BALLISTA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_AITypes
WHERE UnitType = 'UNIT_ROMAN_BALLISTA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_ClassUpgrades
WHERE UnitType = 'UNIT_ROMAN_BALLISTA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_FreePromotions
WHERE UnitType = 'UNIT_ROMAN_BALLISTA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_Flavors
WHERE UnitType = 'UNIT_ROMAN_BALLISTA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_ResourceQuantityRequirements
WHERE UnitType = 'UNIT_ROMAN_BALLISTA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM UnitGameplay2DScripts
WHERE UnitType = 'UNIT_ROMAN_BALLISTA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Siam -- adjust Wat
UPDATE Building_FeatureYieldChanges
SET Yield = '1'
WHERE BuildingType = 'BUILDING_WAT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = '+1 [ICON_RESEARCH] Science from Jungle tiles worked by this City, and 75 [ICON_RESEARCH] Science every time a new [ICON_CITIZEN] Citizen is born in this City. Reduces [ICON_HAPPINESS_3] Illiteracy.[NEWLINE][NEWLINE]City must have a Library.'
WHERE Tag = 'TXT_KEY_BUILDING_WAT_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Buildings
SET SpecialistCount = '1'
WHERE Type = 'BUILDING_WAT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- China

UPDATE Buildings
SET IlliteracyHappinessChange = '1'
WHERE Type = 'BUILDING_PAPER_MAKER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_CITY_HAPPINESS' AND Value= 1 );

UPDATE Language_en_US
SET Text = '+1 [ICON_RESEARCH] for every three [ICON_CITIZEN] Citizens in the City. Reduces [ICON_HAPPINESS_3] Illiteracy. +2[ICON_GOLD] Gold.'
WHERE Tag = 'TXT_KEY_BUILDING_PAPER_MAKER_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

UPDATE Building_YieldChangesPerPop
SET Yield = '33'
WHERE BuildingType = 'BUILDING_PAPER_MAKER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_CITY_HAPPINESS' AND Value= 1 );
 
UPDATE Buildings
SET SpecialistCount = '1'
WHERE Type = 'BUILDING_PAPER_MAKER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Buildings
SET SpecialistType = 'SPECIALIST_SCIENTIST'
WHERE Type = 'BUILDING_PAPER_MAKER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );


-- Babylon 

UPDATE Buildings
SET ExtraCityHitPoints = '125'
WHERE Type = 'BUILDING_WALLS_OF_BABYLON' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'The Walls of Babylon are a Babylonian Unique Building, replacing the standard city Walls. The Walls of Babylon increase Defense Strength in a city by 6 and Hit Points by 125, the latter almost double that of standard Walls.'
WHERE Tag = 'TXT_KEY_CIV5_BABYLON_WALLS_STRATEGY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

