module UsersHelper
  
  def twitter_profile(user)
    user.twitter_url ? "<strong>Twitter:</strong> #{link_to user.twitter_url, user.twitter_url}" : ""
  end
  
	def delicious_profile(user)
	  user.delicious_url ? "<strong>Delicious:</strong> #{link_to user.delicious_url, user.delicious_url}" : ""
  end
  
	def personal_url(user)
	  user.main_url ? "<strong>Personal URL:</strong> #{link_to user.main_url, user.main_url}" : ""
  end
  
	def company(user)
	  "<strong>Company:</strong> #{h user.company}" if !user.company.blank?
  end
  
	def bio(user)
	  "<strong>Bio:</strong> #{textilize user.bio}" if !user.bio.blank?
  end
  
end
