class FeedItemGenerator < Rails::Generator::Base 
  def manifest 
    record do |m| 
      m.file 'feed_item.rb', 'app/models/feed_item.rb'
      m.migration_template 'create_feed_items.rb', 'db/migrate' 
    end 
  end
  
  def file_name
    'create_feed_items'
  end
end
