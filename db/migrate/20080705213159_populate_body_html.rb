class PopulateBodyHtml < ActiveRecord::Migration
  def self.up
    for c in Comment.find(:all)
      c.save!
    end
    
    for p in Post.find(:all)
      p.save!
    end
    
    for t in Talk.find(:all)
      t.save!
    end
  end

  def self.down
  end
end
