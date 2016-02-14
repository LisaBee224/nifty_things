require 'jumpstart_auth'

class MicroBlogger
  attr_reader :client

  def initialize
    @client = JumpstartAuth.twitter
  end

  def tweet
    puts "\nWhat would you like to tweet?"
    print ">  "
    message = gets.chomp

    if message.length < 140
      @client.update(message)
      puts "Tweet posted!"
    else raise "Tweet too long to post"
    end
  end

  def send_dm(username)
    print "\nMessage:   "
    message = "d #{username} #{gets.chomp}"

    if message.length < 140
      @client.update(message)
      puts "Message sent!"
    else raise "Message too long to send"
    end
  end

  def route_dm
    puts "\nFriends: #{friends.join(", ")}"
    print "\nSend message to:   "
    target = gets.chomp
    if friends.include?(target)
      sending_to_target = MicroBlogger.new
      sending_to_target.send_dm(target)
    else puts "Sorry, can't DM someone who isn't your friend!"
    end
  end

  def friends
    client.followers.map{|person| client.user(person).screen_name}
  end

  def get_all_latest_friends_tweets
    client.followers.each do |friend|
      puts
      puts client.user(friend).screen_name
      puts client.user(friend).status.text
    end
  end
end


if __FILE__ == $PROGRAM_NAME
  copy = MicroBlogger.new
  copy.tweet

    while true
      puts "do you want to tweet again?"
      response = gets.chomp
        if response.include?("y")
          copy.tweet
        else
          break
        end
    end
end


