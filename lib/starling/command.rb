require 'colorize'

module Starling
  class Command
    def initialize(client, timeline, output, storage)
      @client = client
      @timeline = timeline
      @output = output
      @storage = storage
    end

    def process(text)
      if text[0] == '/'
        process_command(text)
      else
        @client.send_tweet(text)
      end
    end

    protected

    def process_command(text)
      text.gsub!(/^\//, '')
      command, args = text.split(' ', 2)

      if respond_to? command.to_sym
        send(command.to_sym, *args)
      else
        @output.output(["No such command: #{command}".colorize(:red)])
      end
    end

    def quit
      @timeline.stop
    end

    def reply(text)
      token, status = text.split(' ', 2)

      id = @storage.fetch(strip_token(token))

      status = "@#{Starling::Tweet.new(nil, @client.find_by_id(id)).from_user} #{status}"

      @client.reply(id, status)
    end

    def again(count = nil)
      tweets = @client.home_timeline(count.to_i).reverse
      tweets.map! {|t| Starling::Tweet.new(@storage.store(t.id), t) }
      @output.output tweets
    end

    def retweet(token)
      id = @storage.fetch(strip_token(token))
      @client.retweet(id)
    end

    def strip_token(token)
      token[0] = ''
      token
    end
  end
end
