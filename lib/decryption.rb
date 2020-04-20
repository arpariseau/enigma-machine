class Decryption
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

end
