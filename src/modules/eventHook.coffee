events = require 'events'
hook   = new events.EventEmitter()

hook.on "/chatPlatform/connected", (platformName) ->
    global.chap.logger.info "Connected to #{platformName}."

hook.on "/chatPlatform/error/connect", (platformName, err) ->
    global.chap.logger.warn "Unable to connect to #{platformName} server."

hook.on "/chatPlatform/error/sendMsg", (platformName, err) ->
    global.chap.logger.warn "#{platformName}: Error sending message."
    global.chap.logger.info "debug", err

hook.on "/chatPlatform/receivedMsg", (platformName, message) ->
    # console.log message
    global.chap.formatters[platformName.toLowerCase()] message
        .then (resObj) ->
            return global.chap.forwarder resObj

module.exports = hook