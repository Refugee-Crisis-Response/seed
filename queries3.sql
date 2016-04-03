ne.toJSON()
Object {lat: 46.58026809938073, lng: 22.55802442968752}
sw.toJSON()
Object {lat: 42.426168529031884, lng: 18.37223341406252}


SELECT id, data ->> 'name' as name
FROM   cities
WHERE  cities.geo
    @
    ST_MakeEnvelope (
        18.37223341406252, 42.426168529031884, 22.55802442968752, 46.58026809938073);



 10006 | Slovenia  | si
 10007 | Croatia   | hr
 10008 | Serbia    | rs
 10009 | Macedonia | mk
 10010 | Greece    | gr


 INSERT INTO countries (name, slug) VALUES ('Slovenia', 'si');
 INSERT INTO countries (name, slug) VALUES ('Croatia', 'hr');
 INSERT INTO countries (name, slug) VALUES ('Serbia', 'rs');
 INSERT INTO countries (name, slug) VALUES ('Macedonia', 'mk');
 INSERT INTO countries (name, slug) VALUES ('Greece', 'gr');
