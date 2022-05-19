ActiveAdmin.register Hotel do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :hotelId, :citycode, :name, :latitude, :longitude, :address, :description, :amenities, :city_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:hotelId, :citycode, :name, :latitude, :longitude, :address, :description, :amenities, :city_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
