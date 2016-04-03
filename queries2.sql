SELECT ST_Distance(
  ST_GeometryFromText('POINT(-118.4079 33.9434)', 4326),
  ST_GeometryFromText('POINT(2.5559 49.0083)', 4326)
  );


SELECT id, data ->> 'name'
FROM   cities
WHERE  cities.point
    @
    ST_MakeEnvelope (ST_GeometryFromText('POINT(17.55649855078127 44.59601726663801'),
    ST_GeometryFromText('POINT(18.60294630468752 45.640616053432865'));


    CREATE TABLE airports (airport varchar(35), iata varchar(3), latitude float, longitude float);


ALTER TABLE airports ADD COLUMN gid serial PRIMARY KEY;

ALTER TABLE airports ADD COLUMN geom geometry(POINT,4326);


UPDATE airports SET geom = ST_SetSRID(ST_MakePoint(longitude,latitude),4326);

CREATE INDEX idx_airports_geom ON airports USING GIST(geom);

--ams
ne.toJSON()
Object {lat: 52.44360172117893, lng: 4.877245926269552}
sw.toJSON()
Object {lat: 52.22100669893884, lng: 4.6156339877929895}

--all NL
ne.toJSON()
Object {lat: 53.99701369900936, lng: 6.754191421875021}
sw.toJSON()
Object {lat: 50.42835907579381, lng: 2.5684004062500208}

--ams
SELECT *
FROM   airports
WHERE  airports.geom
    @
    ST_MakeEnvelope (2.5684004062500208, 50.42835907579381, 6.754191421875021, 53.99701369900936);
--sb
SELECT *
FROM   airports
WHERE  airports.geom
    @
    ST_MakeEnvelope (17.777598404296896, 44.86528699525853, 18.30082228125002, 45.37933006693625);

ALTER TABLE cities ADD COLUMN location geometry(POINT,4326);

UPDATE cities SET location = ST_SetSRID(ST_MakePoint(longitude,latitude),4326);

 update cities set location = ST_SetSRID(ST_MakePoint(18.182745987662596, 45.12148624972816), 4326) where id = 1020;
 update cities set location = ST_SetSRID(ST_MakePoint(15.620330028544704, 45.931486874245195), 4326) where id = 1021;
 update cities set location = ST_SetSRID(ST_MakePoint(15.720744877744817, 46.67735038546273), 4326) where id = 1022;
 update cities set location = ST_SetSRID(ST_MakePoint(22.559117385137807, 41.185201896245005), 4326) where id = 1023;
 update cities set location = ST_SetSRID(ST_MakePoint(21.370073048295453, 42.19233883966582), 4326) where id = 1024;
 update cities set location = ST_SetSRID(ST_MakePoint(19.24062981831459, 45.05329417972237), 4326) where id = 1025;
 update cities set location = ST_SetSRID(ST_MakePoint(22.789617148636175, 43.03797535823633), 4326) where id = 1026;
 update cities set location = ST_SetSRID(ST_MakePoint(20.417387225801477, 44.64665540113782), 4326) where id = 1027;
 update cities set location = ST_SetSRID(ST_MakePoint(21.5478518125, 42.551891396484), 4326) where id = 1028;
 update cities set location = ST_SetSRID(ST_MakePoint(27.138771209742593, 36.805099224266016), 4326) where id = 1029;
 update cities set location = ST_SetSRID(ST_MakePoint(26.242763215497117, 39.172495700881015), 4326) where id = 1030;
 update cities set location = ST_SetSRID(ST_MakePoint(23.731520963059328, 37.97212495658848), 4326) where id = 1031;
 update cities set location = ST_SetSRID(ST_MakePoint(26.03028640606146, 38.40350034870331), 4326) where id = 1032;
 update cities set location = ST_SetSRID(ST_MakePoint(26.816105144646993, 37.15716967523022), 4326) where id = 1033;
 update cities set location = ST_SetSRID(ST_MakePoint(22.51733676365528, 41.07339151067995), 4326) where id = 1034;
 update cities set location = ST_SetSRID(ST_MakePoint(26.824817547562535, 37.733387891251844), 4326) where id = 1035;

  insert into airports (airport, iata, latitude, longitude) values (
    'Slavonski Brod', 'SLV', 45.12148624972816, 18.182745987662596
  )

  UPDATE airports SET geom = ST_SetSRID(ST_MakePoint(longitude,latitude),4326) where gid = 6;


CREATE INDEX idx_cities_location ON cities USING GIST(location);


ne.toJSON()
Object {lat: 45.37933006693625, lng: 18.30082228125002}
sw.toJSON()
Object {lat: 44.86528699525853, lng: 17.777598404296896}




SELECT id, data ->> 'name'
FROM   cities
WHERE  cities.location
    @
    ST_MakeEnvelope (
        17.777598404296896, 44.86528699525853, 18.30082228125002, 45.37933006693625);
