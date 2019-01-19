var Web3 = require("web3");
var contract = require("truffle-contract");
const json1 = require('./Greetings.json')

//var tools = require('./web3.min');
//var tools = require('./truffle-contract');

if (typeof Web3 == "object" && Object.keys(Web3).length == 0) {
  console.log('11111');
  Web3 = global.Web3;
}

App = {
  web3Provider: null,
  contracts: {},
  account: 0x0,
  loading: false,

  init: function () {
    return App.initWeb3();
  },

  initWeb3: function () {
    console.log('Init.....');
    // initialize web3
    if (typeof web3 !== 'undefined') {
      console.log('Init111.....');
      //reuse the provider of the Web3 object injected by Metamask
      App.web3Provider = web3.currentProvider;
    } else {
      //create a new provider and plug it directly into our local node
      //App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
      console.log('Init222.....');
      App.web3Provider = new Web3.providers.HttpProvider('http://3.83.175.249:8545');
    
    }
    web3 = new Web3(App.web3Provider);
    //console.log('NNNNN---->',web3);
    App.displayAccountInfo();
    return App.initContract();
  },

  displayAccountInfo: function () {
    web3.eth.getCoinbase(function (err, account) {
      if (err === null) {
        App.account = account;
        console.log('Init4444.....', App.account);
      }
    });
  },

  initContract: function () {
        App.contracts.ChainList = contract(json1);
        // set the provider for our contracts
        App.contracts.ChainList.setProvider(App.web3Provider);
        App.setGreeting('NiveManoj11111111111');
  },

  setGreeting: function (msg) {
    console.log('Init.....setGreeting');
    App.contracts.ChainList.deployed().then(ins => {
      //return ins.getGreeting();
      ins.setGreeting(msg, {
        from: App.account,
        gas: 500000
      });
    }).catch(err => {
      console.error(err);
    })
  },

};
App.init();
