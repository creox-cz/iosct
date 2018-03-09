var exec = require('cordova/exec');

var PLUGIN_NAME = 'IOSCT';

var IOSCT = {
  registerListener: function(successCallback, errorCallback) {
    exec(successCallback, errorCallback, PLUGIN_NAME, 'registerListener', []);
  },
};

module.exports = IOSCT;
