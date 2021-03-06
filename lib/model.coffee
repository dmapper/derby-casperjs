_ = require 'lodash'
__operation = 0
model = undefined

module.exports = (casper) ->
  return model if model?

  model =

    _waitForOperation: (operation, cb) ->
      return unless cb?
      casper.waitFor ->
        casper.evaluate (operation) ->
          if window.__ops[operation]
            delete window.__ops[operation]
            true
          else
            false
        , operation
      , ->
        cb()

    set: (path, value, cb) ->
      operation = ++__operation
      prevValue = casper.evaluate (path, value, operation, hasCb) ->
        app.model.set path, value, if hasCb then ->
          window.__ops ?= {}
          window.__ops[operation] = true
      , path, value, operation, cb?
      model._waitForOperation operation, cb
      prevValue

    del: (path, cb) ->
      operation = ++__operation
      prevValue = casper.evaluate (path, operation, hasCb) ->
        app.model.del path, if hasCb then ->
          window.__ops ?= {}
          window.__ops[operation] = true
      , path, operation, cb?
      model._waitForOperation operation, cb
      prevValue

    get: (path) ->
      casper.evaluate (path) ->
        app.model.get path
      , path

    wait: (cb) ->
      operation = ++__operation
      pingId = casper.evaluate (operation, hasCb) ->
        _pingId = '__ping_' + app.model.id()
        app.model.add 'service', {id: _pingId}, if hasCb then ->
          window.__ops ?= {}
          window.__ops[operation] = true
        _pingId
      , operation, cb?
      model._waitForOperation operation, cb
      pingId

    waitFor: (path, cb, onTimeout, timeout) ->
      casper.waitFor ->
        !!model.get(path)
      , cb, onTimeout, timeout