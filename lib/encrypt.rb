require_relative 'enigma'

class Encrypt
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

  def read_message
    File.open(@input_path).readlines.map {|line| line.chomp}.join
  end

end
