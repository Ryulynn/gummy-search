module UsersHelper
  def reviewed_gummy_flavor(review)
    Flavor.find_by(id: review.gummy.flavor_id_1).name
  end

  def posted_spot_gummy_flavor(spot)
    Flavor.find_by(id: spot.gummy.flavor_id_1).name
  end

  def posted_gummy_spot_by_you(gummy_id, user_id)
    Spot.where(gummy_id: gummy_id, user_id: user_id)
  end
end
