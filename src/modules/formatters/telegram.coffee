request = require 'request'
Q       = require 'q'

eventIdentifiers =
    reply_to_message: (message) ->
        # [Reply to "@BirkhoffLee: 123456 ..." at #{message.chat.type} #{message.chat.title} on Telegram] @koru1130: 好我知道了。

        deferred = Q.defer()

        return deferred.promise

    left_chat_member: (message) ->
        # [@BirkhoffLee left the group OwO on Telegram]

        deferred = Q.defer()

        return deferred.promise

    new_chat_member: (message) ->
        # [@BirkhoffLee joined the group OwO on Telegram]

        deferred = Q.defer()

        return deferred.promise

    pinned_message: (message) ->
        # [@BirkhoffLee pinned "123456 ..." by @koru1130 at #{message.chat.type} #{message.chat.title} on Telegram]

        deferred = Q.defer()

        return deferred.promise

    new_chat_title: (message) ->
        # [@BirkhoffLee renamed #{message.chat.type} #{message.chat.title} to "fullname" on Telegram]

        deferred = Q.defer()

        return deferred.promise

    forward_from: (message) ->
        # [Forwarded by @Birkhoff Lee to #{message.chat.type} #{message.chat.title} on Telegram] @foobar: 好我知道了。

        deferred = Q.defer()

        return deferred.promise

    edit_date: (message) ->
        # [@foobar edited his message to #{message.chat.type} #{message.chat.title} on Telegram to: 好我不知道。]

        deferred = Q.defer()

        return deferred.promise

    pureChat: (message) ->

        return Q.fcall ->
            return "@#{message.from.username} to #{message.chat.type} #{message.chat.title} on Telegram: #{message.text}"

    document: (message) ->
        # [@BirkhoffLee sent ZootopiaLaugh.jpg to #{message.chat.type} #{message.chat.title} on Telegram]

        deferred = Q.defer()

        # global.chap.chatPlatforms.Telegram.bot.getFile message.document.file_id

        return deferred.promise

    location: (message) ->

        deferred = Q.defer()
        result   = "@#{message.from.username} sent a location to #{message.chat.type} #{message.chat.title} on Telegram: "
        url      = "https://tinyurl.com/api-create.php?url=https://www.google.com/maps/@#{message.location.latitude.toString()},#{message.location.longitude.toString()},17z"

        request url, (error, response, body) ->
            if !error && response.statusCode == 200
                deferred.resolve result + body
                return

            deferred.reject()

        return deferred.promise

    sticker: (message) ->

        deferred = Q.defer()

        return deferred.promise

    contact: (message) ->

        deferred = Q.defer()

        return deferred.promise

    video: (message) ->

        deferred = Q.defer()

        return deferred.promise

    photo: (message) ->

        deferred = Q.defer()

        return deferred.promise

    audio: (message) ->

        deferred = Q.defer()

        return deferred.promise

    voice: (message) ->

        deferred = Q.defer()

        return deferred.promise

    venue: (message) ->

        deferred = Q.defer()

        return deferred.promise

returnInfo = (message, cb) ->
    source = message.chat.id

    return cb message
        .then (result) ->
            return {
                result: result
                source: "Telegram:#{source}"
            }

module.exports = (message) ->
    deferred   = Q.defer()
    result     = ""
    source     = message.chat.id

    if !global.chap.config.general.debug && message.chat.type != "group" && message.chat.type != "supergroup"
        deferred.reject()
        return deferred.promise

    for identifier, cb of eventIdentifiers
        if message.hasOwnProperty identifier
            deferred.resolve returnInfo message, cb
            return deferred.promise

    if !message.text
        global.chap.logger.error "A kind of message has been confirmed as non-supported, here's the detail:"
        console.error message

        deferred.reject()
        return deferred.promise

    deferred.resolve returnInfo message, eventIdentifiers.pureChat

    return deferred.promise