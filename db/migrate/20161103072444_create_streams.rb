class CreateStreams < ActiveRecord::Migration[5.0]
  def change
    create_table :streams do |t|
    	t.string :rid
    	t.string :sid
      t.timestamps
    end
  end
end
