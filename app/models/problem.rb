class Problem < ApplicationRecord
  def tiles
    self[:hand].gsub(%r{(?<numbers>[0-9']*)(?<suit>[mpsz])}) do |_|
      result = ''
      numbers, suit = $1, $2
      numbers.split(%r{(?!')}).each do |number|
        result += "#{number}#{suit}"
      end
      result
    end
  end
end
