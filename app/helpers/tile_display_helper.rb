# frozen_string_literal: true

module TileDisplayHelper
  def display_tiles(text_with_tiles, style)
    tile_images = {
      '0m' => 'tiles/Man5-Dora.svg',
      '1m' => 'tiles/Man1.svg',
      '2m' => 'tiles/Man2.svg',
      '3m' => 'tiles/Man3.svg',
      '4m' => 'tiles/Man4.svg',
      '5m' => 'tiles/Man5.svg',
      '6m' => 'tiles/Man6.svg',
      '7m' => 'tiles/Man7.svg',
      '8m' => 'tiles/Man8.svg',
      '9m' => 'tiles/Man9.svg',
      '0p' => 'tiles/Pin5-Dora.svg',
      '1p' => 'tiles/Pin1.svg',
      '2p' => 'tiles/Pin2.svg',
      '3p' => 'tiles/Pin3.svg',
      '4p' => 'tiles/Pin4.svg',
      '5p' => 'tiles/Pin5.svg',
      '6p' => 'tiles/Pin6.svg',
      '7p' => 'tiles/Pin7.svg',
      '8p' => 'tiles/Pin8.svg',
      '9p' => 'tiles/Pin9.svg',
      '0s' => 'tiles/Sou5-Dora.svg',
      '1s' => 'tiles/Sou1.svg',
      '2s' => 'tiles/Sou2.svg',
      '3s' => 'tiles/Sou3.svg',
      '4s' => 'tiles/Sou4.svg',
      '5s' => 'tiles/Sou5.svg',
      '6s' => 'tiles/Sou6.svg',
      '7s' => 'tiles/Sou7.svg',
      '8s' => 'tiles/Sou8.svg',
      '9s' => 'tiles/Sou9.svg',
      '0z' => 'tiles/Back.svg',
      '1z' => 'tiles/Ton.svg',
      '2z' => 'tiles/Nan.svg',
      '3z' => 'tiles/Shaa.svg',
      '4z' => 'tiles/Pei.svg',
      '5z' => 'tiles/Haku.svg',
      '6z' => 'tiles/Hatsu.svg',
      '7z' => 'tiles/Chun.svg',
    }

    tile_images.each do |tile_label, tile_image|
      text_with_tiles.gsub!(tile_label, image_tag(tile_image, class: "inline tile bg-contain #{style}"))
    end

    text_with_tiles.html_safe
  end
end
