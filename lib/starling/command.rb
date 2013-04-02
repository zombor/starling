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
      token[0] = ''

      id = @storage.fetch(token)

      @client.reply(id, status)
    end
  end
end
