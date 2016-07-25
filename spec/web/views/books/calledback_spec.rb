require 'spec_helper'
require_relative '../../../../apps/web/views/books/calledback'

describe Web::Views::Books::Calledback do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/books/calledback.html.erb') }
  let(:view)      { Web::Views::Books::Calledback.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    view.foo.must_equal exposures.fetch(:foo)
  end
end
