# frozen_string_literal: true

module TileDisplayHelper
  def display_clickable_tiles(text_with_tiles, style, problem)
    tile_images_files = {
      "0m" => "Man5-Dora.svg",
      "1m" => "Man1.svg",
      "2m" => "Man2.svg",
      "3m" => "Man3.svg",
      "4m" => "Man4.svg",
      "5m" => "Man5.svg",
      "6m" => "Man6.svg",
      "7m" => "Man7.svg",
      "8m" => "Man8.svg",
      "9m" => "Man9.svg",
      "0p" => "Pin5-Dora.svg",
      "1p" => "Pin1.svg",
      "2p" => "Pin2.svg",
      "3p" => "Pin3.svg",
      "4p" => "Pin4.svg",
      "5p" => "Pin5.svg",
      "6p" => "Pin6.svg",
      "7p" => "Pin7.svg",
      "8p" => "Pin8.svg",
      "9p" => "Pin9.svg",
      "0s" => "Sou5-Dora.svg",
      "1s" => "Sou1.svg",
      "2s" => "Sou2.svg",
      "3s" => "Sou3.svg",
      "4s" => "Sou4.svg",
      "5s" => "Sou5.svg",
      "6s" => "Sou6.svg",
      "7s" => "Sou7.svg",
      "8s" => "Sou8.svg",
      "9s" => "Sou9.svg",
      "0z" => "Back.svg",
      "1z" => "Ton.svg",
      "2z" => "Nan.svg",
      "3z" => "Shaa.svg",
      "4z" => "Pei.svg",
      "5z" => "Haku.svg",
      "6z" => "Hatsu.svg",
      "7z" => "Chun.svg"
    }

    replacements = []

    tile_images_files.each do |tile_notation, tile_image_file|
      text_with_tiles.gsub!(
        tile_notation,
        "\x01" + tile_notation + "\x02"
      )

      replacements << button_to(
        image_tag("tiles/#{tile_image_file}", alt: tile_notation),
        solves_url,
        params: { solve: {
          tile_notation: tile_notation,
          problem_id: problem } },
        class: "inline tile bg-contain #{style} #{tile_notation}"
      )
    end

    replacements.each_with_index do |replacement, index|
      text_with_tiles.gsub!("\x01#{tile_images_files.keys[index]}\x02", replacement)
    end

    text_with_tiles.html_safe
  end

  def display_tiles(text_with_tiles, style)
    tile_images_files = {
      "0m" => "Man5-Dora.svg",
      "1m" => "Man1.svg",
      "2m" => "Man2.svg",
      "3m" => "Man3.svg",
      "4m" => "Man4.svg",
      "5m" => "Man5.svg",
      "6m" => "Man6.svg",
      "7m" => "Man7.svg",
      "8m" => "Man8.svg",
      "9m" => "Man9.svg",
      "0p" => "Pin5-Dora.svg",
      "1p" => "Pin1.svg",
      "2p" => "Pin2.svg",
      "3p" => "Pin3.svg",
      "4p" => "Pin4.svg",
      "5p" => "Pin5.svg",
      "6p" => "Pin6.svg",
      "7p" => "Pin7.svg",
      "8p" => "Pin8.svg",
      "9p" => "Pin9.svg",
      "0s" => "Sou5-Dora.svg",
      "1s" => "Sou1.svg",
      "2s" => "Sou2.svg",
      "3s" => "Sou3.svg",
      "4s" => "Sou4.svg",
      "5s" => "Sou5.svg",
      "6s" => "Sou6.svg",
      "7s" => "Sou7.svg",
      "8s" => "Sou8.svg",
      "9s" => "Sou9.svg",
      "0z" => "Back.svg",
      "1z" => "Ton.svg",
      "2z" => "Nan.svg",
      "3z" => "Shaa.svg",
      "4z" => "Pei.svg",
      "5z" => "Haku.svg",
      "6z" => "Hatsu.svg",
      "7z" => "Chun.svg"
    }

    replacements = []

    tile_images_files.each do |tile_notation, tile_image_file|
      text_with_tiles.gsub!(
        tile_notation,
        "\x01" + tile_notation + "\x02"
      )

      replacements << image_tag("tiles/#{tile_image_file}", class: "inline tile bg-contain #{style}", alt: tile_notation)
    end

    replacements.each_with_index do |replacement, index|
      text_with_tiles.gsub!("\x01#{tile_images_files.keys[index]}\x02", replacement)
    end

    text_with_tiles.html_safe
  end

  def display_tiles_divs(text_with_tiles, style = "")
    tile_images_files = {
      "0m" => "Man5-Dora.svg",
      "1m" => "Man1.svg",
      "2m" => "Man2.svg",
      "3m" => "Man3.svg",
      "4m" => "Man4.svg",
      "5m" => "Man5.svg",
      "6m" => "Man6.svg",
      "7m" => "Man7.svg",
      "8m" => "Man8.svg",
      "9m" => "Man9.svg",
      "0p" => "Pin5-Dora.svg",
      "1p" => "Pin1.svg",
      "2p" => "Pin2.svg",
      "3p" => "Pin3.svg",
      "4p" => "Pin4.svg",
      "5p" => "Pin5.svg",
      "6p" => "Pin6.svg",
      "7p" => "Pin7.svg",
      "8p" => "Pin8.svg",
      "9p" => "Pin9.svg",
      "0s" => "Sou5-Dora.svg",
      "1s" => "Sou1.svg",
      "2s" => "Sou2.svg",
      "3s" => "Sou3.svg",
      "4s" => "Sou4.svg",
      "5s" => "Sou5.svg",
      "6s" => "Sou6.svg",
      "7s" => "Sou7.svg",
      "8s" => "Sou8.svg",
      "9s" => "Sou9.svg",
      "0z" => "Back.svg",
      "1z" => "Ton.svg",
      "2z" => "Nan.svg",
      "3z" => "Shaa.svg",
      "4z" => "Pei.svg",
      "5z" => "Haku.svg",
      "6z" => "Hatsu.svg",
      "7z" => "Chun.svg"
    }

    replacements = []

    tile_images_files.each do |tile_notation, tile_image_file|
      text_with_tiles.gsub!(
        tile_notation,
        "\x01" + tile_notation + "\x02"
      )

      replacements << image_tag("tiles/#{tile_image_file}", class: "inline tile bg-contain #{style}", alt: tile_notation)
    end

    replacements.each_with_index do |replacement, index|
      text_with_tiles.gsub!("\x01#{tile_images_files.keys[index]}\x02", "<div>#{replacement}</div>")
    end

    text_with_tiles.html_safe
  end
end
