#!/usr/bin/env ruby
# coding: utf-8

require 'twitter'
require './token-config'

Twitter.configure{|config|
	config.consumer_key       = CONSUMER_KEY
	config.consumer_secret    = CONSUMER_SECRET
	config.oauth_token        = OAUTH_TOKEN
	config.oauth_token_secret = OAUTH_TOKEN_SECRET
}

match_count = 0
keywords="渋谷,雨"
threshold=3
Twitter.search(keywords, :count =>200, :result_type => "recent").results.map{|status|
	print "Tweet: #{Time.now - status.created_at}, #{status.from_user}: #{status.text}\n"
	if(Time.now - status.created_at < 60 + 15) then
		match_count += 1
	end	
}

if match_count >= threshold then
	Twitter.update("「#{keywords}」でのツイートが１分間に#{threshold}個以上(#{match_count}個)ありました。\n")
end


