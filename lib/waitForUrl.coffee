_ = require 'lodash'

module.exports = (casper, constants) ->

  clearRenderedFlag = ->
    casper.evaluate -> delete window._rendered

  _originalWaitForUrl = casper.waitForUrl
  casper.waitForUrl = (url, cb, onTimeout, timeout) ->
    url = constants.baseUrl + url if _.isString(url) and url[0] is '/'
    _originalWaitForUrl.call casper, url, ->
      casper.waitFor ->
        casper.evaluate -> window._rendered
      , ->
        clearRenderedFlag()
        cb?()
      , onTimeout, timeout
    , onTimeout, timeout
