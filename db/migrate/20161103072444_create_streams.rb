class CreateStreams < ActiveRecord::Migration[5.0]
  def change
    create_table :streams do |t|
    	t.string :host_id
    	t.string :guest_id
    	t.string :duration

      t.timestamps
    end
  end
end
