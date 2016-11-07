class CreateLearnLanguagesUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :learn_languages_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :learn_language, index: true

      t.timestamps
    end

  end
end
