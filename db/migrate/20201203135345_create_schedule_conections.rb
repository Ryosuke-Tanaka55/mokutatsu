class CreateScheduleConections < ActiveRecord::Migration[6.0]
  def change
    create_table :schedule_conections, :force => true, id: false do |t|
      t.belongs_to :schedule

    end
  end
end
