require 'spec_helper'
require_relative '../../../../apps/web/controllers/books/calledback'

describe Web::Controllers::Books::Calledback do
  let(:action) { Web::Controllers::Books::Calledback.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
