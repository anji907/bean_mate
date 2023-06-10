ActiveAdmin.register User do
  permit_params :nickname, :email, :role, :bio, :sns_identifier

  index do
    selectable_column
    id_column
    column :nickname
    column :email
    column :role
    column :bio
    column :sns_identifier
    actions
  end
end
