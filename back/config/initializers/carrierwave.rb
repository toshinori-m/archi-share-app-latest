require 'carrierwave/storage/file'

CarrierWave.configure do |config|
  config.asset_host = 'http://localhost:3000'
  config.cache_storage = :file
end
