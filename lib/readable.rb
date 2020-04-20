module Readable

  def read_message
    File.open(@input_path).readlines.map {|line| line.chomp}.join
  end

end
