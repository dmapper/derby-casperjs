_ = require 'lodash'
__operation = 0
model = undefined

module.exports = (casper) ->
  return model if model?

  model =

    set: (path, value, cb) ->
      operation = ++__operation
      prevValue = casper.evaluate (path, value, operation, hasCb) ->
        app.model.set path, value, if hasCb then ->
          window.__ops ?= {}
          window.__ops[operation] = true
      , path, value, operation, cb?
      if cb?
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
      prevValue

    get: (path) ->
      casper.evaluate (path) ->
        app.model.get path
      , path

    wait: (cb) ->
      model.set 'service.__ping', __operation, cb

    waitFor: (path, cb, onTimeout, timeout) ->
      casper.waitFor ->
        !!model.get(path)
      , cb, onTimeout, timeout