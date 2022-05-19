# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    #div class: "blank_slate_container", id: "dashboard_default_message" do
      #span class: "blank_slate" do
      #  span I18n.t("active_admin.dashboard_welcome.welcome")
      #  small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #  end
    #end

    # Here is an example of a simple dashboard with columns and panels.
    #
     columns do
       column do
         panel "Recent Users" do
           ul do
            User.all.limit(5).reverse.map do |user|
               li link_to(user.username, admin_user_path(user))
             end
           end
         end
      end

       column do
         panel "Recent Reservations" do
           ul do
            Reservation.all.limit(5).reverse.map do |reservation|
               li link_to(reservation.hotel.name, admin_reservation_path(reservation))
             end
         end
       end
     end


end # content
 columns do
column do
  panel "Recent Users" do
    line_chart User.group_by_hour(:created_at).count
  end
  end
  column do
    panel "Recent Reservations" do
      line_chart Reservation.group_by_hour(:created_at).count
    end
  end
end
end
end
