require 'test_helper'

class ActsAsFeedItemableTest < Test::Unit::TestCase
  load_schema
  
  def setup
    @user = User.create(:username => 'Tupac Shakur')
  end
  
  def teardown
    User.destroy_all
    Waffle.destroy_all
    Pancake.destroy_all
    FeedItem.destroy_all
  end
  
  def test_create
    waffle = Waffle.create(:user => @user).reload
    pancake = Pancake.create(:user => @user).reload
    
    assert waffle.feed_item
    assert_nil pancake.feed_item
    assert_equal 1, FeedItem.count
    assert_equal 1, @user.feed_items.count
  end
  
  def test_updating
    waffle = Waffle.create(:user => @user).reload
    
    original_count = FeedItem.count

    waffle.update_attribute(:tasty, true)
    
    assert_equal original_count, FeedItem.count
  end
  
  def test_destroy
    waffle = Waffle.create(:user => @user).reload.destroy
    pancake = Pancake.create(:user => @user).reload.destroy
    
    assert_equal 0, FeedItem.count
    assert_equal 0, @user.feed_items.count
  end
  
  def test_create_with_flag
    pancake = Pancake.create(:user => @user, :tasty => true).reload
    
    assert pancake.feed_item
    assert_equal 1, FeedItem.count
    assert_equal 1, @user.feed_items.count
  end
  
  def test_update_generation_with_flag
    pancake = Pancake.create(:user => @user).reload
    
    original_count = FeedItem.count
    
    pancake.update_attribute(:tasty, true)
    
    assert_equal original_count + 1, FeedItem.count
  end
  
  def test_update_destruction_with_flag
    pancake = Pancake.create(:user => @user, :tasty => true).reload
    
    original_count = FeedItem.count
    
    pancake.update_attribute(:tasty, false)
    
    assert_equal original_count - 1, FeedItem.count
  end
  
  def test_destroy_with_flag
    pancake = Pancake.create(:user => @user, :tasty => true).reload.destroy
    
    assert_equal 0, FeedItem.count
    assert_equal 0, @user.feed_items.count
  end
  
end