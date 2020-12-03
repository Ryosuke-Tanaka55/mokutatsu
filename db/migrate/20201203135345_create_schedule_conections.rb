class CreateScheduleConections < ActiveRecord::Migration[6.0]
  def change
    create_table :schedule_conections do |t|
      t.references :schedule, null: false, foreign_key: true

      t.timestamps
    end
  end
end
