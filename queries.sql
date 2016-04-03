ne.toJSON()
Object {lat: 48.12455353078961, lng: 18.16898634375002}
sw.toJSON()
Object {lat: 44.01916340271047, lng: 13.98319532812502}



ne.toJSON()
Object {lat: 45.640616053432865, lng: 18.60294630468752}
sw.toJSON()
Object {lat: 44.59601726663801, lng: 17.55649855078127}



SELECT *
FROM mytable
WHERE
  mytable.geom &&
  ST_Transform(ST_MakeEnvelope(minLon, minLat, maxLon, maxLat, 4326), 2223);



select *
from cities
where
  cities.point &&
  ST_Transform(ST_MakeEnvelope(44.01916340271047, 13.98319532812502, 48.12455353078961, 18.16898634375002, 4326), 2223)



  alter table cities add CONSTRAINT enforce_dims_geom CHECK (st_ndims(point) = 2)
  alter table cities add CONSTRAINT enforce_srid_geom CHECK (st_srid(point) = 4326)


  update cities set point = (select data -> 'location' ->> 'coordinates');


 update cities set point = ST_GeomFromText('POINT(45.12148624972816 18.182745987662596)', 4326) where id = 1020;
 update cities set point = ST_GeomFromText('POINT(45.931486874245195 15.620330028544704)', 4326) where id = 1021;
 update cities set point = ST_GeomFromText('POINT(46.67735038546273 15.720744877744817)', 4326) where id = 1022;
 update cities set point = ST_GeomFromText('POINT(41.185201896245005 22.559117385137807)', 4326) where id = 1023;
 update cities set point = ST_GeomFromText('POINT(42.19233883966582 21.370073048295453)', 4326) where id = 1024;
 update cities set point = ST_GeomFromText('POINT(45.05329417972237 19.24062981831459)', 4326) where id = 1025;
 update cities set point = ST_GeomFromText('POINT(43.03797535823633 22.789617148636175)', 4326) where id = 1026;
 update cities set point = ST_GeomFromText('POINT(44.64665540113782 20.417387225801477)', 4326) where id = 1027;
 update cities set point = ST_GeomFromText('POINT(42.551891396484 21.5478518125)', 4326) where id = 1028;
 update cities set point = ST_GeomFromText('POINT(36.805099224266016 27.138771209742593)', 4326) where id = 1029;
 update cities set point = ST_GeomFromText('POINT(39.172495700881015 26.242763215497117)', 4326) where id = 1030;
 update cities set point = ST_GeomFromText('POINT(37.97212495658848 23.731520963059328)', 4326) where id = 1031;
 update cities set point = ST_GeomFromText('POINT(38.40350034870331 26.03028640606146)', 4326) where id = 1032;
 update cities set point = ST_GeomFromText('POINT(37.15716967523022 26.816105144646993)', 4326) where id = 1033;
 update cities set point = ST_GeomFromText('POINT(41.07339151067995 22.51733676365528)', 4326) where id = 1034;
 update cities set point = ST_GeomFromText('POINT(37.733387891251844 26.824817547562535)', 4326) where id = 1035;





SELECT id, data ->> 'name'
FROM   cities
WHERE  cities.location
    @
    ST_MakeEnvelope (17.55649855078127, 44.59601726663801, 18.60294630468752, 45.640616053432865, 4326);

SELECT id, data ->> 'name'
FROM   cities
WHERE  cities.point
    @
    ST_MakeEnvelope (17.55649855078127, 44.59601726663801, 18.60294630468752, 45.640616053432865);


SELECT id, data ->> 'name'
FROM   cities
WHERE  point
    &&
    ST_MakeEnvelope (
        13.98319532812502, 44.01916340271047, 18.16898634375002, 48.12455353078961, 4326);

SELECT id, data ->> 'name'
FROM   cities
WHERE  point
    &&
    ST_MakeEnvelope (
        18.16898634375002, 48.12455353078961, 13.98319532812502, 44.01916340271047, 4326);

CREATE INDEX city_places_gix ON cities USING GIST (point);



SELECT
  ST_Equals(ST_GeomFromEWKT('SRID=4326;POINTM(-122.161445617676 37.444938659668 1336176082171)'),
  ST_PointFromText('POINT(-122.161445617676 37.444938659668)', 4326));


  SELECT * FROM cities WHERE point @ ST_MakeEnvelope(-122, 37,-121, 38, 4326);
