require_relative 'writable'
require_relative 'readable'
require_relative 'enigma'

class Decryption
  include Writable, Readable
  attr_reader :input_path, :output_path,
              :keycode, :date

  def initialize
    @input_path = ""
    @output_path = ""
    @keycode = ""
    @date = ""
  end

  def get_paths
    ARGV
  end

  def set_paths
    @input_path = get_paths[0]
    @output_path = get_paths[1]
    @keycode = get_paths[2]
    @date = get_paths[3]
  end

  def decrypt_message
    enigma = Enigma.new
    decrypted = enigma.decrypt(read_message, @keycode, @date)
    puts "Created '#{@output_path}' with the key #{decrypted[:key]} and date #{decrypted[:date]}"
    write_message(decrypted[:decryption])
  end

end
