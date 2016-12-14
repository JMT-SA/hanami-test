require 'spec_helper'
require_relative '../../../../apps/web/controllers/search/run'

describe Web::Controllers::Search::Run do
  let(:action) { Web::Controllers::Search::Run.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
