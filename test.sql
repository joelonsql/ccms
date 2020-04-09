BEGIN;

SET search_path TO ccms, public;

SELECT New_Hospital('NKS','Nya Karolinska');
SELECT New_Hospital('HS','Huddinge');
SELECT New_Hospital('SÖS','Södersjukhuset');
SELECT New_Hospital('DS','Danderyds Sjukhus');
SELECT New_Hospital('S:tG','S:t Göran');
SELECT Hospital('NKS');

SELECT New_UnitType('Akutvårdavdelning');
SELECT UnitType('Akutvårdavdelning');

SELECT New_Unit('Akutvårdavdelning','NKS','AVA');
SELECT Unit('NKS','AVA');

SELECT New_ResourceType('Vårdplats','Sängplats');
SELECT New_ResourceType('USKa','Undersköterska');
SELECT New_ResourceType('SSKa','Skjuksköterska');
SELECT New_ResourceType('LÄK','Läkare');
SELECT ResourceType('LÄK');

SELECT * FROM Hospitals;
SELECT * FROM UnitTypes;
SELECT * FROM Units;
SELECT * FROM ResourceTypes;

ROLLBACK;
