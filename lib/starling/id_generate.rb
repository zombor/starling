module Starling
  class IdGenerate
    def initialize(storage)
      @storage = storage
      @values = ('aa'..'zz').to_a
      @next_value = 0
    end

    def store(value)
      current_value = @values[@next_value]
      @storage[current_value] = value
      @next_value+=1

      if @next_value > @values.length
        @next_value = 0
      end

      current_value
    end

    def fetch(token)
      @storage[token]
    end
  end
end
