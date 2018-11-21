// Generated by LiveScript 1.5.0
(function(){
  var nem, proxy, mainnet, testnet, type, enabled, token, image, out$ = typeof exports != 'undefined' && exports || this;
  nem = require('nem-sdk')['default'];
  proxy = 'https://cors-anywhere.herokuapp.com/';
  out$.mainnet = mainnet = {
    id: 104,
    prefix: "68",
    char: "N",
    api: {
      provider: 'nem',
      nodeAddress: nem.model.nodes.defaultMainnet,
      nodePort: nem.model.nodes.defaultPort,
      url: nem.model.nodes.mainnetExplorer,
      apiUrl: proxy + "http://chain.nem.ninja/api3"
    }
  };
  out$.testnet = testnet = {
    id: -104,
    prefix: "98",
    char: "T",
    api: {
      provider: 'nem',
      nodeAddress: nem.model.nodes.defaultTestnet,
      nodePort: nem.model.nodes.defaultPort,
      url: nem.model.nodes.testnetExplorer,
      apiUrl: proxy + "http://bob.nem.ninja:8765/api3"
    }
  };
  out$.type = type = 'coin';
  out$.enabled = enabled = true;
  out$.token = token = 'xem';
  out$.image = image = './res/nem-ethnamed.png';
}).call(this);