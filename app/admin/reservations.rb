ActiveAdmin.register Reservation do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :code, :guests, :currency, :price, :checkin_date, :checkout_date, :user_id, :hotel_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:code, :guests, :currency, :price, :checkin_date, :checkout_date, :user_id, :hotel_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
