# frozen_string_literal: true

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.in? %w[development test]
    storage :file
  else
    storage :fog
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*_args)
    ActionController::Base.helpers.asset_path('fallback/' + [version_name, 'default.png'].compact.join('_'))
  end

  process resize_to_fit: [600, 800]

  version :little do
    process resize_to_fit: [200, 200]
  end

  version :thumb do
    process resize_to_fit: [100, 100]
  end

  def extension_whitelist
    %w[jpg gif png]
  end
end
