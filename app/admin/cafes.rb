ActiveAdmin.register Cafe do
  permit_params :name, :description, :place_id, :address, :website, :latitude, :longitude, :weekday_text

  index do
    selectable_column
    id_column
    column :name
    column :description
    actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :place_id
      row :address
      row :website
      row :latitude
      row :longitude
      row :weekday_text
      row :images do |cafe|
        cafe.images.each do |image|
          span do
            image_tag url_for(image), width: 100
          end
        end
      end
    end
  end
end
