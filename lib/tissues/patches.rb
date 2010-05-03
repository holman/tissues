class String
  def to_state
    to_s == 'open' ? :open : :closed
  end

  def to_status
    to_s == 'open' ? :open : :completed
  end
end

class Things::Todo
  def number
    name.scan(/\[\#([0-9]+)\]/).first
  end
end

class APICache
  class << self
    def store # :nodoc:
      @store ||= begin
        APICache::MemoryStore.new
      end
    end    
  end
end