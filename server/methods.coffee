require = __meteor_bootstrap__.require
fs = require('fs')
path = require('path')
base = path.resolve('.')
isBundle = fs.existsSync(base + '/bundle')
modulePath = base + (if isBundle then '/bundle/static' else '/public') + '/node_modules'
rest = require(modulePath + '/restler')
temp = require(modulePath + '/temp')

Meteor.methods
  soundcloud: (data) ->
    temp.open suffix: '.wav', (err, info) ->
      fs.write(info.fd, new Buffer(data.track.asset_data, 'base64').toString('utf8'))
      fs.close info.fd, (err) ->
        fs.stat info.path, (err, stats) ->
          rest.post('http://api.soundcloud.com/tracks',
            multipart: true
            data:
              oauth_token: data.oauth_token
              format: data.format
              'track[title]': data.track.title
              'track[asset_data]': rest.file(info.path, null, stats.size, null, 'audio/wav')
          ).on 'complete', (a, b) ->
            console.log a
            console.log b
    null
