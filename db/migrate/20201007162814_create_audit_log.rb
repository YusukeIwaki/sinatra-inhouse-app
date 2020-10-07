class CreateAuditLog < ActiveRecord::Migration[6.0]
  def up
    create_table :audit_logs do |t|
      t.string :subject, null: false
      t.text :description
      t.datetime :created_at, index: true, null: false
    end
  end

  def down
    drop_table :audit_logs
  end
end
