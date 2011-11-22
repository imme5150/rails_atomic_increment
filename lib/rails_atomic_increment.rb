class ActiveRecord::Base
  
  # These methods are to update counters atomically so we don't have any issues with counters being off because of concurrent increment or decriment requests
  
  def atomic_increment!(attribute, by = 1, reload = false)
    self.update_counters!({attribute => by}, reload)
  end
  
  def atomic_decrement!(attribute, by = 1, reload = false)
    by = -by #invert the sign so we're subtracting the passed in value from the current value
    self.update_counters!({attribute => by}, reload)
  end
  
  # this expects an array of counter attributes to update and turns it into a hash to pass to update_counters
  def increment_counters!(counters, reload = false)
    self.update_counters!(counters.inject({}) {|h,c| h.merge(c => 1)}, reload)
  end
  
  # this expects an array of counter attributes to update and turns it into a hash to pass to update_counters
  def decrement_counters!(counters, reload = false)
    self.update_counters!(counters.inject({}) {|h,c| h.merge(c => -1)}, reload)
  end
  
  def update_counters!(counters, reload = false)
    counters.each do |attribute, value|
      raise "attribute '#{attribute}' can NOT be incremented because it was already changed and that change will be lost." if !new_record? && changed_attributes[attribute.to_s]
      self[attribute] ||= 0
      self[attribute] += value
      @changed_attributes.delete(attribute.to_s) unless new_record? # mark this column as unchanged so it won't get updated in the DB if a save is performed on the object!
    end
    if new_record?
      self.save
    else
      self.class.update_counters(self.id, counters)
    end
    self.reload if reload # if we care about the new numbers in the db after the update
  end
  
  # this is for database table maintenance - May only work on MySQL? Vacuum for Postgres
  def self.optimize_table
    connection.execute("OPTIMIZE TABLE #{quoted_table_name}")
  end
  
end