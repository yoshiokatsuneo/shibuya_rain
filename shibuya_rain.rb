#!/usr/bin/env ruby
# coding: utf-8

require 'twitter'
require './token-config'

client = Twitter::REST::Client.new{|config|
	config.consumer_key       = CONSUMER_KEY
	config.consumer_secret    = CONSUMER_SECRET
	config.access_token        = OAUTH_TOKEN
	config.access_token_secret = OAUTH_TOKEN_SECRET
}

match_count = 0
keywords="渋谷,雨"
threshold=3
client.search(keywords, :count =>200, :result_type => "recent").each{|status|
	print "status=#{status}"
	print "Tweet: #{Time.now - status.created_at}, #{status.user.screen_name}: #{status.text}\n"
	if(Time.now - status.created_at < 60 + 15) then
		match_count += 1
	else
		break
	end
}

if match_count >= threshold then
	Twitter.update("「#{keywords}」でのツイートが１分間に#{threshold}個以上(#{match_count}個)ありました。\n")
end


