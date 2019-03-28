class ZoneCalculator
  InvalidZip = Class.new StandardError

  def self.call(origin_zip, destination_zip)
    distance = RegularDistance.find_by!(origin_zip: origin_zip, destination_zip: destination_zip)
    return distance.zone unless distance.exception?

    ExceptionDistance.find_by!(origin_zip: origin_zip, destination_zip: destination_zip).zone
  rescue ActiveRecord::RecordNotFound
    raise InvalidZip, 'Invalid zip provided'
  end
end
