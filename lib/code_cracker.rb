require_relative 'writable'
require_relative 'readable'
require_relative 'enigma'

class CodeCracker
include Writable, Readable
attr_reader :input_path, :output_path, :date

  def initialize
    @input_path = ""
    @output_path = ""
    @date = ""
  end

  def get_paths
    ARGV
  end

  def set_paths
    @input_path = get_paths[0]
    @output_path = get_paths[1]
    @date = get_paths[2]
  end

  def crack_message
    enigma = Enigma.new
    cracked = enigma.crack(read_message, @date)
    puts "Created '#{@output_path}' with the cracked key #{cracked[:key]} and date #{cracked[:date]}"
    alt_keys = find_alternate_keys(enigma, cracked[:key])
    puts "Alternate keys: #{alt_keys}" if !alt_keys.empty?
    write_message(cracked[:decryption])
  end

  def find_alternate_keys(enigma, key)
    test_key = key.to_i
    alt_keys = [test_key + 27273, test_key + 54546, test_key + 81819]
    alt_keys.map! {|test_key| test_key.to_s}
    alt_keys.delete_if {|test_key| test_key.length > 5}
    alt_keys.find_all do |alt_key|
      enigma.encrypt("test", key, @date)[:encryption] ==
      enigma.encrypt("test", alt_key, @date)[:encryption]
    end
  end

end
