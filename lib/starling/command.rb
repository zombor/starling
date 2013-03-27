module Starling
  class Command
    def initialize(client, timeline, output)
      @client = client
      @timeline = timeline
      @output = output
    end
  end
end
