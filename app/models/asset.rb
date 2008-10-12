class Asset < ActiveRecord::Base
  belongs_to :talk
  
  has_attachment :size => 0..5.megabytes, :storage => :file_system, :path_prefix => 'public/uploads/'
  
  validates_as_attachment
  
  
  def icon
    case content_type
    when "application/zip"
      "files/zip.png"
    when "application/pdf"
      "files/pdf.png"
    when /image/
      "files/pic.png"
    else
      "files/generic.png"
    end
  end
end
