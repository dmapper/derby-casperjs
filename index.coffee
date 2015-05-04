_ = require 'lodash'

loadOnce = (casper, constants, moduleName) ->
  casper.__initUtils ?= {}
  unless casper.__initUtils[ moduleName ]
    require("./lib/#{ moduleName }") casper, constants
    casper.__initUtils[ moduleName ] = true


module.exports = (casper, constants = {}) ->

  _.defaults constants,
    baseUrl: 'http://localhost:3000'

  loadOnce casper, constants, 'waitForUrl'
  loadOnce casper, constants, 'debug'
  loadOnce casper, constants, 'screenshot'

  sel: require('./lib/selectors') casper, constants
  model: require('./lib/model') casper, constants
  history: require('./lib/history') casper, constants