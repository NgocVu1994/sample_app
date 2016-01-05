class AddTimeEditToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :time_edit, :datetime
  end
end
