http = require 'http'

class UpdateAsHandler
  constructor: ({@jobManager,@auth}) ->

  do: (request, callback=->) =>
    updateDeviceRequest =
      metadata:
        jobType: 'UpdateDevice'
        toUuid: request.metadata.toUuid
        fromUuid: request.metadata.fromUuid
        auth: @auth
      data:
        $set: request.data

    @jobManager.do updateDeviceRequest, (error, response) =>
      return callback metadata: {code: 504, status: http.STATUS_CODES[504]} if error?
      callback response

module.exports = UpdateAsHandler
