module.exports = (requireDir) ->
    config = requireDir "#{__dirname}/../config", recurse: true
    delete config.pipes

    return config