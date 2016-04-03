import https from 'https';
import {eucrisis as options}  from './config/settings';
import Mapper from './lib/mappers/postgres';
import Country from './lib/models/Country';
import City from './lib/models/City';
import Point from './lib/models/Point';

let mapper = new Mapper();
let country = new Country(mapper);
let city = new City(mapper);
let point = new Point(mapper);

country.list((err, results) => {
  if (err) {
    console.log(err);
    process.exit(0);
  }
  let countries = results.rows;
  for (let i = 0, len = countries.length; i < len; i++) {
    city.get(countries[i], (_err, _results) => {
      if (_err) {
        console.log(_err);
        process.exit(0);
      }
      console.log(_results);
    });
  }
  //process.exit(0);
});
