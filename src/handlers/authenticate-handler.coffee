class AuthenticateHandler
  constructor: ({@jobManager,@auth}) ->

  do: (data, callback=->) =>
    {uuid, token} = data
    return callback null, metadata: {code: 204} unless uuid? && token?

    request =
      metadata:
        jobType: 'Authenticate'
        auth:
          uuid: uuid
          token: token

    @jobManager.do request, (error, response) =>
      return callback error: error.message if error?
      if response.metadata.code == 204
        return callback uuid: data.uuid, authentication: true
      if response.metadata.code == 401
        return callback uuid: data.uuid, authentication: false

      callback error: response.metadata.status, code: response.metadata.code

module.exports = AuthenticateHandler
