class GrantAccess < ActiveRecord::Migration[5.2]
  def change
    execute('GRANT INSERT, SELECT ON rugmi_production.users TO rugmi@\'%\'')
    execute('GRANT INSERT, SELECT ON rugmi_production.images TO rugmi@\'%\'')
    execute('FLUSH PRIVILEGES')
  end
end
