require 'colorize'

module Starling
  class Command
    def initialize(client, timeline, output)
      @client = client
      @timeline = timeline
      @output = output
    end

    def process(text)
      if text[0] == '/'
        process_command(text)
      else
        @client.send_tweet(text)
      end
    end

    def quit
      @timeline.stop
    end

    protected

    def process_command(text)
      text.gsub!(/^\//, '')
      command, args = text.split(' ', 2)

      if respond_to? command.to_sym
        send(command.to_sym)
      else
        @output.output(["No such command: #{command}".colorize(:red)])
      end
    end
  end
end
