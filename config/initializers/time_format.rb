{
  :short_date => '%x',
  :long_date  => lambda { |time| time.strftime("%A, %B #{time.day.ordinalize} %Y") },
  :simple    => '%m/%d/%Y',
  :descriptive => '%A, %d %B, %Y' # Saturday, 24 December, 2011
}.each do |k, v|
  Time::DATE_FORMATS.update(k => v)
end
