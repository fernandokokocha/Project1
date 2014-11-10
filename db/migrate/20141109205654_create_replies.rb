class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :content
			t.belongs_to :announcement
			t.belongs_to :user

      t.timestamps
    end
  end
end
