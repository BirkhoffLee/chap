Q = require 'q'

getTargets = (resObj) ->
    console.log resObj
    deferred = Q.defer()
    source   = resObj.source
    pipes    = require "#{__dirname}/../config/pipes.json"

    if "string" == typeof pipes[source] && pipes[source].trim() != ""
        pipes[source] = [pipes[source].trim()]

    if "object" == typeof pipes[source] && pipes[source] != []
        console.log "resolve"
        deferred.resolve
            targets: pipes[source]
            result : resObj.result
    else
        # Configured target is neither a array nor a string
        deferred.reject()

    return deferred.promise

forward = (resObj) ->
    deferred = Q.defer()
    targets  = resObj.targets
    result   = resObj.result

    targets.forEach (target) ->
        separated = target.split ":"
        platform  = separated[0].toLowerCase()
        id        = parseInt separated[1]

        global.chap.chatPlatforms[platform].sendMessage id, result

    return deferred.promise

module.exports = (resObj) ->
    getTargets resObj
        .then forward

