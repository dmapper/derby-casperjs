_ = require 'lodash'
__operation = 0

module.exports = (casper, constants) ->

  set: (path, value, cb) ->
    casper.evaluate (path, value, operation) ->
      app.model.set path, value, ->
        window.__operation = operation
    , path, value, ++__operation
    casper.waitFor ->
      casper.evaluate (operation) ->
        window.__operation is operation
      , __operation
    , ->
      cb?()

  get: (path) ->
    casper.evaluate (path) ->
      app.model.get path
    , path

  wait: (cb) ->
    model.set '_page.__ping', __operation, cb

  waitFor: (path, cb, onTimeout, timeout) ->
    casper.waitFor ->
      !!model.get(path)
    , cb, onTimeout, timeout