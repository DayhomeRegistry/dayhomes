# create certification types
CertificationType.create!({:kind => 'Child Care Level 1'})
CertificationType.create!({:kind => 'Child Care Level 2'})
CertificationType.create!({:kind => 'Child Care Level 3'})
CertificationType.create!({:kind => 'Basic First Aid'})
CertificationType.create!({:kind => 'Advanced First Aid'})
CertificationType.create!({:kind => 'Infant CPR'})
CertificationType.create!({:kind => 'Criminal Record Check'})
CertificationType.create!({:kind => 'Child Welfare Check'})

# create availability types
AvailabilityType.create!({:availability => 'Full-time', :kind => 'Full Days'})
AvailabilityType.create!({:availability => 'Full-time', :kind => 'After School'})
AvailabilityType.create!({:availability => 'Full-time', :kind => 'Before School'})
AvailabilityType.create!({:availability => 'Part-time', :kind => 'Full Days'})
AvailabilityType.create!({:availability => 'Part-time', :kind => 'Morning'})
AvailabilityType.create!({:availability => 'Part-time', :kind => 'Afternoon'})
AvailabilityType.create!({:availability => 'Part-time', :kind => 'After School'})
AvailabilityType.create!({:availability => 'Part-time', :kind => 'Before School'})

# create Privacy policy 
PrivacyPolicy.create!({:effective_date=> Time.now, :version=>"1.0"})

Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)
