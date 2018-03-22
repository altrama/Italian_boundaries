@echo off
cd %~dp0\data
SET FILE=01012018_g



SET SHAPEFILE="%~dp0data\Limiti%FILE%\Com%FILE%\Com%FILE%_WGS84.shp"
SET OUTPUTFILE="%~dp0build\comuni"

If NOT exist %SHAPEFILE% (
    %~dp0bin\win\wget.exe http://www.istat.it/storage/cartografia/confini_amministrativi/generalizzati/Limiti%FILE%.zip
    %~dp0bin\win\unzip.exe Limiti%FILE%.zip
) 

call "C:\OSGeo4W64\bin\o4w_env.bat"

echo Conversione Comuni
ogr2ogr.exe  -lco GEOMETRY=AS_WKT -t_srs EPSG:4326 -f "CSV" %OUTPUTFILE%.csv %SHAPEFILE%
ogr2ogr.exe  -t_srs EPSG:4326 -f "GEOJSON" %OUTPUTFILE%.geojson %SHAPEFILE%

echo Conversione Province e città metropolitane

SET SHAPEFILE="%~dp0data\Limiti%FILE%\ProvCM%FILE%\ProvCM%FILE%_WGS84.shp"
SET OUTPUTFILE="%~dp0build\province"

ogr2ogr.exe  -lco GEOMETRY=AS_WKT -t_srs EPSG:4326 -f "CSV" %OUTPUTFILE%.csv %SHAPEFILE%
ogr2ogr.exe  -t_srs EPSG:4326 -f "GEOJSON" %OUTPUTFILE%.geojson %SHAPEFILE%

echo Conversione Regioni e città metropolitane
SET SHAPEFILE="%~dp0data\Limiti%FILE%\Reg%FILE%\Reg%FILE%_WGS84.shp"
SET OUTPUTFILE="%~dp0build\regioni"

ogr2ogr.exe  -lco GEOMETRY=AS_WKT -t_srs EPSG:4326 -f "CSV" %OUTPUTFILE%.csv %SHAPEFILE%
ogr2ogr.exe  -t_srs EPSG:4326 -f "GEOJSON" %OUTPUTFILE%.geojson %SHAPEFILE%

echo done