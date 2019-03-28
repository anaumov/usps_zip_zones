module UspsZipZones
end

class ZoneCalculator
  InvalidZip = Class.new StandardError

  def self.call(origin_zip, destination_zip)
    zone = UspsZipZones::NormalZone.by_zips!(origin_zip, description_zip)
    return zone.value unless distance.exception?

    zone = UspsZipZones::ExceptionZone.by_zips!(origin_zip, destination_zip)
    zone.value
  rescue ActiveRecord::RecordNotFound
    raise InvalidZip, 'Invalid zip provided'
  end
end
