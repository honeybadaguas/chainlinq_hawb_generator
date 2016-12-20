require 'luhn'
require_relative 'chainlinq_connector'

class HawbGenerator
  class << self
    def generate_hawb(file_path, prefix, count, num_count=11, check_chainlinq=true)
      file = File.new(file_path, "w")
      i = 0
      loop do
        num = Luhn.generate(num_count)
        hawb = "#{prefix}#{num}"
        if (!check_chainlinq || !ChainlinqConnector.hawb_exists?(hawb))
          file.write("#{hawb}\n")
          i += 1
          puts i
        end
        break if i == count
      end
      file.close
    end
  end
end