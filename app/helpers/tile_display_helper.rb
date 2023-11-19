# frozen_string_literal: true

module TileDisplayHelper
  def display_tiles(text_with_tiles, style)
    tile_images_files = {
      '0m' => 'Man5-Dora.svg',
      '1m' => 'Man1.svg',
      '2m' => 'Man2.svg',
      '3m' => 'Man3.svg',
      '4m' => 'Man4.svg',
      '5m' => 'Man5.svg',
      '6m' => 'Man6.svg',
      '7m' => 'Man7.svg',
      '8m' => 'Man8.svg',
      '9m' => 'Man9.svg',
      '0p' => 'Pin5-Dora.svg',
      '1p' => 'Pin1.svg',
      '2p' => 'Pin2.svg',
      '3p' => 'Pin3.svg',
      '4p' => 'Pin4.svg',
      '5p' => 'Pin5.svg',
      '6p' => 'Pin6.svg',
      '7p' => 'Pin7.svg',
      '8p' => 'Pin8.svg',
      '9p' => 'Pin9.svg',
      '0s' => 'Sou5-Dora.svg',
      '1s' => 'Sou1.svg',
      '2s' => 'Sou2.svg',
      '3s' => 'Sou3.svg',
      '4s' => 'Sou4.svg',
      '5s' => 'Sou5.svg',
      '6s' => 'Sou6.svg',
      '7s' => 'Sou7.svg',
      '8s' => 'Sou8.svg',
      '9s' => 'Sou9.svg',
      '0z' => 'Back.svg',
      '1z' => 'Ton.svg',
      '2z' => 'Nan.svg',
      '3z' => 'Shaa.svg',
      '4z' => 'Pei.svg',
      '5z' => 'Haku.svg',
      '6z' => 'Hatsu.svg',
      '7z' => 'Chun.svg',
    }

    tile_images_files.each do |tile_label, tile_image_file|
      text_with_tiles.gsub!(tile_label, image_tag("tiles/#{tile_image_file}", class: "inline tile bg-contain #{style}"))
    end

    text_with_tiles.html_safe
  end
end
