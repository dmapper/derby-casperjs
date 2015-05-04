_ = require 'lodash'

module.exports = (casper, constants) ->

  push: (path, cb) ->
    casper.evaluate (path) ->
      app.history.push path
    , path
    casper.waitForUrl (constants.baseUrl + path), cb if cb

  refresh: (cb) ->
    url = casper.getCurrentUrl()
    casper.evaluate ->
      app.history.refresh()
    casper.waitForUrl url, cb if cb


#['push', 'refresh', 'back'].forEach (method) ->
#  history[method] = (args...) ->
#    casper.evaluate (method, args) ->
#      app.history[method] args...
#    , method, args
