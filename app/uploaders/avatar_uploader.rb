class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process :resize_to_fit => [100,100]
    process :quality => 100
  end

  version :thumb2 do
    process :resize_to_fit => [500,500]
    process :quality => 100
    process :watermark
  end

  version :thumb3 do
    process :resize_to_fit => [500,500]
    process :quality => 50
  end


  def watermark
    manipulate! do |img|
      logo = Magick::Image.read("#{Rails.root}/app/assets/images/watermark.png").first
      img = img.composite(logo, Magick::NorthWestGravity, 15, 0, Magick::OverCompositeOp)
    end
  end
end