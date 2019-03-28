module UspsZipZones
  class ExceptionZone < ActiveRecord::Base
    def self.by_zips!(origin_zip, destination_zip)
      where('zip_from @> ? AND zip_to @> ?', origin_zip.to_i, destination_zip.to_i).last!
    end
  end
end
