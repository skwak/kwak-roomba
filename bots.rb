require "twitter_ebooks"
require "dotenv"
Dotenv.load

# This is an example bot definition with event handlers commented out
# You can define and instantiate as many bots as you like

class MyBot < Ebooks::Bot
  # Configuration here applies to all MyBots
  def configure
    self.consumer_key = ENV["twitter_consumer_key"] # Your app consumer key
    self.consumer_secret = ENV["twitter_consumer_secret"] # Your app consumer secret

    # Users to block instead of interacting with
    # self.blacklist = ['tnietzschequote']

    # Range in seconds to randomize delay when bot.delay is called
    self.delay_range = 1..6
  end

  def on_startup
    model = Ebooks::Model.load("model/kwakstop.model")
    scheduler.every '10s' do
      model.make_statement(140)
      # Tweet something every 24 hours
      # See https://github.com/jmettraux/rufus-scheduler
      # tweet("hi")
      # pictweet("hi", "cuteselfie.jpg")
    end
  end

  def on_message(dm)
    # Reply to a DM
    # reply(dm, "secret secrets")
  end

  def on_follow(user)
    # Follow a user back
    # follow(user.screen_name)
  end

  def on_mention(tweet)
    # Reply to a mention
    # reply(tweet, "oh hullo")
  end

  def on_timeline(tweet)
    # Reply to a tweet in the bot's timeline
    # reply(tweet, "nice tweet")
  end

  def on_favorite(user, tweet)
    # Follow user who just favorited bot's tweet
    # follow(user.screen_name)
  end
end

# Make a MyBot and attach it to an account
MyBot.new("kwakietalkie") do |bot|
  bot.access_token = ENV["bot_token"] # Token connecting the app to this account
  bot.access_token_secret = ENV["bot_secret"] # Secret connecting the app to this account
end
