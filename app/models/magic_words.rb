# Internal: Magic words are 2 or more words that define a user. They must never
# be re-used (to avoid message hijacking). So we use an LCG to
# deterministically and randomly use every word in a sequence. In case it
# fails, DB validation will catch duplicates (but it shouldn’t, right?!).
#
# TODO: Some of this is fairly lousy.
class MagicWords

  # Internal: Read the magic words
  def self.words
    @words ||= File.read(Rails.root.join("db", "magic-words.txt")).split
  end

  # Internal: Total available magic word sets.
  def self.size
    @size ||= (self.words.length ** AppConfig.magic_words.number)
  end

  # Internal: Get the value of the last combination
  #
  # Example:
  #
  #   last_combination_used("microwave wayside")
  #   # => 14241
  def self.last_combination_used(magic_words)
    positions = magic_words.split(" ").map{|word| self.words.index(word)}
    binary_string = positions.map{|position| decimal_as_binary(position, (self.words.length-1).to_s(2).length)}.join("")
    binary_string.to_i(2)
  end

  # Internal: convert a decimal to an unsigned binary string with a particular
  # number of bits.
  def self.decimal_as_binary(decimal, bits)
    decimal.to_s(2).rjust(bits, "0")
  end

  # Internal: Constructor. Call #to_s after if you want something useable.
  #
  # at - Index of cycle to use. This is what allows you to use every possible
  # combination without any combination repeating. Default is based on the
  # number of users.
  def initialize(last_magic_words = nil)
    if !last_magic_words
      last_user = User.order("created_at DESC").first
      last_magic_words = last_user ? last_user.magic_words : nil
    end
    seed = last_magic_words ? self.class.last_combination_used(last_magic_words) : AppConfig.magic_words.seed
    combination = cycle(seed, self.class.size-1, AppConfig.magic_words.prime).first

    combination = self.class.decimal_as_binary(combination, (self.class.size-1).to_s(2).length).split("")

    bits = combination.length / AppConfig.magic_words.number
    indices = combination.each_slice(bits).map{|b| b.join.to_i(2)}
    @magic_words = AppConfig.magic_words.number.times.map do |w|
      self.class.words[indices[w]]
    end
  end

  def to_s
    @magic_words.join(" ")
  end

  private
  # Internal: LCG. Returns a lazy evaluating enumerable.
  def cycle(seed, range, prime)
    nb = seed
    range.times.lazy.map do
      nb = (nb + prime) % range
      nb
    end
  end

end
