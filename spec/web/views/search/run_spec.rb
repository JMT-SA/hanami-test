require 'spec_helper'
require_relative '../../../../apps/web/views/search/run'

describe Web::Views::Search::Run do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/search/run.html.erb') }
  let(:view)      { Web::Views::Search::Run.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    view.foo.must_equal exposures.fetch(:foo)
  end
end
