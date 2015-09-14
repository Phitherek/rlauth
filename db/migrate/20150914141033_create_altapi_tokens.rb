class CreateAltapiTokens < ActiveRecord::Migration
  def change
    create_table :altapi_tokens do |t|
      t.string :token, null: false
      t.belongs_to :user, null: false
      t.timestamps null: false
    end
  end
end
