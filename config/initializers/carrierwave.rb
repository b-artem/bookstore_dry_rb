# frozen_string_literal: true

if Rails.env.in? %w[development test]
  CarrierWave.configure do |config|
    config.storage = :file
  end
else
  CarrierWave.configure do |config|
    config.ignore_integrity_errors = false
    config.ignore_processing_errors = false
    config.ignore_download_errors = false

    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    }
    config.fog_directory  = ENV['FOG_DIRECTORY']
    config.fog_public     = false
  end
end

if Rails.env.test? || Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.enable_processing = false
  end
end
