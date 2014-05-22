require 'digest/sha1'
class Picture < ActiveRecord::Base
belongs_to :timeline
end
