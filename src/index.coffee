requireDir                = require 'require-dir'

global.chap               = {}
global.chap.eventHook     = require "#{__dirname}/modules/eventHook.coffee"
global.chap.config        = requireDir "#{__dirname}/config", recurse: true
global.chap.logger        = require "#{__dirname}/modules/logger.coffee"
global.chap.chatPlatforms = requireDir "#{__dirname}/modules/chatPlatforms"
global.chap.formatters    = requireDir "#{__dirname}/modules/formatters"
