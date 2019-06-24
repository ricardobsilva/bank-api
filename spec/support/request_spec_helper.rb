module RequestSpecHelper
  #include Warden::Test::Helpers

  def json_body
    @json_body ||= JSON.parse(response.body, symbolize_names: true)
  end

  private

  def warden_scope(resource)
    resource.class.name.underscore.to_sym
  end

end
