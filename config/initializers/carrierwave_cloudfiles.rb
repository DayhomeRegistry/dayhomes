# SNET Note:
# https://github.com/jnicklas/carrierwave/wiki/How-To:-Use-Rackspace-ServiceNet-(snet)-to-transfer-from-CloudServer-to-CloudFiles
cloudfiles_config = YAML.load_file("#{Rails.root}/config/rackspace_cloudfiles.yml")[Rails.env].with_indifferent_access
Rails.configuration.use_fog = cloudfiles_config[:use_fog] || false

CarrierWave.configure do |config|
  # Setting asset_host overrides path in the the local file storage
  if Rails.configuration.use_fog
    config.fog_credentials = {
      :provider             => 'Rackspace',
      :rackspace_username   => cloudfiles_config[:username],
      :rackspace_api_key    => cloudfiles_config[:api_key],
      :rackspace_servicenet => cloudfiles_config[:servicenet] || false, # NOTE - Can only be used on rackspace VPS, see SNET note at top.
      :rackspace_region     => cloudfiles_config[:region]||:dfw # we're in dfw, but may not be
    }

    config.fog_directory = cloudfiles_config[:container]


    config.asset_host = cloudfiles_config[:cdn_url]
  end

  # hack fix for windows machine due to tmp file permission error
  # per https://github.com/jnicklas/carrierwave/issues/220/
  if ENV['RAILS_ENV'] != 'production' || ENV['RAILS_ENV'] != 'test'
    config.delete_tmp_file_after_storage = false
  end
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/