_ = require 'lodash'
xpath = require('casper').selectXPath
cssToXPath = require('css-to-xpath')

module.exports = (casper) ->

  text: -> # (selector, text) or (text)
    if arguments.length == 1
      xpath("//text()[contains(., \'#{arguments[0]}\')]")
    else
      [selector, text] = arguments
      xpath(cssToXPath(selector) + "//text()[contains(., \'#{text}\')]")
