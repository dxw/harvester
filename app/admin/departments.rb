ActiveAdmin.register Department do

  index do
    column :id
    column :name
    column :users do |department|
      raw(department.users.map do |u|
        link_to(u.email, admin_user_path(u.id))
      end.join(', '))
    end
    column :created_at
    column :updated_at
    default_actions
  end

  show do
    attributes_table do
      row :name
      row :users do
        raw(department.users.map do |u|
          link_to(u.email, admin_user_path(u.id))
        end.join(', '))
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :users
    end
    f.buttons
  end

  filter :name
  filter :created_at
  filter :updated_at
end
