class AddPublicationToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :publication, :string
  end
end
