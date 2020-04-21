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
    write_message(cracked[:decryption])
  end

end
