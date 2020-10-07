class AuditLog < ActiveRecord::Base
  validates :subject, presence: true
end
