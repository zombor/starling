lib = File.expand_path('../../../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'oauth'
require 'starling/access/get_access_token'
