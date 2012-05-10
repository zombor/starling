lib = File.expand_path('../../../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'oauth'
require 'vcr'
require 'starling/access/get_access_token'

VCR.configure do |c|
	c.hook_into :fakeweb
	c.cassette_library_dir = 'features/cassettes'
end

VCR.cucumber_tags do |t|
	t.tag  '@vcr', :use_scenario_name => true
end
