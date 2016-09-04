// Micro:bit beacon

var heartBeat = [
  " 111 ",
  "1   1",
  "1   1",
  "1   1",
  " 111 "
].join("\n");

var ping = [
  "11111",
  "1 1 1",
  "11111",
  "1 1 1",
  "11111"
].join("\n");

var eddyStoneData = [
  0x03,  // Length of Service List
  0x03,  // Param: Service List
  0xAA, 0xFE,  // Eddystone ID
  0x13,  // Length of Service Data
  0x16,  // Service Data
  0xAA, 0xFE, // Eddystone ID
  0x10,  // Frame type: URL
  0xF8, // Power
  0x03, // https://
  'g',
  'o',
  'o',
  '.',
  'g',
  'l',
  '/',
  'T',
  'b',
  '0',
  '1',
  'T',
  'R'
];

var state = "";
setInterval(function() {
  state = state === "" ? heartBeat : "";
  show(state);
}, 500);

// search for other beacons
NRF.setScan(function(d) {
  show(ping);
});

// broadcast eddystone data
NRF.setAdvertising(eddyStoneData,{interval:1000});
