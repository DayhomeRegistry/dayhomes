class AddCertificationTypes < ActiveRecord::Migration
  def change
    CertificationType.create :kind=>"Criminal Record Check"
    CertificationType.create :kind=>"Child Welfare Check"
  end
end
