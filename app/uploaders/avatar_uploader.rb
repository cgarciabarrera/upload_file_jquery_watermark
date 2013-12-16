class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  version :redes_sociales do
    process :resize_to_fit => [861,574]
    process :quality => 100

    version :grande do
      process :resize_to_fit => [861,574]
      process :quality => 80
      process :watermark
    end

    version :mediana do
      process :resize_to_fit => [504,336]
      process :quality => 60
      process :watermark
    end

    version :miniatura_rectangular do
      process :resize_to_fit => [106,71]
      process :quality => 60
    end

    version :miniatura_cuadrada do
      process :resize_to_fill => [96,96]
      process :quality => 100
    end



  end

  version :micro do
    process :resize_to_fit => [40,40]
    process :quality => 100
  end


  def watermark
    manipulate! do |img|
      logo = Magick::Image.read("#{Rails.root}/app/assets/images/watermark.png").first
      img = img.composite(logo, Magick::NorthWestGravity, 15, 0, Magick::OverCompositeOp)
    end

  end
end