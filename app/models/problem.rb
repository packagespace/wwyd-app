class Problem < ApplicationRecord
  def tiles
    self[:hand].gsub(%r{(?<numbers>[0-9']*)(?<suit>[mpsz])}) do |_|
      result = ""
      numbers, suit = $1, $2
      numbers.split(%r{(?!')}).each do |number|
        result += "#{number}#{suit}"
      end
      result
    end
  end

  def is_solved_by?(answer)
    self[:solution].gsub(%r{(?<numbers>[0-9']*)(?<suit>[mpsz])}) do |_|
      numbers, suit = $1, $2
      numbers.split(%r{(?!')}).each do |number|
        return true if answer == "#{number}#{suit}"
      end
    end
    false
  end

  def solution_tiles
    solution_tiles = self[:solution].gsub(%r{(?<numbers>[0-9']*)(?<suit>[mpsz])}) do |_|
      result = ""
      numbers, suit = $1, $2
      numbers.split(%r{(?!')}).each do |number|
        result += "#{number}#{suit}"
      end
      result
    end

    solution_tiles.split(%r{(?![mpsz]'?)}).join(" or ")
  end
end
