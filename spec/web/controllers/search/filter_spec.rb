require 'spec_helper'
require_relative '../../../../apps/web/controllers/search/filter'

describe Web::Controllers::Search::Filter do
  let(:action) { Web::Controllers::Search::Filter.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
