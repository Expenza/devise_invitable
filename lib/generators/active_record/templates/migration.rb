class DeviseInvitableAddTo<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    change_table :<%= table_name %> do |t|
      t.string   :invitation_token, :limit => 60
      t.datetime :invitation_sent_at
      t.integer  :invitation_count
      t.integer  :invited_by_id
      t.index    :invitation_token # for invitable
      t.index    :invited_by_id
    end
    
    # And allow null encrypted_password and password_salt:
    change_column_null :<%= table_name %>, :encrypted_password, true
<% if class_name.constantize.columns_hash['password_salt'] -%>
    change_column_null :<%= table_name %>, :password_salt,      true
<% end -%>
  end
  
  def self.down
    remove_column :<%= table_name %>, :invited_by_id
    remove_column :<%= table_name %>, :invitation_count
    remove_column :<%= table_name %>, :invitation_sent_at
    remove_column :<%= table_name %>, :invitation_token
  end
end
