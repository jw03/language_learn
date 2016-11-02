class CreateUserLearnLanguages < ActiveRecord::Migration[5.0]
  def change
    create_table :user_learn_languages do |t|
      t.belongs_to :user, index: true
      t.belongs_to :learn_language, index: true

      t.timestamps
    end

  end
end
