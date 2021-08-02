module UsersHelper
  def reviewed_gummy_flavor(review)
    Flavor.find_by(id: review.gummy.flavor_id_1).name
  end

  def posted_spot_gummy_flavor(spot)
    Flavor.find_by(id: spot.gummy.flavor_id_1).name
  end
end
