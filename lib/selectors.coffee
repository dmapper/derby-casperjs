_ = require 'lodash'
xpath = require('casper').selectXPath
cssToXPath = require('css-to-xpath')

module.exports = (casper) ->

  text: -> # (text) or (selector, text) or (selector, text, returnSelectorNode)

    ###*
    # Return text nodes which contain 'text'
    # @param {string} text
    ###
    if arguments.length is 1
      xpath("//text()[contains(., \'#{arguments[0]}\')]")

    ###*
    # Return text nodes which contain 'text'. This text nodes have to be
    # inside 'selector' nodes
    # @param {string} selector
    # @param {string} text
    ###
    else if arguments.length is 2 or (arguments.length is 3 and not arguments[2])
      [selector, text] = arguments
      xpath(cssToXPath(selector) + "//text()[contains(., \'#{ text }\')]")

    ###*
    # Return the 'selector' nodes which contain 'text' anywhere in them
    # @param {string} selector
    # @param {string} text
    # @param {boolean} returnSelectorNode
    ###
    else if arguments.length is 3
      [selector, text, returnSelectorNode] = arguments
      xpath(cssToXPath(selector) + "[contains(., \'#{ text }\')]")

    else
      throw new Error("Invalid amount of arguments provided - #{ arguments.length }")