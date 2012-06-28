APPLICATION_CONFIG = YAML.load_file("#{Rails.root}/config/application.yml")[Rails.env].with_indifferent_access

