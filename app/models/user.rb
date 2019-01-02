class User < ActiveRecord::Base
  has_many :tweets

  def slug
    if self.username.include?(' ')
      camel_slug = self.username.gsub " ", "-"
      camel_slug.downcase
    else
      self.username.downcase
    end
  end

  def self.find_by_slug(slug)
    if slug.include?('-')
      name = slug.gsub "-", " "
      matching_artist = Artist.find{ |artist| artist.name.downcase == name }
    else
      matching_artist = Artist.find{ |artist| artist.name.downcase == slug }
    end
  end
end
