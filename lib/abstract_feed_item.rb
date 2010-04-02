class AbstractFeedItem < ActiveRecord::Base
  self.abstract_class = true
  
  DISPLAY_LIMIT = 10
  
  belongs_to :item, :polymorphic => true
  belongs_to :user
  belongs_to :user_target, :class_name => 'User'
  has_many :feeds, :dependent => :destroy
  
  validates_presence_of :item, :user
  
  named_scope :for_user, lambda { |user_id| { :conditions => [ "user_id = ? OR user_target_id = ?", user_id, user_id ], :order => 'created_at desc' } }
  
  after_create :create_feed
  
  def create_feed
    Feed.create(:user => user, :feed_item => self)
    Feed.create(:user => user_target, :feed_item => self) if (user_target && (user_target != user))
    Delayed::Job.enqueue(GenerateFeedsJob.new(self.id))
  end
  
end