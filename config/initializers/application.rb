APPLICATION_CONFIG = YAML.load_file("#{Rails.root}/config/application.yml")[Rails.env].with_indifferent_access
GMAPS_CONFIG = YAML.load_file("#{Rails.root}/config/gmaps.yml")[Rails.env].with_indifferent_access


