class AddMainEvent < ActiveRecord::Migration
  def self.up
    Event.create :name => "Barcamp Portugal 2008", :alias => "barcamppt08", :description => "A acontecer em Coimbra, a 6 e 7 de Setembro de 2008."
  end

  def self.down
  end
end
