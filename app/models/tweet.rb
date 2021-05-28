class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :tweet_hash_tags
    has_many :hash_tags, through: :tweet_hash_tags
    validates :content, presence: true
    after_commit :create_hash_tags, on: :create
    has_many :retweets, class_name: 'Tweet', foreign_key: 'rt_ref', dependent: :destroy
    
    def create_hash_tags
        extract_name_hash_tags.each do |name|
          hash_tags.create(name: name)
        end
    end

    def extract_name_hash_tags
        content.to_s.scan(/#\w+/).map{|name| name.gsub("#", "")}
    end

    def retweet_ref
        Tweet.find(self.rt_ref)
    end

    
end
