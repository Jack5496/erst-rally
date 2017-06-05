module StationsHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(station)
    gravatar_id = Digest::MD5::hexdigest(station.name.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: station.name, class: "gravatar")
  end
end