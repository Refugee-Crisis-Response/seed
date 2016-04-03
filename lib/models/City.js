import https from 'https';
import {eucrisis as options} from '../../config/settings';

const appendCountryToPath = (country) => {
  let token = '=';
  let tokens = options.path.split(token);
  options.path = tokens[0] + token + country;
};

const setFields = (city) => {
  let fields = {};
  fields.lat = city.location.coordinates[1];
  fields.lng = city.location.coordinates[0];
  return fields;
};

export default class City {

  constructor (mapper) {
    this.mapper = mapper;
  }

  get (country, _done) {
    appendCountryToPath(country.slug);
    //console.log('path', options.path, 'slug', country.slug);
    let done = _done;
    console.log('country', country, 'done', done);
    let req = https.request(options, (resp) => {
      let data = '';
      resp.on('data', (d) => {
      data += d;
      });

      resp.on('end', () => {
        let cities = JSON.parse(data);
        for (let i = 0, len = cities.length; i < len; i++) {
          let city = cities[i];
          delete city.id;
          let fields = setFields(city);
          let query = 'insert into cities (country_id, data, lat, lng, geo) values ($1, $2, $3, $4, ST_SetSRID(ST_MakePoint($4, $3), 4326))';
          this.mapper.query(query, [country.id, city, fields.lat, fields.lng], done);
        }
      });
    });

    req.on('error', (ex) => {
      console.log(ex);
      //done(ex);
    });

    req.end();
  }
}
