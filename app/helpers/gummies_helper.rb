module GummiesHelper
  def flavor_name(gummy)
    Flavor.find_by(id: gummy.flavor_id_1).name
  end

  def maker_name(gummy)
    Maker.find_by(id: gummy.maker_id).name
  end
end
