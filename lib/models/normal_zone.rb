module UspsZipZones
  class NormalZone < ActiveRecord::Base
    def self.by_zips!(origin_zip, destination_zip)
      find_by!(zip_from: origin_zip[0..2], zip_to: destination_zip[0..2])
    end
  end
end
