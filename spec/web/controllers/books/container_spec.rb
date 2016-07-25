require 'spec_helper'
require_relative '../../../../apps/web/controllers/books/container'

describe Web::Controllers::Books::Container do
  let(:action) { Web::Controllers::Books::Container.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
