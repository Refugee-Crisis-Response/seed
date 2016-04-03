import https from 'https';
import {eucrisis as options} from '../../config/settings';

export default class Point {

  constructor (mapper) {
    this.mapper = mapper;
  }

  list () {
    let query = 'select id, data from cities';
  }
}
