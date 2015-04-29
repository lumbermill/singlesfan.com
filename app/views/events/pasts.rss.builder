xml.instruct! :xml, :version => "1.0"
xml.rss("version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/") do
  xml.channel do
    xml.title "Singles Fan!"

    @events.each do |e|
      xml.item do
        xml.title e.opendate_short+" "+e.opentime_short(false)+" "+e.masters_name+"「"+e.title+"」"
        xml.description e.short_desc
        xml.pubDate e.opendate.to_datetime.to_s(:rfc822)
        xml.guid "#{@base}/events/#{e.id}"
        xml.link "#{@base}/events/#{e.id}"
        xml.image do
          xml.url "#{@base}/img/#{e.picture_id}"
        end
      end
    end
  end
end
