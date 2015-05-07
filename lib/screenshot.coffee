_ = require 'lodash'
shotIndex = 0

module.exports = (casper) ->

  shot = (name) ->
    unless name?
      name = ++shotIndex
    casper.capture 'test/screenshots/' + name + '.png'

  casper.shot = shot