module UspsZipZones
  class NormalZoneParser
    def self.parse_line(line)
      result = []
      origin_zip = line[0..2]
      line[3..-1].scan(/.{2}/).each_with_index do |el, index|
        destination_zip = (index + 1).to_s.rjust(3, '0')
        zone = el[0]
        filter = el[1]
        is_exception = !!filter.match(/[1abe]/)
        result << "('#{origin_zip}', '#{destination_zip}', #{zone}, #{is_exception}, '#{filter}')"
      end

      result
    end
  end
end
