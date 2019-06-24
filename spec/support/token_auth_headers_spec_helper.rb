module TokenAuthHeadersSpecHelper
  def get_headers(params)
    post '/api/v1/auth/sign_in', params: params
    headers = response.headers
    {
      'access-token': headers['access-token'],
      'client': headers['client'],
      'expiry': headers['expiry'],
      'uid': headers['uid'],
      'token-type': headers['token-type'],
    }
  end
end
