module Writable

  def write_message(message)
    cipher_msg = File.open(@output_path, "w")
    cipher_msg.write(message)
    cipher_msg.close
  end

end
