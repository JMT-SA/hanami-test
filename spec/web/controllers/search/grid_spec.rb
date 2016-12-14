require 'spec_helper'
require_relative '../../../../apps/web/controllers/search/grid'

describe Web::Controllers::Search::Grid do
  let(:action) { Web::Controllers::Search::Grid.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
