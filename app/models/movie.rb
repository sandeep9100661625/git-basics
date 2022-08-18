class Movie < ApplicationRecord
    validates :movie_name, presence: true, length: {minimum:2, maximum: 50 }
    validates :director, presence: true,length: {minimum:3, maximum: 50}
end
