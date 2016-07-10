winston = require 'winston'

if global.chap.config.general.debug
    winston.level = "debug"

winston.emitErrs = true

logger = module.exports = new (winston.Logger)(
    transports: [
        new (winston.transports.Console)(
            colorize: 'all'
        )
    ]
)