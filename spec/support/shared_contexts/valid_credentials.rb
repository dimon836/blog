RSpec.shared_context 'valid credentials' do
  let(:valid_credentials) { ActionController::HttpAuthentication::Basic.encode_credentials("dhh", "secret") }

  before { request.headers['Authorization'] = valid_credentials }
end
