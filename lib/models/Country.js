export default class Country {

  constructor (mapper) {
    this.mapper = mapper;
  }

  list (done) {
    let query = 'select id, name, slug from countries';
    this.mapper.query(query, [], done);
  }

  get (countryId, done) {
    let query = 'select id, name, slug from countries where id = $1';
    this.mapper.query(query, [countryId], done);
  }
}
