class CreateUrlLinks < ActiveRecord::Migration
  def change
    create_table :url_links do |t|
      t.text :orginal_url
      t.text :generated_url
      t.integer :hit_count, default: 0

      t.timestamps null: false
    end
  end
end
