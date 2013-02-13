module OrganizationHelper
	def json_date_to_js_date(jsonDate)
		return  DateTime.parse(jsonDate.to_s)
	end
end
