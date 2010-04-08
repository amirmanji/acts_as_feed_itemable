module ActsAsFeedItemable
  module Shoulda
    
    def should_act_as_feed_itemable(options = {})
      klass = self.name.gsub(/Test$/, '').constantize
      
      context "#{klass.name} acting as a feed itemable" do
        should_have_one :feed_item
        
        should "respond to all the right methods" do
          [ "process_feed_item", "feed_item_eligible?" ].each do |method|
            assert klass.instance_methods.include?(method), "#{klass.name} does not respond to #{method}."
          end
        end
      end
      
      if options[:with_flag]
        flag = options[:with_flag]
        context "#{klass.name} acting as a feed itemable with flag '#{flag}'" do
          [ "#{flag}", "#{flag_was}" ].each do |method|
            assert klass.instance_methods.include?(method), "#{klass.name} does not respond to #{method}."
          end
        end
      end
      
    end
    
  end
end

Test::Unit::TestCase.extend(ActsAsFeedItemable::Shoulda)
