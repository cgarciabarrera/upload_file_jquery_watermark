class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  version :redes_sociales do

    process :resize_to_limit => [860, 860]
    process :quality => 100
    process :sharp
  end


  version :grande, :from_version => :redes_sociales do
    process :resize_to_limit => [860, 860]
    process :quality => 85
    process :watermarkgrande
    process :sharp
  end

  version :mediana, :from_version => :redes_sociales do
    process :resize_to_limit => [504,336]
    process :quality => 92
    process :watermarkmediana
    process :sharp
  end

  version :miniatura_rectangular, :from_version => :redes_sociales do
    process :resize_to_limit => [106,71]
    process :quality => 60
    process :sharp
  end

  version :miniatura_cuadrada do
    process :resize_to_fill => [96,96]
    process :quality => 70
    process :sharp
  end


  def watermarkgrande
    manipulate! do |img|
      logo = Magick::Image.read("#{Rails.root}/app/assets/images/watermarkg.png").first
      img = img.composite(logo, Magick::NorthWestGravity, 0, 0, Magick::OverCompositeOp)
    end

  end

  def watermarkmediana
    manipulate! do |img|
      logo = Magick::Image.read("#{Rails.root}/app/assets/images/watermarkm.png").first
      img = img.composite(logo, Magick::NorthWestGravity, 0, 0, Magick::OverCompositeOp)
    end

  end


  def sharp
    manipulate! do |img|
      img = img.unsharp_mask(1,1,0.2,1)
    end

  end


end