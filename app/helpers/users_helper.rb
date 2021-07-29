module UsersHelper
  def reviewed_gummy(review)
    Gummy.find_by(id: review.gummy_id)
  end

  def reviewed_gummy_flavor(review)
    Flavor.find_by(id: reviewed_gummy(review).flavor_id_1).name
  end
end
