requireDir                = require 'require-dir'
modulesDir                = "#{__dirname}/modules/"

global.chap               = {}
global.chap.eventHook     = require modulesDir + "eventHook.coffee"
global.chap.config        = require(modulesDir + "loadConfig.coffee")(requireDir)
global.chap.logger        = require modulesDir + "logger.coffee"
global.chap.forwarder     = require modulesDir + "forwarder.coffee"
global.chap.chatPlatforms = requireDir modulesDir + "chatPlatforms"
global.chap.formatters    = requireDir modulesDir + "formatters"
