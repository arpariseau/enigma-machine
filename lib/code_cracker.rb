class CodeCracker
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

end
