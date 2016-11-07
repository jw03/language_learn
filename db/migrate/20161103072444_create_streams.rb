class CreateStreams < ActiveRecord::Migration[5.0]
  def change
    create_table :streams do |t|
    	t.string :rid
    	t.string :sid
    	t.integer :host_id
    	t.integer :guest_id
    	t.string :time_start
    	t.string :time_end
      t.timestamps
    end
  end
end
