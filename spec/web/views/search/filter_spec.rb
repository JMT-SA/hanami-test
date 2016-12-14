require 'spec_helper'
require_relative '../../../../apps/web/views/search/filter'

describe Web::Views::Search::Filter do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/search/filter.html.erb') }
  let(:view)      { Web::Views::Search::Filter.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    view.foo.must_equal exposures.fetch(:foo)
  end
end
