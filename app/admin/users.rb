ActiveAdmin.register User do

  menu priority: 1

  form do |f|
    f.inputs "Details" do
      f.input :email
      f.input :password
    end
    f.buttons
  end

  # Everything below this line is to hide encrypted_password

  sections = %w[
    id
    email
    sign_in_count
    current_sign_in_at
    last_sign_in_at
    current_sign_in_ip
    last_sign_in_ip
    created_at
    updated_at
  ].map{|s|s.to_sym}

  index do
    sections.each do |s|
      column s
    end
    default_actions
  end

  show do
    attributes_table do
      sections.each do |s|
        row s
      end
    end
    active_admin_comments
  end

  sections.each do |s|
    filter s unless s == :id
  end

  csv do
    sections.each do |s|
      column s
    end
  end
end
