
-- city center no extra yields
UPDATE GlobalParameters 
    SET Value = 0
    WHERE Name LIKE '%CITY_TERRAIN_REPLACE%';



-- Delete all terrain yields
DELETE FROM Terrain_YieldChanges;
INSERT INTO Terrain_YieldChanges (TerrainType, YieldType, YieldChange)
    SELECT TerrainType, 'YIELD_FOOD', 1
    FROM Terrains
    WHERE TerrainType LIKE '%GRASS%' OR 
        TerrainType LIKE '%PLAINS%' OR
        TerrainType LIKE '%COAST%';
DELETE FROM Feature_YieldChanges
    WHERE FeatureType LIKE '%FLOODPLAINS%';

-- Weather events don't change tile yields
DELETE FROM RandomEvent_Yields;


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


