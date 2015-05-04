_ = require 'lodash'
system = require 'system'
fs = require('fs')
PWD = fs.workingDirectory

module.exports = (casper) ->

  DEBUG = (system.env?.debug? or system.env?.DEBUG?)

  if DEBUG
    # Echo from client console
    casper.on 'remote.message', (msg) ->
      label =  "RC"
      message =  JSON.stringify(msg, null, 2)
      casper.echo "#{label} #{message}"

    casper.on 'remote.alert', (msg) ->
      label =  "ERR"
      message =  msg
      casper.echo "#{label} #{message}"

    casper.on 'resource.error', (msg) ->
      label =  "RES ERR"
      message = JSON.stringify(msg, null, 2)
      casper.echo "#{label} #{message}"


