# == Schema Information
#
# Table name: shortened_urls
#
#  id         :integer          not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true, uniqueness: true

  belongs_to :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id

  has_many :visits,
    class_name: "Visit",
    primary_key: :id,
    foreign_key: :shortened_url_id

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user



  def self.random_code
    random_code = SecureRandom.urlsafe_base64

    while ShortenedUrl.exists?(short_url: random_code)
      random_code = SecureRandom.urlsafe_base64
    end

    random_code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    short_url = self.random_code
    new_url = ShortenedUrl.create!(user_id: user.id, long_url: long_url, short_url: short_url)
    new_url
  end

  def num_clicks
    visitors.count
  end

  def num_uniques
    # visitors.select(:user_id).distinct.count
    visitors.count
  end

  def num_recent_uniques
    visitors.select(:user_id).distinct
    .where("visits.created_at > '#{10.minutes.ago.to_s(:db)}'").count
  end
end
