class AddMonthScoreAndWeekScoreToUsers < ActiveRecord::Migration
  def change
    add_column :users, :month_score, :integer, default: 0 
    add_column :users, :week_score, :integer, default: 0
  end
end
