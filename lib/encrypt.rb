require_relative 'enigma'
require_relative 'readable'
require_relative 'writable'

class Encrypt
  include Readable, Writable
  attr_reader :input_path, :output_path

  def initialize
    @input_path = ""
    @output_path = ""
  end

  def get_paths
    ARGV
  end

  def set_paths
    @input_path = get_paths[0]
    @output_path = get_paths[1]
  end

  def encrypt_message
    enigma = Enigma.new
    encrypted = enigma.encrypt(read_message)
    puts "Created '#{@output_path}' with the key #{encrypted[:key]} and date #{encrypted.date}"
    write_message(encrpyted[:encryption])
  end

end
