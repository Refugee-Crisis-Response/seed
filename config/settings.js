const pgsql = {
  'connectString': 'pg://refugeuser@localhost:5432/refuge'
};
const eucrisis = {
  'host': 'refugeeinfo.eu',
  'path': '/api/locations/?country=country',
  'port': 443,
  'method': 'GET',
  'headers': {
    'Content-Type': 'application/json; charset=utf-8'
  }
};

const sheets = {
  'camps': '1vukwVcn_wlCCa-ZMQ2Jva3Yw_S7Whkf-bKjGo7OhMS8',

}
export {pgsql, eucrisis}
