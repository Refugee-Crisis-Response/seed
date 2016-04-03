import pg from 'pg';
import {pgsql as settings} from '../../config/settings';

let client;

export default class CourseData {

  constructor () {
    client = new pg.Client(settings.connectString);
    client.connect();
  }

  query (query, params, done) {
    client.query(query, params, (err, result) => {
      if (err) {
        return done(err);
      }
      done(null, result);
    });
  }
}
