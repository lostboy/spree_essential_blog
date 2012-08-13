class Spree::PostImage < Spree::Asset

  attr_accessible :alt, :attachment

  validates_attachment_presence :attachment

  has_attached_file :attachment,
    :styles => { :mini => '48x48>', :medium => '427x287>', :hero => '720x430#', 
      :hub_thumb => "95x65#", :hub_info => "245x180#", :small => '150x150>', :large => '900x650>' },
    :default_style => :medium,
    :url => '/spree/posts/:id/:style/:basename.:extension',
    :path => ':rails_root/public/spree/posts/:id/:style/:basename.:extension'

  if Spree::Config[:use_s3]
    s3_creds = { :access_key_id => Spree::Config[:s3_access_key], :secret_access_key => Spree::Config[:s3_secret], :bucket => Spree::Config[:s3_bucket] }
    self.attachment_definitions[:attachment][:storage] = :s3
    self.attachment_definitions[:attachment][:s3_credentials] = s3_creds
    self.attachment_definitions[:attachment][:s3_headers] = ActiveSupport::JSON.decode(Spree::Config[:s3_headers])
    self.attachment_definitions[:attachment][:bucket] = Spree::Config[:s3_bucket]
  end
    
end
