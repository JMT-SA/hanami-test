require 'spec_helper'
require_relative '../../../../apps/web/views/books/container'

describe Web::Views::Books::Container do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/books/container.html.erb') }
  let(:view)      { Web::Views::Books::Container.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    view.foo.must_equal exposures.fetch(:foo)
  end
end
