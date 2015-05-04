shotIndex = 0

module.exports = (casper) ->

  shot = (index) ->
    unless index? and _.isNumber(index)
      index = ++shotIndex
    casper.capture 'test/screenshots/' + index + '.png'

  casper.shot = shot