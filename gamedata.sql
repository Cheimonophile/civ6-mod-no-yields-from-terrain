
-- city center no extra yields
UPDATE GlobalParameters 
    SET Value = 0
    WHERE Name LIKE '%CITY_TERRAIN_REPLACE%';
INSERT OR REPLACE INTO Building_YieldChanges
    VALUES ('BUILDING_PALACE', 'YIELD_FOOD', 2);




-- Delete all terrain yields
DELETE FROM Terrain_YieldChanges;


-- Floodplains give +1 food
DELETE FROM Feature_YieldChanges
    WHERE FeatureType LIKE '%FLOODPLAINS%';
INSERT INTO Feature_YieldChanges 
    SELECT FeatureType, 'YIELD_FOOD', 1
    FROM Features
    WHERE FeatureType LIKE '%FLOODPLAINS%';


-- Update Marshes
UPDATE Features 
    SET Removable = 0
    WHERE FeatureType = 'FEATURE_MARSH';
UPDATE Features_XP2
    SET ValidWonderPlacement = 1, 
        ValidDistrictPlacement = 1
    WHERE FeatureType = 'FEATURE_MARSH';
INSERT OR REPLACE INTO Improvement_ValidFeatures (ImprovementType, FeatureType)
    VALUES ('IMPROVEMENT_FARM', 'FEATURE_MARSH');


-- Allow fishing boats on all coast and lake tiles
INSERT OR REPLACE INTO Improvement_ValidTerrains (ImprovementType, TerrainType)
    VALUES ('IMPROVEMENT_FISHING_BOATS', 'TERRAIN_COAST');
s


