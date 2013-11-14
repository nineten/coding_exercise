class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :fb_url
      t.string :description
      t.string :submitter_name
      t.string :submitter_email

      t.timestamps
    end
  end
end
