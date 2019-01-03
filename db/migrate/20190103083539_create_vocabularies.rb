class CreateVocabularies < ActiveRecord::Migration[5.2]
  def change
    create_table :vocabularies do |t|
      t.string :word
      t.string :meaning
      t.integer :count

      t.timestamps
    end
  end
end
