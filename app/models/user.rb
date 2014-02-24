require 'json'

class User < ActiveRecord::Base
  has_many :answers
  has_many :questions
  has_many :votes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :oauth_token, :oauth_expires_at
  # attr_accessible :title, :body

  def voted_questions
    votes_for_questions = self.votes.where(voteable_type: "Question")
    votes_for_questions.map { |vote| Question.find(vote.voteable_id) }
  end

  def voted_answers
    votes_for_answers = self.votes.where(voteable_type: "Answer")
    votes_for_answers.map { |vote| Answer.find(vote.voteable_id) }
  end

  def self.find_for_facebook_oauth(auth)
    p "*" * 100
    p Time.at(auth.credentials.expires_at)
    where(auth.slice(:provider, :uid)).first_or_create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
  rescue
    logger.info e.to_s
    nil
  end

  def friends_in_city(city)
    friend_array = self.facebook.get_connection('me', 'friends?fields=id,name,location')
    friend_array.select { |f| f['location']['name'].split(',').first == city if f['location']}
  end

  def all_friend_coords
    friend_array = self.facebook.get_connection('me', 'friends?fields=id,name,location')
    location_array = friend_array.map { |f| f['location']['name'].split(',').first  if f['location'] }.uniq
    city_array = City.pluck(:name)
    filtered_cities = location_array & city_array
    city_objects = filtered_cities.map { |city| City.find_by_name(city) }
    city_info_hash = {}
    city_objects.each { |city| city_info_hash[city.name] = { info: { lat: city.lat, long: city.long, friends: [] } } }

    friend_array.each do |f|
      location = ""
      location = f['location']['name'].split(',').first if f['location']
      if filtered_cities.include?(location)
        city_info_hash[location][:info][:friends] << { name: f['name'], id: f['id'] }
      end
    end
    city_info_hash
  end
end
