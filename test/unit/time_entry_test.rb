require 'test_helper'

class TimeEntryTest < ActiveSupport::TestCase

  should "not be able to delete locked entries" do
    entry = TimeEntry.find_by_status( TimeEntry::LOCKED )
    entry.destroy
    assert_nothing_raised { TimeEntry.find(entry.id) }
  end

  should "find 1 time_entry on day 1. july, 2009" do
    entries = TimeEntry.on_day( Date.new(2009,7,1) )
    assert_equal entries.size, 1
  end
  
  should "find no billed time_entries" do
    entries = TimeEntry.billed(true)
    assert_equal entries.size, 0
  end  
  
  should "find 2 time_entries between 1st and 2nd of july, 2009" do
    entries = TimeEntry.between( Date.new(2009,7,1), Date.new(2009,7,2) )
    assert_equal entries.size, 2
  end

  should "find hours for activity" do
    entries = TimeEntry.for_activity(activities(:timeflux_development).id)
    assert_operator entries.size, :>, 0
    assert_equal entries.size, activities(:timeflux_development).time_entries.size
  end

  should "find Bob´s hours" do
    entries = TimeEntry.for_user(users(:bob).id)
    assert_operator entries.size, :>, 0
    assert_equal entries.size, users(:bob).time_entries.size
  end
  
  context "notes length validation" do
    setup do
      params = {:user => users(:bob), :hours => 7.5, :hour_type => hour_types(:normaltid), 
        :activity => activities(:timeflux_development), :date => Date.today }
      @time_entry = TimeEntry.new(params)
    end
  
    should "permit saving time entry with notes containing 500 characters" do
      @time_entry.notes = "abcdefghij" * 50
      assert(@time_entry.save) 
    end
  
    should "not permit saving time entry where notes has more than 500 characters" do
      @time_entry.notes = ("abcdefghij" * 50) + "a" # 501 characters
      assert(!@time_entry.save) 
    end 
  end
  
end