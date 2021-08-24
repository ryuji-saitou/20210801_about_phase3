ActiveAdmin.register User do

  index do
    column :id
    column :user_name
    column :user_name_id
    column :created_at
    column :updated_at
    actions
  end

  permit_params(
    # ▼20210824追記 - 記述することでactiveadmin内でemailを編集可能になった
    :email,
    # ▲
    :user_name,
    :user_name_id,
    :profile_image,
    :profile_introduction,
    :profile_sns_link,
    :birthday,
    :is_delete
  )

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :user_name, :user_name_id, :birthday, :profile_image_id, :profile_introduction, :profile_sns_link, :is_deleted
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :user_name, :user_name_id, :birthday, :profile_image_id, :profile_introduction, :profile_sns_link, :is_deleted]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
