Bot = require 'telegram-bot-api'

bot = new Bot
    token: global.chap.config.chatPlatforms.telegram.token
    updates:
        enabled: true

bot.getMe()
    .then (data) ->
        global.chap.config.chatPlatforms.telegram.username = data.username
        global.chap.eventHook.emit "/chatPlatform/connected", "Telegram"
    .catch (err) ->
        global.chap.eventHook.emit "/chatPlatform/error/connect", "Telegram", err

messageHandler = (message) ->
    global.chap.eventHook.emit "/chatPlatform/receivedMsg", "Telegram", message

sendMessageErrorHandler = (err) ->
    console.log err
    global.chap.eventHook.emit "/chatPlatform/error/sendMsg", "Telegram", err

sendMessage = (target, text) ->
    console.log "123"
    console.log target
    console.log text
    bot.sendMessage
        chat_id:    target
        parse_mode: "html"
        text:       text
        # disable_web_page_preview: "true"
    .catch sendMessageErrorHandler

bot.on 'message'        , messageHandler
bot.on 'edited.message' , messageHandler

module.exports =
    bot         : bot
    sendMessage : sendMessage