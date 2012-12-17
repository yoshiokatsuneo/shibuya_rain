#!/usr/bin/env ruby
# coding: utf-8

require 'twitter'
require './token-config'

Twitter.configure{|config|
	config.consumer_key       = TWITTER_CONSUMER_KEY
	config.consumer_secret    = TWITTER_CONSUMER_SECRET
	config.oauth_token        = TWITTER_OAUTH_TOKEN
	config.oauth_token_secret = TWITTER_OAUTH_TOKEN_SECRET
}

match_count = 0
Twitter.search("rain", :count =>200, :result_type => "recent").results.map{|status|
	# print "Tweet: #{Time.now - status.created_at}, #{status.from_user}: #{status.text}\n"
	if(Time.now - status.created_at < 60 + 15) then
		match_count += 1
	end	
}

if match_count > 10 then
	Twitter.update("There are #{match_count} tweets related to rain\n")
end


