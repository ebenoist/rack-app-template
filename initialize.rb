%w(. ./lib/).each do |path|
  $: << path
end

require "bundler"
Bundler.require

